#!/usr/bin/bash

for chrom in {16..22}
do
cd ~/output/impute2/chr$chrom
qctool -g imputed.chr$chrom.bgen -s ~/output/shapeit/oppera.phased/chr$chrom.phased.sample \
       -og imputed.subset.chr$chrom.bgen \
       -os imputed.subset.chr$chrom.sample \
       -excl-samples ~/output/impute2/exclude_sample.txt
done
