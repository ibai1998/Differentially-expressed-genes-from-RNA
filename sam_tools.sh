#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1:00:00
#SBATCH --job-name=Sam>Bam
#SBATCH --output=/data/courses/rnaseq/breastcancer_de/Mapping_try/output_%j.o
#SBATCH --error=/data/courses/rnaseq/breastcancer_de/Mapping_try/error_%j.e


module add UHTS/Analysis/samtools/1.10 

samtools view -hbS /data/courses/rnaseq/breastcancer_de/Map_to_ref_HER21/mappedReads_HER21.sam > mappedReads_HER21.bam
