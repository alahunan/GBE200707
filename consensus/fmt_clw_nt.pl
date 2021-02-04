#! /usr/bin/perl  -w


use IO::File;
$infile=$ARGV[0];
chomp($infile);
$outfile=$ARGV[1];
chomp($outfile);

$in = new IO::File "< ".$infile;
$out = new IO::File "> ".$outfile; 
$o_num=0;
while($line=$in->getline)
{
	chomp($line);
	if($line=~/^\>/)
	{
		@w=split(/\//,$line);
		$strain=$w[0];
		$strain=~s/\>//;
		$o[$o_num]=$strain;
		$o_num+=1;
	}
	else
	{
		@w=split(//,$line);
		for($i=0;$i<@w;$i++)
		{
		   if($w[$i]!~/[ATCGNatcgn]/)
		   {  $w[$i]=''; }
		}
	 	$line=join('',@w);
		if($seq{$strain})
		{
			$seq{$strain}.=$line;
		}
		else
		{
			$seq{$strain}=$line;
		}
	}
}
undef($in);

for($i=0;$i<$o_num;$i++)
{
	print $out ">".$o[$i]."\n".$seq{$o[$i]}."\n";
}


