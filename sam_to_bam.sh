#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1:00:00
#SBATCH --job-name=Sam>Bam
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/PATH/Mapping_SAMPLE/output_%j.o
#SBATCH --error=/PATH/courses/rnaseq/breastcancer_de/Mapping_SAMPLE/error_%j.e


module add UHTS/Analysis/samtools/1.10

samtools view -hbS /PATH/Map_to_ref_SAMPLES/mappedReads_SAMPLE.sam > mappedReads_SAMPLE.bam
