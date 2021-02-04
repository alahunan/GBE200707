#! /usr/bin/perl  -w

use IO::File;

$mut[0]=241;	$mutfrom[0]='C'; $mutto[0]='T';
$mut[1]=3037;	$mutfrom[1]='C'; $mutto[1]='T';
$mut[2]=8782;	$mutfrom[2]='C'; $mutto[2]='T';
$mut[3]=14408;	$mutfrom[3]='C'; $mutto[3]='T';
$mut[4]=23403;	$mutfrom[4]='A'; $mutto[4]='G';
$mut[5]=28144;	$mutfrom[5]='T'; $mutto[5]='C';
$mut[6]=28881;	$mutfrom[6]='G'; $mutto[6]='A';
$mut[7]=28882;	$mutfrom[7]='G'; $mutto[7]='A';
$mut[8]=28883;	$mutfrom[8]='G'; $mutto[8]='C';
$mutnum=9;
$target="MN908947";

$in = new IO::File "< clinic.xls";
$out = new IO::File "> clinic_mute.xls";
$line=$in->getline;
chomp($line);
print $out $line;
for($i=0;$i<$mutnum;$i++)
{
	print $out "\t".$mut[$i]."(".$mutfrom[$i]."->".$mutto[$i].")";
}
print $out "\n";
while($line=$in->getline)
{
	chomp($line);
	@w=split(/[\s|\t]+/,$line);
	$id=$w[0];

	print $out $line;
	for($i=0;$i<$mutnum;$i++)
	{
		system("./gs2.pl ".$target." ".$id." ".$mut[$i]." ".$mut[$i]." > tmp");
		$inf = new IO::File "< tmp";
		$pm=$inf->getline;
		chomp($pm);
		print $out "\t".$pm;
	}
	print $out "\n";
}





