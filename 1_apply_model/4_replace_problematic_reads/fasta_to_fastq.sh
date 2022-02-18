#!/bin/bash
set -e
QUAL="$1"
set -u
[ -z "$QUAL" ] && { echo "Using default QUAL=20" >&2; QUAL=20 ; } || true
PHRED_BASE="33" # One of two default shifts for PHRED qual in fastq

fasta_multiline_to_single.sh  | \
   awk 'BEGIN {qual=sprintf("%c",'"$PHRED_BASE"'+'"$QUAL"');} \
        NR%2==1 {$1="@"substr($1,2); print $0; next;} \
        {print $0;print "+"; s=sprintf("%"length($0)"s","");gsub(/ /,qual,s);print s;}'

