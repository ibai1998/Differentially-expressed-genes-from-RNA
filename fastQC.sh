#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --time=1-01:00:00
#SBATCH --job-name=FastQC
#SBATCH --output=/PATH/QC/output_%j.o
#SBATCH --error=/PATH/QC/error_%j.e
#SBATCH --array=0-23

###
#Set array to nº of samples to compare in this case 24
###

FILES=(*.fastq.gz)

module add UHTS/Quality_control/fastqc/0.11.7;

fastqc -t 2 ${FILES[$SLURM_ARRAY_TASK_ID]}
