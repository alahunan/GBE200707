#! /usr/bin/perl  -w

use Switch;
use IO::File;

# $refid="MN908947";
# $range=10;
# $band="3";
# @carray=('America','Europe','Asia-Pacific','China-innerland');

@marray=('2');

$in = new IO::File "< 2strain";
$i=0;
$carray_num=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$lorg[$i]=$w[0];
	$lreg[$i]=$w[6];
	$ltag[$i]=$w[2];
	$i+=1;

	if($did{$w[6]})
	{	;	}
	else
	{
		$did{$w[6]}=1;
		$carray[$carray_num]=$w[6];
		$carray_num+=1;
	}	
	
}
undef($in);

$out = new IO::File "> freq_2state.xls"; 
$in = new IO::File "< glist";
while($line=$in->getline)
{
  chomp($line);
  @w=split(/\t/,$line);
  $pos=$w[0];
  $minor=$w[2];
  $major=$w[3];

  for($k=0;$k<@carray;$k++) 
  {		
	
	print $pos."\t".$carray[$k]."\n";
	print $out $pos."\t".$carray[$k]."\t".$major."\t".$minor;
	for($i=0;$i<@marray;$i++)
	{		
		print ",".$i;
		$c_major=0;
		$c_minor=0;
		for($j=0;$j<@lorg;$j++)
		{
			if($ltag[$j] eq $marray[$i] && $lreg[$j] eq $carray[$k])
			{
				$f= "muscle/compat/".$lorg[$j].".fa";
				if( -e $f)
				{
					$inf = new IO::File "< ".$f;
					$line=$inf->getline;
					$line=$inf->getline;
					chomp($line);
					@n=split(//,$line);
					$ref_pos=0;
					$cor_pos=-1;
					for($ii=0;$ii<=@n;$ii++)
					{
						if( $n[$ii] ne '-' )
						{ $ref_pos+=1; }
						if($ref_pos==$pos)
						{
							$cor_pos=$ii;
							last;
						}
					}		
					undef(@n);
					
					if($cor_pos>0)
					{
						$line=$inf->getline;
						$line=$inf->getline;
						chomp($line);
					
						@n=split(//,$line);
						
						$allele=$n[$cor_pos];
						# print $pos."\t".$major."\t".$minor."\t".$allele."\n"; die();
						if($allele eq $major)
						{	
							$c_major+=1;
						}
					
						if($allele eq $minor)
						{	
							$c_minor+=1;
						}	
						undef(@n);
					}
				}
				undef($f);
			}
		}
		print $out "\t".$c_major."\t".$c_minor;		
	}
	print $out "\n"; 
	print "\n";
	
  }
}	
	
undef($out);


