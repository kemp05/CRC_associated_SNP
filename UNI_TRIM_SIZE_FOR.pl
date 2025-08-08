#!/usr/bin/perl

# Note - if the expected amplicon size is less than 150 bp then reads are trimmed to this length 
# thereby removing adapter sequence to facilitate PANDAseq
# Quality score line is also trimmed to corresponding length

$results  = "SLX-"."$ARGV[1]".".FLD0"."$ARGV[0]".".000000000-"."$ARGV[2]".".s_1.r_1.trim.fq";
open(OUTPUT, ">>$results");

open (INPUT, "universal_snp_parameters.txt") or die "\nSNP file could not be found\n\n";
while (<INPUT>){
	chomp ($_);
	($rs_id,$gene_name,$chr,$coord,$for_primer,$rev_primer,$snp_context,$amp,$amp_size,$trim_length) = split(/\t/,$_);
	push(@AMP_SIZE,$trim_length);
	push(@FOR_PRIMER,$for_primer);
	push(@REV_PRIMER,$rev_primer);
}
close(INPUT);

open (INPUT, "SLX-"."$ARGV[1]".".FLD0"."$ARGV[0]".".000000000-"."$ARGV[2]".".s_1.r_1.fq") or die "\nInput file could not be found\n\n";
$line = 1;
$trimmed = 0;
$length = 150;

while (<INPUT>){
	chomp ($_);
	if ($line == 2){
		$seq = $_;
		$index = 0;
		while ($index < scalar@AMP_SIZE){
			if ($seq =~ /^$FOR_PRIMER[$index]/){
				$seq = substr($seq, 0, $AMP_SIZE[$index]);
				$length = $AMP_SIZE[$index];
				$index = scalar@AMP_SIZE;
				$trimmed = 1;
			}
			$index = $index +1;
		}
		print OUTPUT "$seq\n";   
		
	}elsif(($line == 4) && ($trimmed == 1)){
		$quality = substr($_, 0, $length);
		$trimmed = 0;
		$length = 150;
		print OUTPUT "$quality\n";
		
	}else{
		print OUTPUT "$_\n";
	}
	$line = $line +1;
	if ($line == 5){
		$line = 1;
	}
}
	
exit;
