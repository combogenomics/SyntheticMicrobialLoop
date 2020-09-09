#!/usr/bin/perl

my $file = $ARGV[0];

print "\n working on file $file \n";


open(OPEN, $file);
@array = <OPEN>;

close OPEN;

#print @array;

	system("cp iMF721_update.xml iMF721_ML.xml");

foreach $line(@array){

	@SplitLine = split('\t', $line);
	chomp $SplitLine[0];	
	chomp $SplitLine[1];	


	system("sed 's/$SplitLine[1]/$SplitLine[0]/' iMF721_update.xml > iMF721_tmp.xml ");
	system("cp iMF721_tmp.xml iMF721_ML.xml");


}
	
