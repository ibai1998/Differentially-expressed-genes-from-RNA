#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=13:00:00
#SBATCH --job-name=featureCounts
#SBATCH --output=/data/courses/rnaseq/breastcancer_de/featureCounts/output_%j.o
#SBATCH --error=/data/courses/rnaseq/breastcancer_de/featureCounts/error_%j.e

module add UHTS/Analysis/subread/2.0.1

featureCounts -T 4 -a /data/courses/rnaseq/breastcancer_de/Index/Homo_sapiens.GRCh38.101.gtf -o featureCounts.txt ./Map_to_ref_HER21/mappedReads_HER21.bam ./Map_to_ref_HER22/mappedReads_HER22.bam ./Map_to_ref_HER23/mappedReads_HER23.bam ./Map_to_ref_NonTNBC1/mappedReads_NonTNBC1.bam ./Map_to_ref_NonTNBC2/mappedReads_NonTNBC2.bam ./Map_to_ref_NonTNBC3/mappedReads_NonTNBC3.bam ./Map_to_ref_TNBC1/mappedReads_TNBC1.bam ./Map_to_ref_TNBC2/mappedReads_TNBC2.bam ./Map_to_ref_TNBC3/mappedReads_TNBC3.bam ./Map_to_ref_Normal1/mappedReads_Normal1.bam ./Map_to_ref_Normal2/mappedReads_Normal2.bam ./Map_to_ref_Normal3/mappedReads_Normal3.bam
