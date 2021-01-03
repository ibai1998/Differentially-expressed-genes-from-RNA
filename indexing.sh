#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --time=1-08:00:00
#SBATCH --job-name=Map_to_Ref
#SBATCH --output=/PATH/output_%j.o
#SBATCH --error=/PATH/error_%j.e

module add UHTS/Aligner/hisat/2.2.1;

hisat2-build Homo_sapiens.GRCh38.dna.primary_assembly.fa genome_base
