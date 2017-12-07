#!/usr/bin/bash
#SBATCH --mem=64G

plink --bed ~/scripts/plink.bed \
      --bim ~/scripts/plink.bim.nodup \
      --fam ~/scripts/plink.fam \
      --missing-code -9,0,NA,na \
      --score ~/other_gwas/AnxietyD/anxiety.meta.full.cc.fixed2 1 5 7 header \
      --q-score-range ~/scripts/p.value.ranges.txt ~/other_gwas/AnxietyD/anxiety.meta.full.cc.fixed2 1 9 header \
