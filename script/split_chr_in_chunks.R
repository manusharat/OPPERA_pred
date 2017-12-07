#!/usr/bin/env Rscript
# generate chunk coordinates for imputation by IMPUTE2

chunksize <- 5000000
chr <- 21
for (chr in c(21:22)) {
  fileConn<-file(paste0("chr",chr,"_chunks_gb37.txt"), open="w")
                 
  fname <- paste0("genetic_map_chr", chr, "_combined_b37.txt")
  mtable <- read.delim(fname, sep=' ')
  coord <- mtable[,1]
  last <- coord[length(coord)]
  start <- coord[1]
  end <- start+chunksize-1
  
  while (end<last) {
    writeLines(paste(chr, start, end), fileConn, sep="\n")
    start <- end+1
    end <- start+chunksize-1
  }
  writeLines(paste(chr, start, last), fileConn, sep="\n")
  close(fileConn)
}

