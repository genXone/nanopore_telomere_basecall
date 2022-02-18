#!/bin/bash
# This script will always return a fasta with ONE newline at the end
mawk 'BEGIN {ORS="";sep=""} /^>/ {print sep; print $0; sep="\n"; print sep; next} {print $0} END {print sep}' 
