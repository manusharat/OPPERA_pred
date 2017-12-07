#!/bin/bash
#SBATCH --mem=1024
#SBATCH --cpus-per-task=4
#SBATCH --output=../output/shapeit/plink.log

for chr in $(seq 11 11); do 
plink --bfile ../oppera/uw_gwas/plink/subjects/Oppera3 \
      --geno 0.1 \
      --chr $chr \
      --make-bed \
      --mind 0.1 \
      --out ../oppera/uw_gwas/plink/subjects/chr$chr\.unphased ; 
done

		
		
