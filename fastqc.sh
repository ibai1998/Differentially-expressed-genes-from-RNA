#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-01:00:00
#SBATCH --job-name=FastQC_Analysis_test_HER21_R1
#SBATCH --output=/data/courses/rnaseq/breastcancer_de/FastQC/output_%j.o
#SBATCH --error=/data/courses/rnaseq/breastcancer_de/FastQC/error_%j.e

module add UHTS/Quality_control/fastqc/0.11.7;

fastqc -t 2 HER21_R1.fastqc.gz
