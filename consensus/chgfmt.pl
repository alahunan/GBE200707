#! /usr/bin/perl  -w


use IO::File;


$inf=$ARGV[0];
chomp($inf);
$chr_dir="original_chrs";
$in = new IO::File "< ".$inf;
# $out = new IO::File "> p_".$inf;

while($line=$in->getline)
{
	if($line=~/^\>/)
	{
		chomp($line);
		@w=split(/\|/,$line);
		@x=split(/\_/,$w[1]);
		# print $out ">".$x[2]."\n";
		$out1=new IO::File ">".$chr_dir."/".$x[2].".fa";
		print $out1 ">".$x[2]."\n";
	}
	else
	{
		# print $out uc($line);
		print $out1 uc($line);
	}
}

