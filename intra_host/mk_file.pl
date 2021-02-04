#! /usr/bin/perl  -w


use IO::File;

$inf1=$ARGV[0];
$inf2=$ARGV[1];
$outf=$ARGV[2];

chomp($inf1);
chomp($inf2);
chomp($outf);

#tb
$in = new IO::File "< ".$inf1;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$content{$w[0]}=$line;
}
undef($in);

$in = new IO::File "< ".$inf2;
$out = new IO::File "> ".$outf;

while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$id=$w[7];
	if( ($w[3]+$w[4]) >=20 )
	{
	  print $out $w[0]."\t".$w[6]."\t".$content{$id}."\n";
	}
}

