#!/usr/bin/bash
#SBATCH --mem=64G

plink --bed ~/scripts/plink.bed \
      --bim ~/scripts/plink.bim.copy \
      --fam ~/scripts/plink.fam \
      --exclude ~/scripts/plink.dupvar \
      --make-bed \
      --out plink_nodup 


