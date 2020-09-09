#!/usr/bin/perl

my $file = $ARGV[0];

print "\n working on file $file \n";


open(OPEN, $file);
@array = <OPEN>;

close OPEN;

#print @array;

	system("cp iLB1025.xml  iLB1025_ML.xml");

foreach $line(@array){

	@SplitLine = split('\t', $line);
	chomp $SplitLine[0];	
	chomp $SplitLine[1];	
	$old_met = "M_".$SplitLine[1]."_";
	$new_met = "M_".$SplitLine[0]."_";
	system("sed 's/$old_met/$new_met/' iLB1025_ML.xml > iLB1025_tmp.xml");
	system("cp iLB1025_tmp.xml iLB1025_ML.xml");


}
	
