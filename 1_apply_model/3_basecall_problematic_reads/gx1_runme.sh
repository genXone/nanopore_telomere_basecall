#!/bin/bash
set -eux
echo
echo conda activate nanotelo
echo

#SAMP="scas9_kp519" ; 
SAMP="scas9_kp520" ; 
#RDIR="/mnt/borgvol/Bams/genXone/20211027_1844_servdna_scas9_20063_kp519_MN106_SLSK109/20211020_1538_X1_FAR26269_6ab704a0/"; 
RDIR="/mnt/borgvol/Bams/genXone/20211027_1845_servdna_cas9_20063_kp520_MN106_SLSK109_2/20211025_1445_X1_FAR27188_6603ca40/";

mkdir -p "$RDIR/fast5_all" ; ln -f "$RDIR/fast5_"{{pass,fail}/*,all/} ; 
pzstd -d "$RDIR"/fast5_all/*.zst ; 
mkdir -p "$RDIR/fast5_extracted" ; 
mkdir -p "${SAMP}_telobasecalled" ; 
#rmdir "${SAMP}_telobasecalled" || true

< ../2_identify_problematic_reads/"${SAMP}.repeatcounts.filtered.readname" mawk '{print $1}' > "${SAMP}.repeatcounts.filtered.readname" ; 

perl main.pl "$RDIR/fast5_all" "${SAMP}.repeatcounts.filtered.readname"  "$RDIR/fast5_extracted" "${SAMP}_telobasecalled.fasta.gz"

