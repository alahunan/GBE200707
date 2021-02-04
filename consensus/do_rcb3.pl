#! /usr/bin/perl  -w

use Parallel::ForkManager;
use POSIX;

my $MAX_PROCESSES=64; 
my $pm = new Parallel::ForkManager($MAX_PROCESSES); 

$in = new IO::File "< allglist.xls";
$snp_num=0;
while($line=$in->getline)
{
	$snp_num++;
}
undef($in);


for($i=0;$i<$snp_num;$i+=10) {
	$cc=floor($i/10);
	$pid = $pm->start and next;  
	print $pid."\t".$cc."\n";
	system("./get_rcb3.pl ".$cc.";");
	$pm->finish;
 
}
$pm->wait_all_children;

# for(my $n=1;$n<=$nboot;$n++){ 

    # my $pid = $pm->start and next;  
    # &bootstrap($n); 
    # $pm->finish;      
# } 
# $pm->wait_all_children;