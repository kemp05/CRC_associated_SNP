#!/bin/sh
gunzip SLX-$2.FLD0$1.000000000-$3.s_1.r_1.fq.gz
./UNI_TRIM_SIZE_FOR.pl $1 $2 $3
gunzip SLX-$2.FLD0$1.000000000-$3.s_1.r_2.fq.gz
./UNI_TRIM_SIZE_REV.pl $1 $2 $3
gzip SLX-$2.FLD0$1.000000000-$3.s_1.r_1.fq
gzip SLX-$2.FLD0$1.000000000-$3.s_1.r_2.fq
/home/bioinformatics/software/pandaseq/pandaseq-2.11/pandaseq -f SLX-$2.FLD0$1.000000000-$3.s_1.r_1.trim.fq -r SLX-$2.FLD0$1.000000000-$3.s_1.r_2.trim.fq -w SLX-$2.FLD0$1.000000000-$3.s_1.r.trim.merge.fq
gzip SLX-$2.FLD0$1.000000000-$3.s_1.r_1.trim.fq
gzip SLX-$2.FLD0$1.000000000-$3.s_1.r_2.trim.fq
#gzip SLX-$2.FLD0$1.000000000-$3.s_1.r.trim.merge.fq
