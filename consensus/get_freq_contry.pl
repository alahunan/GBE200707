#! /usr/bin/perl  -w

use Switch;
use IO::File;

# $refid="MN908947";
# $range=10;
# $band="3";
@marray=('North America','Europe','Asia','Oceania');

$in = new IO::File "< pstrains";
$i=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$lorg[$i]=$w[0];
	$ltag[$i]=$w[1];
	$i+=1;
}
undef($in);

$out = new IO::File "> freq_number_total_contry.xls"; 
$in = new IO::File "< glist";
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	$pos=$w[0];
	$minor=$w[2];
	$major=$w[3];
	print $pos."\n";
	print $out $pos."\t".$major."\t".$minor;
	for($i=0;$i<@marray;$i++)
	{		
		print ",".$i;
		$c_major=0;
		$c_minor=0;
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
	
undef($out);


