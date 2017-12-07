#!/usr/bin/bash
#SBATCH --mem=64G

plink --bed ~/scripts/plink.bed \
      --bim ~/scripts/plink.bim.nodup \
      --fam ~/scripts/plink.fam \
      --missing-code -9,0,NA,na \
      --score ~/other_gwas/MDD/pgc.mdd.clump.2012-04.txt 1 4 6 header \
      --q-score-range ~/scripts/p.value.ranges.txt ~/other_gwas/MDD/pgc.mdd.clump.2012-04.txt 1 8 header \
