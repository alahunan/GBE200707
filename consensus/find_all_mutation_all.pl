#! /usr/bin/perl  -w

use Switch;
use IO::File;

$refid="MN908947";
@marray=('1','2','3','4');
$cutoff=0.001;
$in = new IO::File "< pstrains";
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
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
print $len{"1"}."\t".$len{"2"}."\t".$len{"3"}."\t".$len{"4"}."\n";
$out1 = new IO::File "> 4/result_all.xls";
$out2 = new IO::File "> 4/ratio_all.xls";
$out3 = new IO::File "> 4/allglist.xls";
$in = new IO::File "< aln_chr.fas";
while($line=$in->getline)
{
	if($line=~/^\>/)
	{
		chomp($line);
		$gene=$line;
		$gene=~s/\>//;	
		$line=$in->getline;
		chomp($line);
		@n=split(//,$line);
		for($ii=0;$ii<@n;$ii+=1)
		{
			$nn{$gene}[$ii]=$n[$ii];
		}
		
		if($refid eq $gene)
		{
			$true=0;
			for($ii=0;$ii<@n;$ii+=1)
			{
				
				if($n[$ii] ne '-')
				{
					$true+=1;
				}		
				$cor_ref[$ii]=$true;
			}				
		}		
		undef(@n);
	}
}
undef($in);

$xxx=$ii;
for($j=0;$j<$xxx;$j++)
{
	if($j%1000==0)
	{
		print $j."/".$xxx."\n";
	}
	$max{'A'}=0; $max{'T'}=0; $max{'C'}=0; $max{'G'}=0;
	$min{'A'}=1; $min{'T'}=1; $min{'C'}=1; $min{'G'}=1;
	undef(%aanum);
	undef(%aratio);	
	$act=1;
	for($jj=0;$jj<@marray;$jj+=1)
	{

		$aanum{$marray[$jj]}{'A'}=0;
		$aanum{$marray[$jj]}{'T'}=0;
		$aanum{$marray[$jj]}{'C'}=0;
		$aanum{$marray[$jj]}{'G'}=0;
		# print $marray[$jj]."||".$len{$marray[$jj]}."\n";
		
		$xx=$len{$marray[$jj]}; 
		# print $xx."AAA\n";
		for($i=0;$i<$xx;$i++)
		{
			if($nn{$month{$marray[$jj]}[$i]}[$j])
			{
				# print $nn{$month{$marray[$jj]}[$i]}[$j]."\n";
				if($nn{$month{$marray[$jj]}[$i]}[$j] ne '-' && $nn{$month{$marray[$jj]}[$i]}[$j] ne 'N')
				{
					if( $aanum{$marray[$jj]}{$nn{$month{$marray[$jj]}[$i]}[$j]} )
					{
						$aanum{$marray[$jj]}{$nn{$month{$marray[$jj]}[$i]}[$j]}+=1;
					}
					else
					{
						$aanum{$marray[$jj]}{$nn{$month{$marray[$jj]}[$i]}[$j]}=1;
					}
				}
			}
		}
		$tmp=$aanum{$marray[$jj]}{'A'}+$aanum{$marray[$jj]}{'T'}
			+$aanum{$marray[$jj]}{'C'}+$aanum{$marray[$jj]}{'G'};
		if($tmp>100)
		{
			$aratio{$marray[$jj]}{'A'}=$aanum{$marray[$jj]}{'A'}/$tmp;
			$aratio{$marray[$jj]}{'T'}=$aanum{$marray[$jj]}{'T'}/$tmp;
			$aratio{$marray[$jj]}{'C'}=$aanum{$marray[$jj]}{'C'}/$tmp;
			$aratio{$marray[$jj]}{'G'}=$aanum{$marray[$jj]}{'G'}/$tmp;	
		
			if($aratio{$marray[$jj]}{'A'}>$max{'A'}){ $max{'A'} = $aratio{$marray[$jj]}{'A'}; }
			if($aratio{$marray[$jj]}{'T'}>$max{'T'}){ $max{'T'} = $aratio{$marray[$jj]}{'T'}; }
			if($aratio{$marray[$jj]}{'C'}>$max{'C'}){ $max{'C'} = $aratio{$marray[$jj]}{'C'}; }
			if($aratio{$marray[$jj]}{'G'}>$max{'G'}){ $max{'G'} = $aratio{$marray[$jj]}{'G'}; }
		
			if($aratio{$marray[$jj]}{'A'}<$min{'A'}){ $min{'A'} = $aratio{$marray[$jj]}{'A'}; }
			if($aratio{$marray[$jj]}{'T'}<$min{'T'}){ $min{'T'} = $aratio{$marray[$jj]}{'T'}; }
			if($aratio{$marray[$jj]}{'C'}<$min{'C'}){ $min{'C'} = $aratio{$marray[$jj]}{'C'}; }
			if($aratio{$marray[$jj]}{'G'}<$min{'G'}){ $min{'G'} = $aratio{$marray[$jj]}{'G'}; }
		}
		else
		{
			$act=0;
		}
	}
	# print "EEEEEEEEEEEEEEEEEEe\n";
	
	# die();
	
	if(  $act>0 &&
		(
		( $max{'A'} - $min{'A'} ) >= $cutoff  ||
		( $max{'T'} - $min{'T'} ) >= $cutoff  ||
		( $max{'C'} - $min{'C'} ) >= $cutoff ||
		( $max{'G'} - $min{'G'} ) >= $cutoff 
		)
	)
	{
		$change=0;
		if( ( $max{'A'} - $min{'A'} ) >= $change ) { $change= ( $max{'A'} - $min{'A'} ); }
		if( ( $max{'T'} - $min{'T'} ) >= $change ) { $change= ( $max{'T'} - $min{'T'} ); }
		if( ( $max{'C'} - $min{'C'} ) >= $change ) { $change= ( $max{'C'} - $min{'C'} ); }
		if( ( $max{'G'} - $min{'G'} ) >= $change ) { $change= ( $max{'G'} - $min{'G'} ); }
	
		if($aanum{'1'}{'A'} >= $aanum{'1'}{'T'} && $aanum{'1'}{'A'} >= $aanum{'1'}{'C'} && $aanum{'1'}{'A'} >= $aanum{'1'}{'G'})
		{	
			$mm="A"; 
			if($aanum{'1'}{'T'}>0 || $aanum{'2'}{'T'}>0 || $aanum{'3'}{'T'}>0)
			{
				$gg="T";
			}
			elsif($aanum{'1'}{'C'}>0 || $aanum{'2'}{'C'}>0 || $aanum{'3'}{'C'}>0)
			{
				$gg="C";
			}
			elsif($aanum{'1'}{'G'}>0 || $aanum{'2'}{'G'}>0 || $aanum{'3'}{'G'}>0)
			{
				$gg="G";
			}
			else
			{
				$gg="N";
			}
		}
		elsif($aanum{'1'}{'T'} >= $aanum{'1'}{'A'} && $aanum{'1'}{'T'} >= $aanum{'1'}{'C'} && $aanum{'1'}{'T'} >= $aanum{'1'}{'G'})
		{	
			$mm="T"; 
			if($aanum{'1'}{'A'}>0 || $aanum{'2'}{'A'}>0 || $aanum{'3'}{'A'}>0)
			{
				$gg="A";
			}
			elsif($aanum{'1'}{'C'}>0 || $aanum{'2'}{'C'}>0 || $aanum{'3'}{'C'}>0)
			{
				$gg="C";
			}
			elsif($aanum{'1'}{'G'}>0 || $aanum{'2'}{'G'}>0 || $aanum{'3'}{'G'}>0)
			{
				$gg="G";
			}
			else
			{
				$gg="N";
			}		
		}
		elsif($aanum{'1'}{'C'} >= $aanum{'1'}{'A'} && $aanum{'1'}{'C'} >= $aanum{'1'}{'T'} && $aanum{'1'}{'C'} >= $aanum{'1'}{'G'})
		{	
			$mm="C"; 
			if($aanum{'1'}{'T'}>0 || $aanum{'2'}{'T'}>0 || $aanum{'3'}{'T'}>0)
			{
				$gg="T";
			}
			elsif($aanum{'1'}{'A'}>0 || $aanum{'2'}{'A'}>0 || $aanum{'3'}{'A'}>0)
			{
				$gg="A";
			}
			elsif($aanum{'1'}{'G'}>0 || $aanum{'2'}{'G'}>0 || $aanum{'3'}{'G'}>0)
			{
				$gg="G";
			}
			else
			{
				$gg="N";
			}			
			
		}
		else
		{	$mm="G";

			if($aanum{'1'}{'T'}>0 || $aanum{'2'}{'T'}>0 || $aanum{'3'}{'T'}>0)
			{
				$gg="T";
			}
			elsif($aanum{'1'}{'A'}>0 || $aanum{'2'}{'A'}>0 || $aanum{'3'}{'A'}>0)
			{
				$gg="A";
			}
			elsif($aanum{'1'}{'C'}>0 || $aanum{'2'}{'C'}>0 || $aanum{'3'}{'C'}>0)
			{
				$gg="C";
			}
			else
			{
				$gg="N";
			}	

		}
		
		print $out1 $change."\t".$j;
		print $out2 $change."\t".$j;
		print $out3 $cor_ref[$j]."\t".$j."\t".$mm."\t".$gg."\n";
		for($jj=0;$jj<@marray;$jj+=1)
		{		
			print $out1 "\t".$aanum{$marray[$jj]}{'A'};
			print $out1 "\t".$aanum{$marray[$jj]}{'T'};
			print $out1 "\t".$aanum{$marray[$jj]}{'C'};
			print $out1 "\t".$aanum{$marray[$jj]}{'G'};
			
			print $out2 "\t".$aratio{$marray[$jj]}{'A'};
			print $out2 "\t".$aratio{$marray[$jj]}{'T'};
			print $out2 "\t".$aratio{$marray[$jj]}{'C'};
			print $out2 "\t".$aratio{$marray[$jj]}{'G'};			
		}
		print $out1 "\n";
		print $out2 "\n";
	}	
	
}