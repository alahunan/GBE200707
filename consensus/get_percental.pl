#! /usr/bin/perl  -w

use IO::File;
use POSIX;

$infile=$ARGV[0];
$col=$ARGV[1];
chomp($infile);
chomp($col);

$in = new IO::File "< ".$infile;
$dnum=0;
$line=$in->getline;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$d[$dnum]=$w[$col];
	$dnum+=1;
}
undef($in);

for($i=0;$i<$dnum;$i++)
{
	for($j=$i+1;$j<$dnum;$j++)
	{
		if($d[$i]<$d[$j])
		{
			@d[$i,$j]=@d[$j,$i]; 	
		}
	}
}

print "max\t".$d[ceil($dnum*0.05)]."\n";
print "min\t".$d[ceil($dnum*0.95)]."\n";
