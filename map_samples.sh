#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8G
#SBATCH --time=1-13:00:00
#SBATCH --job-name=Map_samples_to_ref_SAMPLES
#SBATCH --output=/PATH/output_%j.o
#SBATCH --error=/PATH/error_%j.e


module add UHTS/Aligner/hisat/2.2.1;

hisat2 -x /data/courses/rnaseq/breastcancer_de/Index/genome_base -1 HER22_R1.fastq.gz -2 HER22_R2.fastq.gz -S mappedReads_HER22.sam -p 4
