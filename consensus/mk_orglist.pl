#! /usr/bin/perl  -w

use Switch;
use IO::File;

# $refid="MN908947";
# $range=10;
# $band="3";
# @marray=('1','2','3');
$out1= new IO::File "> varipop/list/m3";
$out2= new IO::File "> varipop/list/m3a";
$out3= new IO::File "> varipop/list/m3e";
$out4= new IO::File "> 3strain";

$in = new IO::File "< pstrains";
# $i=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	if($w[2] eq "3")
	{
		print $out1 $w[0]."\n";
		if($w[1] eq "North America")
		{
			print $out2 $w[0]."\n";
		}
		if($w[1] eq "Europe")
		{
			print $out3 $w[0]."\n";
		}	
		print $out4 $line."\t".$w[3]."\n";
	}

}
undef($in);





