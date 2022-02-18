#!/bin/bash
set -eu #-x
# running the actual convertion
#paste - - - - | cut -f 1,2 | sed 's/^@/>/' | tr "\t" "\n" ### Tabs in names problem !!!
mawk 'NR%4 == 1 {print ">" substr($0, 2)} NR%4 == 2 {print}'
