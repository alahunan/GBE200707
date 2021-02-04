#! /usr/bin/perl  -X


use IO::File;



$in = new IO::File "< Table_PRJEB37886.txt";
$out = new IO::File "> ff_uk";

$line=$in->getline;
while($line=$in->getline)
{
	chomp($line);
	$line=~s/\".+\"/NA/;
	@w=split(/\,/,$line);
	print $out $w[0]."\t".$w[20]."\t".$w[22]."\t".$w[23]."\t".$w[56]."\t".$w[57]."\n";
	print $out $line."\n";
}

