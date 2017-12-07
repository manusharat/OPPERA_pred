#!/usr/bin/bash

for chrom in {1..22}
do
cd ~/output/impute2/chr$chrom
wc imputed.chr$chrom.info >> ~/scripts/var_counts.txt
done
