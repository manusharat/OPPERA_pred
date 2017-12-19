setwd("C:/Users/avb14/Documents/prediction")

# source("https://bioconductor.org/biocLite.R")
# biocLite() 
# biocLite("GWASTools", lib="C:/Rlibrary")

library(SNPRelate)
library(GWASTools)




#setwd("C:/Users/avb14/Documents/prediction")

# source("https://bioconductor.org/biocLite.R")
# biocLite()
# biocLite("GWASTools", lib="C:/Rlibrary")

# library(gdsfmt, lib="./Rlibs")
# library(SNPRelate, lib="./Rlibs")
# library(GWASTools)


# Prunning settings
# --bfile subjects_copy/Diatchenko_TMJD_TOP_subject_level
# --indep 50 5 2
# --memory 20000
# --out created_files/pruned/allgen
# --recode

# PLINK BED files
# bed.fn <- "E:/McGill_data/oppera/uw_gwas/plink/subjects_copy/Diatchenko_TMJD_TOP_subject_level.bed"
# fam.fn <- "E:/McGill_data/oppera/uw_gwas/plink/subjects_copy/Diatchenko_TMJD_TOP_subject_level.fam"
# bim.fn <- "E:/McGill_data/oppera/uw_gwas/plink/subjects_copy/Diatchenko_TMJD_TOP_subject_level.bim"


# extract pruned SNPs
# --extract created_files/pruned/allgen.prune.in
# --file created_files/pruned/allgen
# --out created_files/pruned/pruneddata
# --recode AD


# start here if rerunning

(gds <- GdsGenotypeReader("subsetData.gds"))
#close(gds)

scanID <- getScanID(gds)
family <- getVariable(gds, "sample.annot/family")
father <- getVariable(gds, "sample.annot/father")
mother <- getVariable(gds, "sample.annot/mother")
sex <- getVariable(gds, "sample.annot/sex")
sex[sex == ""] <- NA # sex must be coded as M/F/NA
phenotype <- getVariable(gds, "sample.annot/phenotype")

# fix empty vars
father <- c(1:3140)
mother <- c(1:3140)

scanAnnot <- ScanAnnotationDataFrame(data.frame(scanID,
                                                stringsAsFactors=FALSE))


snpID <- getSnpID(gds)
chromosome <- getChromosome(gds)
position <- getPosition(gds)
alleleA <- getAlleleA(gds)
alleleB <- getAlleleB(gds)
rsID <- getVariable(gds, "snp.rs.id")

snpAnnot <- SnpAnnotationDataFrame(data.frame(snpID, chromosome, position,
                                              rsID, alleleA, alleleB,stringsAsFactors=FALSE))
genoData <- GenotypeData(gds, scanAnnot=scanAnnot, snpAnnot=snpAnnot)


outcome <- read.delim("2015-11-05_phenotypes_data_dbgap.tsv")

idordered <- scanAnnot$scanID

idordered.df <- data.frame(idordered, stringsAsFactors = FALSE)
colnames(idordered.df) <- c("SUBJECT_ID2")

outcome$SUBJECT_ID2 <- as.character(outcome$SUBJECT_ID)

merged.status <- merge(idordered.df,
                       outcome[,c("SUBJECT_ID2",
                                  "OPPERA_SIMPLIFIED.INCIDENT_CASE_STATUS",
                                  "OPPERA_SIMPLIFIED.RACE",
                                  "CPSQ_SIMPLIFIED.FACE_PAIN_6M_AVERAGE",
                                  "OPPERA_SIMPLIFIED.GENDER",
                                  "RDC_SIMPLIFIED.PPT_TA_R",
                                  "RDC_SIMPLIFIED.PPT_TA_L",
                                  "RDC_SIMPLIFIED.PPT_MB_R",
                                  "RDC_SIMPLIFIED.PPT_MB_L",
                                  "RDC_SIMPLIFIED.PPT_TMJLP_R",
                                  "RDC_SIMPLIFIED.PPT_TMJLP_L",
                                  "RDC_SIMPLIFIED.PPT_TMUB_R",
                                  "RDC_SIMPLIFIED.PPT_TMUB_L",
                                  "RDC_SIMPLIFIED.PPT_LE_R",
                                  "RDC_SIMPLIFIED.PPT_LE_L",
                                  "OPPERA_SIMPLIFIED.BASELINE_CASE_STATUS",
                                  "OPPERA_SIMPLIFIED.SITE")],
                       by="SUBJECT_ID2", sort=FALSE, all.x=TRUE)

