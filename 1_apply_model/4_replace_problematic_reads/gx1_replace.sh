#!/bin/bash
set -eux

SAMP="/mnt/borgvol/Bams/genXone_samples/21-10-27_ONT/Project_translokacje/Sample_genxone_poznan_translokacje_servdna_scas9_20063_kp519_MN106_SLSK109/debarcoded.none/none.fastq.gz"; 
#SAMP="/mnt/borgvol/Bams/genXone_samples/21-10-27_ONT/Project_translokacje/Sample_genxone_poznan_translokacje_servdna_cas9_20063_kp520_MN106_SLSK109_2/debarcoded.none/none.fastq.gz" ;
RB="../3_basecall_problematic_reads/scas9_kp519_telobasecalled.fasta.gz"
#RB="../3_basecall_problematic_reads/scas9_kp520_telobasecalled.fasta.gz"

OUTFQ="$(dirname "$SAMP")tr/nonetr.fastq.gz"
RBQUAL=15

mkdir -p "$(dirname "$OUTFQ")" ; 
perl find_and_replace_fastq.pl "$SAMP" <( < "$RB" pigz -cd | ./fasta_to_fastq.sh "$RBQUAL" | pigz -c ) | pigz -c > "$OUTFQ"

