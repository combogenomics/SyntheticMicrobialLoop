#!/bin/perl

my $file = $ARGV[0];

print "\n working on file $file \n";


open(OPEN, $file);
@array = <OPEN>;

close OPEN;


open(OPEN, "chem_xref.tsv");
@ref_array = <OPEN>;

close OPEN;
#print @array;


print "\n\n **Extracting MNX names from MNX source file\n\n";
foreach $line(@array){

	$line =~ /^(.+?)\[/;
	$compound = "bigg:".$1;
	chomp $compound;
	push(@bigg_compounds, "$compound\n");
}


open(WRITE, ">$file.FromMetanetx");
print WRITE @bigg_compounds;
close WRITE;

system("perl LinesExtractor.pl -m chem_xref.tsv -i $file.FromMetanetx");
open(OPEN, "LinesOf-chem_xref.tsv-from-$file.FromMetanetx");
@array2 = <OPEN>;
close OPEN;

#print "\t@array2";

foreach $line(@array2){

	$line =~ /bigg\:(.+?)\t/;
	$bigg_name = $1;
	#print "BIGG - $bigg_name\n\n";

	$line =~ /\t(.+?)\t/;
	$MNX_name = $1;
	#print "MNX - $MNX_name\n\n";

	chomp $MNX_name;
	chomp $bigg_name;
	push(@final_compounds, "$MNX_name\t$bigg_name\n");
}

open(WRITE, ">MappedCompoundsDia");
print WRITE @final_compounds;
close WRITE;
