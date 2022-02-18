#!/bin/bash
set -eux

SAMP="scas9_kp519" ; 
RDIR="/mnt/borgvol/Bams/genXone/20211027_1844_servdna_scas9_20063_kp519_MN106_SLSK109/20211020_1538_X1_FAR26269_6ab704a0/"; 

mkdir -p "$RDIR/fast5_all" ; ln -f "$RDIR/fast5_"{{pass,fail}/*,all/} ; 
echo pzstd -d "$RDIR"/fast5_all/*.zst ; 
mkdir -p "$RDIR/fast5_extracted" ; 
mkdir -p "${SAMP}_telobasecalled" ; 
rmdir "${SAMP}_telobasecalled" || true

< ../2_identify_problematic_reads/"${SAMP}.repeatcounts.filtered.readname" mawk '{print $1}' > "${SAMP}.repeatcounts.filtered.readname" ; 

perl main.pl "$RDIR/fast5_all" "${SAMP}.repeatcounts.filtered.readname"  "$RDIR/fast5_extracted" "${SAMP}_telobasecalled"

