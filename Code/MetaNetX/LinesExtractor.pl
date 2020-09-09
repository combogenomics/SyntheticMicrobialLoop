#!/bin/perl
use Getopt::Long;
use Term::ANSIColor;
use lib "./bin";
use lib "/Library/Perl/5.10.0";



my $usage="
\n
Script to extrac lines from a main file, given a list of IDs. IDs must match exactly one of the (tab separated) fields in the main file.
\n
Usage: perl LinesExtractor.pl -m <Multi line file>  -i  <ID list> -f <number of ID-containing field in the main file, defaul 1> \n
" ;

GetOptions(         "m=s" => \$MainFile,		
		    "i=s" => \$IDFile,		
                    "f=n" => \$field
);

if ($MainFile eq "") {
    print "\nFATAL: missing main file name"; 
    print " $usage";
    exit}

if ($IDFile eq "") {
    print "\nFATAL: missing id file name\n\n"; 
    print " $usage";
    exit}

if ($field eq "") {
$field=1
}



print "\n * Main file is $MainFile and id file is $IDFile\n";
	

unless ( open( READ, "$MainFile" ) ) {
	print "\nFATAL ERROR! Can't open main file, exiting...\n";
	exit;
}
@MainArray = <READ>;

unless ( open( READ, "$IDFile" ) ) {
	print "\nFATAL ERROR! Can't open id file, exiting...\n";
	exit;
}


@IDarray = <READ>;


print "\n * Extracting lines from $MainFile\n\n";

foreach $line(@MainArray){

@splitline = split('\t', $line);


chomp $splitline[$field];

	foreach $line2(@IDarray) {

	chomp($line2);	

	if ($line2 eq $splitline[0]){
	
	push (@ExtractedLines, $line)

	}

	}


}


open( WRITE, ">LinesOf-$MainFile-from-$IDFile" );
print WRITE @ExtractedLines;
close WRITE;  


print" * Done.\n\n";
