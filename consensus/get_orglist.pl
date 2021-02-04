#! /usr/bin/perl  -w

use Switch;
use IO::File;

# $refid="MN908947";
# $range=10;
# $band="3";
@marray=('1','2','3','4','5');

$in = new IO::File "< pstrains";
$i=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$lorg[$i]=$w[0];
	$ltag[$i]=$w[2];
	$i+=1;
}
undef($in);


$in = new IO::File "< glist";
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$pos=$w[0];
	$minor=$w[2];
	$major=$w[3];
	print $pos."\n";

	# print $out $pos."\t".$major."\t".$minor;
	for($i=0;$i<@marray;$i++)
	{		
		print ",".$i;
		$out1 = new IO::File "> orglist/".$pos."_".$marray[$i]."_".$minor.".list";
		$out2 = new IO::File "> orglist/".$pos."_".$marray[$i]."_".$major.".list";
		for($j=0;$j<@lorg;$j++)
		{
			if($ltag[$j] eq $marray[$i])
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
							print $out2 $lorg[$j]."\n";
						}
					
						if($allele eq $minor)
						{	
							print $out1 $lorg[$j]."\n";
						}	
						undef(@n);
					}
				}
				undef($f);
			}
		}
		undef($out1);
		undef($out2);		
	}

	# print $out "\n"; 
	print "\n";
}	
	
# undef($out);


