#! /usr/bin/perl  -w


use IO::File;



$in = new IO::File "< all.table";
$out = new IO::File "> clinic.xls";
$inf = new IO::File "< total_7914.fasta";
while($line=$inf->getline)
{
	chomp($line);
	$line=~s/^\s+//;
	$line=~s/\s+$//;	
	if($line=~/^\>/)
	{
		@w=split(/\|/,$line);
		$strain=$w[1];
	}
	else
	{
		# print $strain."\t".$line."\n";
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
undef($inf);



$list_num=0;
$column_num=0;
while($line=$in->getline)
{
	chomp($line);
	$line=~s/^\s+//;
	$line=~s/\s+$//;
	if($line=~/\:/)
	{
		if($line=~/^Accession\s+ID/)
		{
			@w=split(/\:\s+/,$line);
			$id=$w[1];
			$list[$list_num]=$id;
			$list_num+=1;
		}
		else
		{
			@w=split(/\:\s*/,$line);
			$content{$w[0]}{$id}=$w[1];
			if($have{$w[0]})
			{
				;		
			}
			else
			{
				$have{$w[0]}=1;
				$column[$column_num]=$w[0];
				$column_num+=1;
				# print $w[0]."\n";
			}
		}
	}
}

print $out $id;
for($j=0;$j<$column_num;$j++)
{
	print $out "\t".$column[$j];
}
print $out "\n";

for($i=0;$i<$list_num;$i++)
{
	
	$id=$list[$i];
	if($seq{$id})
	{
		$out1 = new IO::File "> chrs/".$id.".fa";
		print $out1 ">".$id."\n".$seq{$id}."\n";
		undef($out1);
		print $out $list[$i];		
		for($j=0;$j<$column_num;$j++)
		{
			if($content{$column[$j]}{$list[$i]})
			{
				print $out "\t".$content{$column[$j]}{$list[$i]};
			}
			else
			{
				print $out "\t"."NA";
			}
		}
		print $out "\n";		
	}
	else
	{
		# print $id."\n";
	}
	

}
