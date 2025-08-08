#!/bin/sh
ls *trim.merge* > slx_$1_filenames.txt
./UNI_SNP_NUCLEOTIDE_COUNT.pl $1
