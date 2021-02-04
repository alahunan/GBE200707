#! /usr/bin/perl  -w

use Parallel::ForkManager;

my $MAX_PROCESSES=64; 
my $pm = new Parallel::ForkManager($MAX_PROCESSES); 

$dir = $ARGV[0];
chomp($dir);

opendir (DIR, $dir) or die "can't open the directory!";
@dir = readdir DIR;
foreach $file (@dir) {
	if ( $file =~/\.fa/ ) {
		$pid = $pm->start and next;  
		print $file."\n";
		system("muscle -in muscle/".$file." -out muscle/result/".$file."; ");
		$pm->finish;
	}  
}
$pm->wait_all_children;

# for(my $n=1;$n<=$nboot;$n++){ 

    # my $pid = $pm->start and next;  
    # &bootstrap($n); 
    # $pm->finish;      
# } 
# $pm->wait_all_children;