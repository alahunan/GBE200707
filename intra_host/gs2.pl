#! /usr/bin/perl  -w


use IO::File;


$org_from=$ARGV[0];
$org_to=$ARGV[1];
$start=$ARGV[2];
$end=$ARGV[3];

chomp($org_from);
chomp($org_to);
chomp($start);
chomp($end);



$in = new IO::File "<  /home/zhuzl/cv/ncov19/ncov/cov19/intra_host/clinic/chrs/axt/".$org_from.".fa.".$org_to.".fa.axt";
$match_num=0;
while($line=$in->getline)
{
	# print $line."aa\n";
	if($line=~/^\#/ || length($line)<3 )
	{
		next;
	}
	else
	{
		chomp($line);
		@w=split(/\s+/,$line);
		# print $line."\n";
		$fstart=$w[2];
		$fend=$w[3];
		# $tstart=$w[5];
		# $tend=$w[6];
		$get_seq='';
		# $to_min=1000000;
		# $to_max=-1;		
		$score=0;
		if( ($start>=$fstart && $end<=$fend) || ($start<=$fstart && $end>=$fend) || ($start>=$fstart && $end>=$fend && $start<=$fend) || ($start<=$fstart && $end<=$fend && $end>=$fstart) )
		{
			$get_start=$start-$fstart+1;
			$get_end=$end-$fstart+1;
			# print $get_start."\t".$get_end."\n";
			$fromseq=$in->getline;
			$toseq=$in->getline;
			chomp($fromseq);
			chomp($toseq);
			@wf=split(//,$fromseq);
			@wt=split(//,$toseq);
			$act_num=0;
			# $to_num=0;
			for($i=0;$i<@wf;$i++)
			{
				if($wf[$i] ne '-')
				{ $act_num+=1; }
				
				# if($wt[$i] ne '-')
				# { $to_num+=1; }	

				if($wf[$i] ne '-' && $wt[$i] ne '-')
				{
					$score+=1;
				}
				
				if($act_num>=$get_start && $act_num<=$get_end)
				{
					$get_seq.=$wt[$i];
					# if($to_num<$to_min) { $to_min=$to_num; }
					# if($to_num>$to_max) { $to_max=$to_num; }
				}
			}
			
		}
		else
		{
			$fromseq=$in->getline;
			$toseq=$in->getline;		
		}
		$match[$match_num]=$get_seq;
		$pipei[$match_num]=$score;
		# $posi[$match_num]=($tstart+$to_min-1)."-".($tstart+$to_max-1);
		$match_num+=1;
	}
	
}
undef($in);
$max=-1;
$ret="";
for($j=0;$j<$match_num;$j++)
{
	if($pipei[$j]>$max)
	{
		$max=$pipei[$j];
		$ret=$match[$j];
		# $pposi=$posi[$j];
	}
}

# print ">".$pposi."\n";
print $ret."\n";


