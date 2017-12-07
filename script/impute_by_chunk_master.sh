#!/bin/bash

#SBATCH --job-name=arrayJob
#SBATCH --output=arrayJob_%A_%a.out
#SBATCH --error=arrayJob_%A_%a.err
#SBATCH --array=11-20
#SBATCH --ntasks=10
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=8G

chr=$SLURM_ARRAY_TASK_ID

file="../1000genomesForIMPUTE2/1000GP_Phase3/chr${chr}_chunks_gb37.txt"
while IFS= read line
do
        impute_cmd="./impute_by_chunk.sh "
        impute_cmd+="$line"
        eval "$impute_cmd"
done <"$file"
