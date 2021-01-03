#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=13:00:00
#SBATCH --job-name=featureCounts
#SBATCH --output=/PATH/featureCounts/output_%j.o
#SBATCH --error=/PATH/featureCounts/error_%j.e

module add UHTS/Analysis/subread/2.0.1

cd /PATH

featureCounts -T 4 -a /PATH/Index/Homo_sapiens.GRCh38.101.gtf -o featureCounts.txt ./Map_to_ref_HER21/mappedReads_SAMPLE1.bam ./Map_to_ref_HER22/mappedReads_SAMPLE2.bam
