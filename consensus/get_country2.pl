#! /usr/bin/perl  -w

use Switch;
use IO::File;

# $refid="MN908947";
# $range=10;
$band="3";
@marray=('1','2','3','4');
$in = new IO::File "< pstrains";
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	# $w[0]=~s/EPI\_ISL\_//;
	$isolate{$w[0]}=$w[5];
	$country{$w[0]}=$w[1];
	if($month{$w[2]})
	{
		$month{$w[2]}[$len{$w[2]}]=$w[0];
		$len{$w[2]}+=1;
	}
	else
	{
		$month{$w[2]}[0]=$w[0];
		$len{$w[2]}=1;
	}
}
undef($in);

$in = new IO::File "< aln_chr.fas";
while($line=$in->getline)
{
	if($line=~/^\>/)
	{
		chomp($line);
		$gene=$line;
		$gene=~s/\>//;
		# if($gene eq $targetid)
		# {
			$line=$in->getline;
			chomp($line);
			@n=split(//,$line);
			for($ii=0;$ii<@n;$ii+=1)
			{
				$nn{$gene}[$ii]=$n[$ii];
			}	
			undef(@n);
			# print $gene."\n";
		# }
	}
}
undef($in);
# $xxx=$ii;
# die();
$in = new IO::File "< allglist.xls";
$outf = new IO::File "> allarea.xls";
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$pos=$w[0];
	$site=$w[1];
	$one=$w[2];
	$two=$w[3];
	print $outf $pos."\t".$one."\t".$two;
	
	for($ii=0;$ii<@marray;$ii++)
	{		
		$cc{$one}{"Europe"}=0;
		$cc{$one}{"North America"}=0;
		$cc{$one}{"Asia"}=0;
		$cc{$one}{"Oceania"}=0;
		
		$cc{$two}{"Europe"}=0;
		$cc{$two}{"North America"}=0;
		$cc{$two}{"Asia"}=0;
		$cc{$two}{"Oceania"}=0;		
		
		$band=$marray[$ii];
		$xx=$len{$band};
		$out = new IO::File "> all_country/".$pos."_".$band.".xls";
		for($i=0;$i<$xx;$i++)
		{
			$targetid=$month{$band}[$i];
			$seq=$nn{$targetid}[$site];
			if($seq && ($seq eq $one || $seq eq $two) )
			{
				print $out $seq."\t".$targetid."\t".$country{$targetid}."\t".$isolate{$targetid}."\n";
				if($seq eq $one)
				{
					if($country{$targetid} eq "Europe"){  $cc{$one}{"Europe"}+=1; }
					if($country{$targetid} eq "North America"){  $cc{$one}{"North America"}+=1; }
					if($country{$targetid} eq "Asia"){  $cc{$one}{"Asia"}+=1; }
					if($country{$targetid} eq "Oceania"){  $cc{$one}{"Oceania"}+=1; }
				}
				
				if($seq eq $two)
				{
					if($country{$targetid} eq "Europe"){  $cc{$two}{"Europe"}+=1; }
					if($country{$targetid} eq "North America"){  $cc{$two}{"North America"}+=1; }
					if($country{$targetid} eq "Asia"){  $cc{$two}{"Asia"}+=1; }
					if($country{$targetid} eq "Oceania"){  $cc{$two}{"Oceania"}+=1; }
				}				
			}
		
		}
		undef($out);
		print $outf "\t".$cc{$one}{"Europe"}."\t".$cc{$one}{"North America"}."\t".$cc{$one}{"Asia"}."\t".$cc{$one}{"Oceania"};
		print $outf "\t".$cc{$two}{"Europe"}."\t".$cc{$two}{"North America"}."\t".$cc{$two}{"Asia"}."\t".$cc{$two}{"Oceania"};
	}	
	print $outf "\n";	
}
undef($in);