eigen.cov <- read.table("OPGWAS_sex-tmd-age-site-EV3.cov", header=TRUE)
eigen.cov$SUBJECT_ID2 <- as.character(eigen.cov$IID)
eigen.cov$EV1[eigen.cov$EV1 < (-2)] <- NA
eigen.cov$EV2[eigen.cov$EV2 < (-2)] <- NA
eigen.cov$EV3[eigen.cov$EV3 < (-2)] <- NA
merged.status <- merge(merged.status, eigen.cov[,12:15])

scanAnnot$id <- merged.status[,1]
scanAnnot$plink_pheno <- merged.status[,2]
scanAnnot$race <- factor(merged.status[,3])
scanAnnot$aver_pain <- merged.status[,4]
scanAnnot$pp_masset_r <- merged.status[,5]
scanAnnot$ppt.total <- apply(scale(merged.status[,c(6:11)]),1,mean)
scanAnnot$sex_num <- 1*(merged.status[,5]=='FEMALE')
scanAnnot$casecontrol <- merged.status[,16]
scanAnnot$site <- factor(merged.status[,17])
scanAnnot$ev1 <- merged.status[,18]
scanAnnot$ev2 <- merged.status[,19]
scanAnnot$ev3 <- merged.status[,20]

#remove site and race effects from PPT - get residuals

data1 <- data.frame(cbind(scanAnnot$ppt.total, scanAnnot$casecontrol,
                          scanAnnot$site, scanAnnot$sex_num, scanAnnot$ev1,
                          scanAnnot$ev2, scanAnnot$ev3))
colnames(data1) <- c("ppt.total","tmd","site","sex","ev1","ev2","ev3")

# data1$ppt.total.case <- data1$ppt.total
# data1$ppt.total.case[data1$tmd==0] <- NA
# data1$ppt.total.control <- data1$ppt.total
# data1$ppt.total.control[data1$tmd==1] <- NA
# 
# 
# 
# lm.fit.case <- lm(ppt.total.case ~ as.factor(site),
#              data = data1, na.action=na.exclude)
# lm.fit.control <- lm(ppt.total.control ~ as.factor(site),
#                   data = data1, na.action=na.exclude)
# res.case <- resid(lm.fit.case)
# res.control <- resid(lm.fit.control)
# res.case[is.na(res.case)] <- res.control[is.na(res.case)]
# 
# #summary(lm.fit)
# data1$res.cc <- res.case

# lm.fit.ev <- lm(ppt.total ~ ev1+ev2+ev3,
#                   data = data1, na.action=na.exclude)
# 
# 
# scanAnnot$ppt.total <- resid(lm.fit.ev)



genoData <- GenotypeData(gds, scanAnnot=scanAnnot, snpAnnot=snpAnnot)


White <- scanAnnot$scanID[scanAnnot$race=="WHITE"]
nonWhite <- scanAnnot$scanID[scanAnnot$race!="WHITE"]

length(White)
u <- runif(length(White))
train <- (u < 0.7)
White.train <- White[train]
length(White.train)
White.test <- White[!train]
length(White.test)

write.csv(White.train, "White_train.csv")
White.train <- read.csv("White_train.csv", stringsAsFactors = F)[,2]

write.csv(White.test, "White_test.csv")
White.test <- read.csv("White_test.csv", stringsAsFactors = F)[,2]


