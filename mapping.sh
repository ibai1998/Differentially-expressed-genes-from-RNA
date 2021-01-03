#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=13:00:00
#SBATCH --job-name=Mapping
#SBATCH --output=/data/courses/rnaseq/breastcancer_de/Mapping_try/output_%j.o
#SBATCH --error=/data/courses/rnaseq/breastcancer_de/Mapping_try/error_%j.e
#SBATCH --array=0-11
module add UHTS/Aligner/hisat/2.2.1

cd /data/courses/rnaseq/breastcancer_de/reads
MATE1=(*R1.fastq.gz)
MATE2=(*R2.fastq.gz)

hisat2 -x /data/courses/rnaseq/breastcancer_de/Index/genome_base.1.ht2 -1 ${MATE1[$SLURM_ARRAY_TASK_ID]} -2 ${MATE2[$SLURM_ARRAY_TASK_ID]} -S mappedReads_try.sam -p 4
