#! /usr/bin/perl  -w


use IO::File;

$inf1=$ARGV[0];
$inf2=$ARGV[1];
$outf=$ARGV[2];

chomp($inf1);
chomp($inf2);
chomp($outf);

$in = new IO::File "< ".$inf1;
while($line=$in->getline)
{
	chomp($line);
	$have{$line}=1;
}
undef($in);

$in = new IO::File "< ".$inf2;
$out = new IO::File "> ".$outf;

$line=$in->getline;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	if($have{$w[0]})
	{
	  print $out $line."\n";
	}
}

