#!/usr/bin/bash

plink  --bgen ~/output/impute2/imputed.oppera.bgen \
       --sample ~/output/impute2/imputed.oppera.sample \
       --make-bed
       -out /work/avb14/imputed.oppera 

