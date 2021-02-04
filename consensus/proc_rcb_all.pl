#! /usr/bin/perl  -w


use IO::File;

$in = new IO::File "< glist";
$hit_num=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$hit[$hit_num]=$w[0];
	$hit_num+=1;
}
undef($in);

$in = new IO::File "< rcb/all_rcb";
$out = new IO::File "> rcb_list.txt";
print $out "a1\ta2\tdistance\td\trho\tlod\tmark\n";
$adpie_num=0;
$arho_num=0;
$alod_num=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$a1=$w[0];
	$a2=$w[1];
	$distance=$w[2];
	$g11=$w[3];
	$g22=$w[4];
	$g12=$w[5];
	$g21=$w[6];	
	$d=$w[7];
	$rho=$w[8];
	$lod=$w[10];
	if($have{$a1."|".$a2}){ ; }
	else
	{
		$all=$g11+$g22+$g12+$g21;
		$p1=($g11+$g12)/$all;
		$p2=($g11+$g21)/$all;
		$q1=1-$p1;
		$q2=1-$p2;	

		if($d>0)
		{
			$dmax=$p1*$q2;
			$dpie=$d/$dmax;
		}
		else
		{
			$dmax=(-1)*$p1*$q1;
			$dpie=$d/$dmax;
		}		

		$r=(1-$rho)/2;
		$z1=($g11+$g22)*(log(1-$r)/log(10));
		$z2=($g12+$g21)*(log($r)/log(10));
		$z3=($g11+$g22+$g12+$g21)*(log(0.5)/log(10));
		$lod=$z1+$z2-$z3;
		
		if($rho>0.7)
		{
		$adpie[$adpie_num]=$dpie; $adpie_num+=1;
		$arho[$arho_num]=$rho; $arho_num+=1;
		$alod[$alod_num]=$lod; $alod_num+=1;
		}
		
		print $out $a1."\t".$a2."\t".$distance."\t".$dpie."\t".$rho."\t".$lod;
		$m1=0;
		for($i=0;$i<@hit;$i++)
		{
			if($a1 == $hit[$i]){ $m1=1; }
		}
		$m2=0;
		for($i=0;$i<@hit;$i++)
		{
			if($a2 == $hit[$i]){ $m2=1; }
		}	
		
		if($m1>0 && $m2>0)
		{
			if($rho>0.762006098122926 && $lod>119.050753743833)
			{
				print $out "\t*\n";
			}
			else
			{
				print $out "\t.\n";
			}
		}
		else
		{
			print $out "\t.\n";
		}
	}
	$have{$a1."|".$a2}=1;
	$have{$a2."|".$a1}=1;
	
}
undef($in); 
undef($out);
print $adpie_num."\n";
for($i=0;$i<$adpie_num;$i++)
{
	for($j=$i+1;$j<$adpie_num;$j++)
	{
		if($adpie[$j]>$adpie[$i])
		{
			$tmp=$adpie[$i];
			$adpie[$i]=$adpie[$j];
			$adpie[$j]=$tmp;
		}

		if($arho[$j]>$arho[$i])
		{
			$tmp=$arho[$i];
			$arho[$i]=$arho[$j];
			$arho[$j]=$tmp;
		}

		if($alod[$j]>$alod[$i])
		{
			$tmp=$alod[$i];
			$alod[$i]=$alod[$j];
			$alod[$j]=$tmp;
		}		
	}
}

print "top 5% dpie=".$adpie[3277]."\n";
print "top 5% rho=".$arho[3277]."\n";
print "top 5% lod=".$alod[3277]."\n";