assoc <- assocRegression(genoData, outcome="ppt.total",
                         scan.exclude=c(White.test, nonWhite), LRtest=FALSE,
                         covar=c("sex_num"),
                         ivar="sex_num",
                         PPLtest=FALSE,
                         model.type="linear", gene.action = c("additive"))

write.csv(assoc, "assocPvals.csv")
assoc <- read.csv("assocPvals.csv")


assoc.sorted <- assoc[order(assoc$Joint.pval),]


topN <- 2000

top100indices <- assoc.sorted$snpID[1:topN]

# subset original data using these variants

top100genotypes <- getGenotypeSelection(genoData, snpID=top100indices, sort=FALSE)

snpNames <- paste("Snp",1:topN, sep="")

row.names(top100genotypes) <- snpNames

library(pamr)

top100genotypes <- pamr.knnimpute(list(x=top100genotypes))$x

top100genotypes2 <- data.frame(id=colnames(top100genotypes),
                               t(top100genotypes))
fullDataa <- data.frame(scanAnnot$id, scanAnnot$casecontrol, scanAnnot$site,
                        scanAnnot$sex_num, scanAnnot$ev1, scanAnnot$ev2,
                        scanAnnot$ev3, scanAnnot$ppt.total)
names(fullDataa) <- c("id", "casecontrol", "site", "sex_num", "ev1", "ev2",
                      "ev3", "ppt.total")
fullData <- merge(fullDataa, top100genotypes2)

#fullData <- data.frame(scanAnnot$casecontrol, scanAnnot$site, scanAnnot$sex_num, scanAnnot$ev1, scanAnnot$ev2, scanAnnot$ev3, scanAnnot$ppt.total,t(top100genotypes))


fullData1 <- fullData[!is.na(fullData$ppt.total),] #fixed here

# for (i in 9:ncol(fullData1)) {
#   cur.lm <- lm(fullData1[,i]~casecontrol+site+sex_num+ev1+ev2+ev3,
#                data=fullData1)
#   fullData1[,i] <- resid(cur.lm) #fixed here
# }
#fullData1[is.na(fullData1)] <- 0
#fullData1$scanAnnot.sex_num <- as.numeric(fullData1$scanAnnot.sex_num)

#f <- as.formula(ppt.total ~ sex_num*.)

fullData.train <- fullData1[-which(fullData1$id %in% c( White.test, nonWhite)),]

fullData.test <- fullData1[-which(fullData1$id %in% c( White.train, nonWhite)),]

fullData.nonWhite <- fullData1[-which(fullData1$id %in% c( White.train, White.test)),]



f <- as.formula(ppt.total ~ sex_num*. - sex_num)

f <- as.formula(ppt.total ~ . - sex_num)


x <- model.matrix(f, data=fullData.train[, -c(1:3,5:7)])
y <-fullData.train$ppt.total


x.test <- model.matrix(f, data=fullData.test[, -c(1:3,5:7)])
y.test <- fullData.test$ppt.total

x.nw <- model.matrix(f, data=fullData.nonWhite[, -c(1:3,5:7)])
y.nw <- fullData.nonWhite$ppt.total

require(glmnet)

mod_cv <- cv.glmnet(x=x, y=y, family='gaussian', alpha=0.001)

lambdaMin <- mod_cv$lambda.1se

y.train.predict <- predict(mod_cv,newx=x,s=lambdaMin)

cor.test(y, y.train.predict)

# get results on testing dataset
y.predict <- predict(mod_cv,newx=x.test, s=3)

plot(y.predict, y.test, col=factor(x.test[,2], levels=c(0,1), labels('red','black')), xlab="Predicted",ylab="Observed")
cor.test(y.test, y.predict)

#cor.test(fullData.test$ppt.total, fullData.test$ev3)

# get results in nonWhites
y.predict <- predict(mod_cv,newx=x.nw, s=10)

plot(y.predict, y.nw, col=factor(x.test[,2], levels=c(0,1), labels('red','black')), xlab="Predicted",ylab="Observed")
cor.test(y.nw, y.predict)

#cor.test(fullData.test$ppt.total, fullData.test$ev3)


