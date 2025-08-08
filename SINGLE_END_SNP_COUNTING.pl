#!/usr/bin/perl
# 

$results  = "uni_total_reads_only.txt";
open(OUTPUT2, ">>$results");

$results  = "uni_snps_nts_.txt";
open(OUTPUT, ">>$results");

open (INPUT, "universal_snp_parameters.txt") or die "\nSNP file could not be found\n\n";
while (<INPUT>){
	chomp ($_);
	($rs_id,$gene_symbol,$chr,$coord,$for_primer,$rev_primer,$snp_context,$amp,$amp_size) = split(/\t/,$_);;
	($pre,$sub) = split(/_/,$snp_context);
#	$rev_primer = reverse $rev_primer;
#	$rev_primer =~ tr/ACGT/TGCA/;
	push(@RS_ID,$rs_id);
	push(@FOR_PRIMER,$for_primer);
#	push(@REV_PRIMER,$rev_primer);
	push(@PRE,$pre);
	push(@SUB,$sub);
}
	
%TOTAL=();
%A=();
%C=();
%G=();
%T=();

open (INPUT2, "filenames.txt") or die "\nFilenames file could not be found\n\n";
while (<INPUT2>){
	chomp ($_);
	$sample = $_;
	push(@SAMPLE,$sample);
	$index = 0;
	while ($index < scalar@RS_ID){
		$a_base = 0;
		$c_base = 0;
		$g_base = 0;
		$t_base = 0;
		$total = 0;
		open (INPUT, "$sample") or die "\nAmp file could not be found\n\n";
	
		$searchterm = "$PRE[$index]"."([ACGT])"."$SUB[$index]";
		while (<INPUT>){
			chomp ($_);
			if ($_ =~ /^$FOR_PRIMER[$index]/){
			
				if ($_ =~ /$searchterm/){
					if ($1 eq "A"){
						$a_base = $a_base +1;
					}
					if ($1 eq "C"){
						$c_base = $c_base +1;
					}
					if ($1 eq "G"){
						$g_base = $g_base +1;
					}
					if ($1 eq "T"){
						$t_base = $t_base +1;
					}
					$total = $total +1;
				}
			
			}
		}
		print "$sample\t$RS_ID[$index]\t$total\n";
		$key = "$sample"."_$RS_ID[$index]";
		$TOTAL{$key} = $total;
		$A{$key} = $a_base;
		$C{$key} = $c_base;
		$G{$key} = $g_base;
		$T{$key} = $t_base;
	
		close(INPUT);
		$index = $index +1;
	}
}
close(INPUT2);

print OUTPUT "\t";
foreach $val (@RS_ID){
	print OUTPUT "$val\tA\tC\tG\tT\t";
}
print OUTPUT "\n";
	
foreach $val (@SAMPLE){
	print OUTPUT "$val\t";
	$index = 0;
	while ($index <scalar@RS_ID){
		$key = "$val"."_$RS_ID[$index]";
		print OUTPUT "$TOTAL{$key}\t$A{$key}\t$C{$key}\t$G{$key}\t$T{$key}\t";
		$index = $index +1;
	}
	print OUTPUT "\n";
}

print OUTPUT2 "\t";
foreach $val (@RS_ID){
	print OUTPUT2 "$val\t";
}
print OUTPUT2 "\n";
	
foreach $val (@SAMPLE){
	print OUTPUT2 "$val\t";
	$index = 0;
	while ($index <scalar@RS_ID){
		$key = "$val"."_$RS_ID[$index]";
		print OUTPUT2 "$TOTAL{$key}\t";
		$index = $index +1;
	}
	print OUTPUT2 "\n";
}

exit;
