#!/usr/bin/bash

for chrom in {1..22}
do
cd ~/output/impute2/chr$chrom
ls -1t *.impute2_info | while read fn ; do cat "$fn" >> imputed.chr$chrom.info; done
done
