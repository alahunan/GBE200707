#! /usr/bin/perl  -w

use Switch;
use IO::File;

$section=$ARGV[0];
chomp($section);

$in = new IO::File "< allglist.xls";
$j=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$snp[$j]=$w[0];
	
	$major[$j]=$w[2];
	$minor[$j]=$w[3];
	$j++;
}
undef($in); 
# print log(1)/log(10)."\n";
# $band="3";
$out = new IO::File "> rcb/".$section.".xls";
for($i=($section*10+0);$i<@snp && $i<($section*10+10);$i++)
{
	for($j=$i+1;$j<@snp;$j++)
	{
		$g11=0;
		$g12=0;
		$g21=0;
		$g22=0;
		$in1 = new IO::File "< all_country/all/".$snp[$i].".xls";
		
		while($line=$in1->getline)
		{
			chomp($line);
			@w=split(/\t/,$line);	
			$a1=$w[0];
			if($a1 eq $major[$i])
			{
				$strain=$w[1];
				$in2 = new IO::File "< all_country/all/".$snp[$j].".xls";
				while($line=$in2->getline)
				{
					chomp($line);
					@w=split(/\t/,$line);
					$a2=$w[0];
					if($a2 eq $major[$j] && $strain eq $w[1])
					{
						$g11+=1; last;
					}
					
					if($a2 eq $minor[$j] && $strain eq $w[1])
					{
						$g12+=1; last;
					}					
				}
				undef($in2);
			}

			if($a1 eq $minor[$i])
			{
				$strain=$w[1];
				$in2 = new IO::File "< all_country/all/".$snp[$j].".xls";
				while($line=$in2->getline)
				{
					chomp($line);
					@w=split(/\t/,$line);
					$a2=$w[0];					
					if($a2 eq $major[$j] && $strain eq $w[1])
					{
						$g21+=1; last;
					}
					
					if($a2 eq $minor[$j] && $strain eq $w[1])
					{
						$g22+=1; last;
					}					
				}
				undef($in2);
			}			
		}
		undef($in1);

		if($g11==0){ $g11=1; }
		if($g22==0){ $g22=1; }
		if($g12==0){ $g12=1; }
		if($g21==0){ $g21=1; }
		$all=$g11+$g22+$g12+$g21;
		$p1=($g11+$g12)/$all;
		$p2=($g11+$g21)/$all;
		$q1=1-$p1;
		$q2=1-$p2; 

		$d=($g11*$g22-$g12*$g21)/($all*$all);

		if($d>0)
		{	$r=2*($p1*$q2-$d);	}
		else
		{	$r=1-2*($p1*$q1+$d);	}
		
		$rho=($d*$d)/($p1*$p2*$q1*$q2);

		$z1=($g11+$g22)*(log(1-$r)/log(10));
		$z2=($g12+$g21)*(log($r)/log(10));
		$z3=($g11+$g22+$g12+$g21)*(log(0.5)/log(10));
		$lod=$z1+$z2-$z3;		
				
		print $out $snp[$i]."\t".$snp[$j]."\t".abs($snp[$j]-$snp[$i])."\t".$g11."\t".$g22."\t".$g12."\t".$g21."\t".$d."\t".$rho."\t".$r."\t".$lod."\n";		
	}
}



