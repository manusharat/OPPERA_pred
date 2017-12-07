#!/usr/bin/bash

for chrom in {17..22}
do
cd ~/output/impute2/chr$chrom
ls -1t *.gz | while read fn ; do cat "$fn" >> imputed.chr$chrom.gz; done
done
