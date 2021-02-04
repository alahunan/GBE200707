#! /usr/bin/perl  -w

use Switch;
use IO::File;


$in = new IO::File "< pstrains";
$i=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$lorg[$i]=$w[0];
	$i+=1;
}
undef($in);

$out = new IO::File "> aln_chr.fas";

for($j=0;$j<@lorg;$j++)
{

	$f= "muscle/compat/".$lorg[$j].".fa";
	if( -e $f)
	{
		
		$inf = new IO::File "< ".$f;
		$line=$inf->getline;
		$line=$inf->getline;
		chomp($line);
		@m=split(//,$line);
		$line=$inf->getline;
		$line=$inf->getline;
		chomp($line);
		@n=split(//,$line);
		
		$seq="";
		for($ii=0;$ii<@m;$ii++)
		{
			if( $m[$ii] ne '-' )
			{
				$seq.=$n[$ii];
			}
		}
		
		if(length($seq)>1000)
		{
			print $out ">".$lorg[$j]."\n".$seq."\n";		
		}
		
		undef(@m);
		undef(@n);
		undef($seq);
	}
}
	
undef($out);
system("cat MN908947.fa >> aln_chr.fas");


