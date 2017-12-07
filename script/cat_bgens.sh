#!/usr/bin/bash
#SBATCH --mem=8G
#SBATCH --output=cat-bgen.log

cat-bgen -clobber \
		-g \
			~/output/impute2/chr1/imputed.subset.chr1.bgen \
			~/output/impute2/chr2/imputed.subset.chr2.bgen \
			~/output/impute2/chr3/imputed.subset.chr3.bgen \
			~/output/impute2/chr4/imputed.subset.chr4.bgen \
			~/output/impute2/chr5/imputed.subset.chr5.bgen \
			~/output/impute2/chr6/imputed.subset.chr6.bgen \
			~/output/impute2/chr7/imputed.subset.chr7.bgen \
			~/output/impute2/chr8/imputed.subset.chr8.bgen \
			~/output/impute2/chr9/imputed.subset.chr9.bgen \
			~/output/impute2/chr10/imputed.subset.chr10.bgen \
			~/output/impute2/chr11/imputed.subset.chr11.bgen \
			~/output/impute2/chr12/imputed.subset.chr12.bgen \
			~/output/impute2/chr13/imputed.subset.chr13.bgen \
			~/output/impute2/chr14/imputed.subset.chr14.bgen \
			~/output/impute2/chr15/imputed.subset.chr15.bgen \
			~/output/impute2/chr16/imputed.subset.chr16.bgen \
			~/output/impute2/chr17/imputed.subset.chr17.bgen \
			~/output/impute2/chr18/imputed.subset.chr18.bgen \
			~/output/impute2/chr19/imputed.subset.chr19.bgen \
			~/output/impute2/chr20/imputed.subset.chr20.bgen \
			~/output/impute2/chr21/imputed.subset.chr21.bgen \
			~/output/impute2/chr22/imputed.subset.chr22.bgen \
		-og ~/output/impute2/imputed.oppera.bgen
