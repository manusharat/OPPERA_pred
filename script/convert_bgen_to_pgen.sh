#!/usr/bin/bash

plink2 --bgen ~/output/impute2/imputed.oppera.bgen \
       --sample ~/output/impute2/imputed.oppera.sample \
       --missing-code -9,0,NA \
       --make-just-bim \
       --out /work/avb14/oppera.dosage 

