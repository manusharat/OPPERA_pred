#!/usr/bin/bash

for chrom in {1..22}
do
cd ~/output/impute2/chr$chrom
ls *.info | while read fn ; do cat "$fn" >> ~/output/impute2/imputed.oppera.info; done
done
