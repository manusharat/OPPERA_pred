#!/bin/bash
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4
#SBATCH --output=../output/shapeit/shapeit-align.log

for chr in $(seq 1 22); do 
srun shapeit -check \
             -B ../oppera/uw_gwas/plink/subjects/chr$chr\.unphased \
             -M ../oppera/uw_gwas/genetic_map/genetic_map_chr$chr\_combined_b37.txt \
             --input-ref ../1000genomesForIMPUTE2/1000GP_Phase3/1000GP_Phase3_chr$chr\.hap.gz ../1000genomesForIMPUTE2/1000GP_Phase3/1000GP_Phase3_chr$chr\.legend.gz ../1000genomesForIMPUTE2/1000GP_Phase3/1000GP_Phase3.sample \
             --output-log ../output/shapeit/strand_align$chr \
             -T 4 ;
done
		
		
