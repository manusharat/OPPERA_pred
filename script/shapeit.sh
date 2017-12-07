#!/bin/bash
#SBATCH --mem=32G 
#SBATCH --cpus-per-task=8
#SBATCH --output=../output/shapeit/shapeit-11-11.log

for chr in $(seq 11 11); do 
srun shapeit -B ../oppera/uw_gwas/plink/subjects/chr$chr\.unphased \
             -M ../oppera/uw_gwas/genetic_map/genetic_map_chr$chr\_combined_b37.txt \
             --input-ref ../1000genomesForIMPUTE2/1000GP_Phase3/1000GP_Phase3_chr$chr\.hap.gz \
                         ../1000genomesForIMPUTE2/1000GP_Phase3/1000GP_Phase3_chr$chr\.legend.gz \
                         ../1000genomesForIMPUTE2/1000GP_Phase3/1000GP_Phase3.sample \
             --exclude-snp ../output/shapeit/strand_align$chr\.snp.strand.exclude \
             -O ../output/shapeit/oppera.phased/chr$chr\.phased.haps.gz \
                ../output/shapeit/oppera.phased/chr$chr\.phased.sample.gz \
             -T 8 ; #change to 8
done
		
		
