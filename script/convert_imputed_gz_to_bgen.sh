#!/usr/bin/bash

for chrom in {2..2}
do
cd ~/output/impute2/chr$chrom
qctool -g imputed.chr$chrom.gz -og imputed.chr$chrom.bgen
done
