#!/usr/bin/bash
#SBATCH --mem=64G

plink --bed ~/scripts/plink.bed \
      --bim ~/scripts/plink.bim.copy \
      --fam ~/scripts/plink.fam \
      --list-duplicate-vars ids-only suppress-first \
      --missing-code -9,0,NA,na 


