#! /usr/bin/perl  -X


use IO::File;

$in = new IO::File "< zuihou_aus";
while($line=$in->getline)
{
	chomp($line);
	$have{$line}=1;
}


$in = new IO::File "< r_aus.xls";
$out = new IO::File "> rr_aus.xls";

$line=$in->getline;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	if($have{$w[2]})
	{
		print $out $line."\n";
	}
}

$in = new IO::File "< zz_aus";
while($line=$in->getline)
{
	chomp($line);
	$have1{$line}=1;
}


$in = new IO::File "< r_aus.xls";
$out = new IO::File "> rrr_aus.xls";

$line=$in->getline;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	if($have1{$w[2]})
	{
		print $out $line."\n";
	}
}

