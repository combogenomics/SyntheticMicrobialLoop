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
	$compound = $1;
	chomp $compound;
	push(@compounds, "seed:$compound\n");
}


open(WRITE, ">$file.FromMetanetx");
print WRITE @compounds;
close WRITE;

system("perl LinesExtractor.pl -m chem_xref.tsv -i $file.FromMetanetx");
open(OPEN, "LinesOf-chem_xref.tsv-from-$file.FromMetanetx");
@array2 = <OPEN>;
close OPEN;

#print "\t@array2";

foreach $line(@array2){

	$line =~ /seed\:(.+?)\t/;
	$seed_name = $1;
	#print "BIGG - $bigg_name\n\n";

	$line =~ /\t(.+?)\t/;
	$MNX_name = $1;
	#print "MNX - $MNX_name\n\n";

	chomp $MNX_name;
	chomp $seed_name;
	push(@final_compounds, "$MNX_name\t$seed_name\n");
}

open(WRITE, ">MappedCompoundsTac");
print WRITE @final_compounds;
close WRITE;
