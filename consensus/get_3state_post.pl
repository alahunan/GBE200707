#! /usr/bin/perl  -w


use IO::File;
# $infile=$ARGV[0];
# chomp($infile);
# $outfile=$ARGV[1];
# chomp($outfile);



$in = new IO::File "< 3strain";
$i=0;
$carray_num=0;
while($line=$in->getline)
{
	chomp($line);
	@w=split(/\t/,$line);
	# $lorg[$i]=$w[0];
	# $lreg[$i]=$w[6];
	# $ltag[$i]=$w[2];
	# $i+=1;

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

$in = new IO::File "< freq_3state.xls";
$out = new IO::File "> freq_3state_post.xls"; 
while($line=$in->getline)
{
	chomp($line);

	@w=split(/\t/,$line);
	$pos=$w[0];
	$region=$w[1];
	$nt_major{$pos}=$w[2];
	$nt_minor{$pos}=$w[3];	
	$major{$pos}{$region}=$w[4];
	$minor{$pos}{$region}=$w[5];
}

@links=(23403,28144,17747,514,27046,28881);

print $out "\t";
for($i=0;$i<@carray;$i++)
{
	print $out "\t".$carray[$i];
}	
print $out "\n";

for($i=0;$i<@links;$i++)
{
	print $out $links[$i]."\t".$nt_major{$links[$i]}."\tAllele1";
	for($j=0;$j<@carray;$j++)
	{
		print $out "\t".$major{$links[$i]}{$carray[$j]};
	}
	print $out "\n";
	
	print $out $links[$i]."\t".$nt_minor{$links[$i]}."\tAllele2";
	for($j=0;$j<@carray;$j++)
	{
		print $out "\t".$minor{$links[$i]}{$carray[$j]};
	}
	print $out "\n";	
}



