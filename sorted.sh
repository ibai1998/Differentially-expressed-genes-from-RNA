#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25G
#SBATCH --time=2:00:00
#SBATCH --job-name=Sort_bam_HER22
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/PATH/Map_to_ref_SAMPLE/output_%j.o
#SBATCH --error=/PATH/Map_to_ref_SAMPLE/error_%j.e

module add UHTS/Analysis/samtools/1.10;

samtools sort -m 25G -@ 4 -o sorted_SAMPLE.bam -T temp mappedReads_SAMPLE.bam
