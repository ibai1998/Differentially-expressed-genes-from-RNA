#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --time=2:00:00
#SBATCH --job-name=index
#SBATCH --output=/PATH/Map_to_ref_SAMPLE/output_%j.o
#SBATCH --error=/PATH/Map_to_ref_SAMPLE/error_%j.e

module add UHTS/Analysis/samtools/1.10;

samtools index sorted_HER22.bam
