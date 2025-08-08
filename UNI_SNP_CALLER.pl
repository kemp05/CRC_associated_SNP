#!/usr/bin/perl
# 

$results  = "slx_"."$ARGV[0]"."_SNP_calls.txt";
open(OUTPUT, ">>$results");

open (INPUT, "slx_"."$ARGV[0]"."_uni_snps_nts.txt") or die "\nSNP read count file could not be found\n\n";
while (<INPUT>){
	chomp ($_);
	(@LINE) = split(/\t/,$_);
	print OUTPUT "$LINE[0]\t";
	$index = 1;
	while ($index < scalar@LINE){
		$geno = "";
		@GENO = ();
		if ($LINE[$index] >= 100){
			print "$LINE[$index]\t";
			if (($LINE[$index +1]/$LINE[$index]) >= 0.1){$geno = "$geno"."A";}
			if (($LINE[$index +2]/$LINE[$index]) >= 0.1){$geno = "$geno"."C";}
			if (($LINE[$index +3]/$LINE[$index]) >= 0.1){$geno = "$geno"."G";}
			if (($LINE[$index +4]/$LINE[$index]) >= 0.1){$geno = "$geno"."T";}
			
			if($geno eq "A"){
				print OUTPUT "AA";
			}elsif($geno eq "C"){
				print OUTPUT "CC";
			}elsif($geno eq "G"){
				print OUTPUT "GG";
			}elsif($geno eq "T"){
				print OUTPUT "TT";
			}else{
				@GENO = split('',$geno);
				print OUTPUT "$GENO[0]$GENO[1]";
				if (scalar@GENO > 2){
					print OUTPUT "Error";
				}
			}
			
			print OUTPUT "\t";
		}else{
		print OUTPUT "..\t";
		}
		
		$index = $index +5;
	}
	print OUTPUT "\n";	
}	
exit;
