SLX-17032	(150bp PE)
SLX-17036	(150bp PE)
SLX-17321	(150bp PE)
SLX-17322	(150bp PE)
SLX-17324	(150bp SE)
SLX-17328	(150bp SE)
SLX-17330	(150bp PE)
SLX-20209	(150bp SE)
SLX-20212	(150bp SE)
SLX-20456	(150bp SE)
SLX-20457	(150bp SE)
SLX-20458	(150bp SE)
SLX-20460	(150bp SE)

If data is paired end (e.g. SLX-17032, SLX-17036, SLX-17321, SLX-17322, SLX-17330) then need to run uni_trim_merge.sh with appropriate arguments (FLD index range, SLX ID, 5 character alpha/numeric sequencing run code) e.g.

> for i in {193..240}; do sbatch --mem=4096 --time=2:0:0 ./uni_trim_merge.sh $i 17032 C2YB3; done

This calls on UNI_TRIM_SIZE_FOR.pl and UNI_TRIM_SIZE_REV.pl which will also need to be in the directory.  Also requires universal_snp_parameters.txt to be available.

Output is a forward and reverse trimmed .fq file and a combined trimmed/merged file for each FLD index.

Then run snp-count.sh which calls on UNI_SNP_NUCLEOTIDE_COUNT.pl with library SLX no. as argument.  Output is slx_XXXXX_snp_read_counts.txt and slx_XXXXX_correct_reads.txt

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

If data is single end (e.g. SLX-17324 and SLX-17328) then just run unzip_perl_zip.sh which calls on SINGLE_END_SNP_COUNTING.pl and will produce uni_snps_nts_.txt and uni_total_reads_only.txt

Add slx_XXXXX_ to filenames above

Then run UNI_SNP_CALLER.pl (probably on laptop) with SLX IDs as argument e.g 

> for i in 17032 17036 17321; do ./UNI_SNP_caller.pl $i; done

Producing SLX_XXXXX_SNP_calls.txt

All SLX_XXXXX_SNP_calls.txt files can then be concatenated. The SNP ID column headers can be obtained from the slx_XXXXX_correct_reads.txt file.
