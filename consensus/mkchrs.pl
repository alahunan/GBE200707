#! /usr/bin/perl  -w

use IO::File;

$in = new IO::File "< strains";
$out = new IO::File "> pstrains";
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$strain=$w[0];
	if( -e "original_chrs/".$strain.".fa" )
	{
	  system("cp original_chrs/".$strain.".fa chrs/");
	  system(" cat MN908947.fa chrs/".$strain.".fa > muscle/".$strain.".fa");
	  print $out $line."\n";
	}
}
undef($in);

