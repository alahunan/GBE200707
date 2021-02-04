#! /usr/bin/perl  -w

use Switch;
use IO::File;
use Spreadsheet::ParseExcel;
use Spreadsheet::WriteExcel;
use Unicode::Map;
use Spreadsheet::ParseExcel::FmtUnicode;

$inputfile=$ARGV[0];
$outputfile=$ARGV[1];
chomp($inputfile);
chomp($outputfile);

$out = new IO::File "> ".$outputfile;

$parser = Spreadsheet::ParseExcel->new();
my $formatter = Spreadsheet::ParseExcel::FmtUnicode->new(Unicode_Map=>"UTF8");    
my $workbook = $parser->parse($inputfile, $formatter);
if(!defined $workbook){
    die $parser->error(), "\n";
}

for my $worksheet($workbook->worksheets()){

    my ($row_min, $row_max) = $worksheet->row_range();    
    ##列号的最小值和最大值
    my ($col_min, $col_max) = $worksheet->col_range();    
	$row_min=4;
    for my $row ($row_min..$row_max){
		my $id = $worksheet->get_cell($row, 0)->value();
		my $name = $worksheet->get_cell($row, 1)->value();
		my $location = $worksheet->get_cell($row, 2)->value();
		my $date = $worksheet->get_cell($row, 3)->value();
		
		$id=~s/EPI\_ISL\_//;
		$org="hs";
		if($name =~/pangolin/g || $name =~/bat/g)
		{
			$org="ani";
		}

		if($date=~/2019\-12/ || $date=~/2020\-01/)
		{
			$month=1;
		}
		elsif($date=~/2020\-02/)
		{
			$month=2;
		}
		elsif($date=~/2020\-03/)
		{
			$month=3;
		}
		elsif($date=~/2020\-04/)
		{
			$month=4;
		}
		elsif($date=~/2020\-05/)
		{
			$month=5;
		}		
		else
		{
			$month=0;
		}
			
		if($location=~/([A-Za-z]+\s?[A-Za-z]+)\s*\/\s*([A-Za-z]+\s?[A-Za-z]+)/)
		{
			$continent=$1;
			$country=$2;
			if($continent=~/USA/)
			{
				$continent="North America";
				$country="USA";
			}
		}
		else
		{
			$continent="NA";
			$country="NA";		
		}
		
		if($org eq "hs" && $month>0 && $continent ne "NA")
		{
			print $out $id."\t".$continent."\t".$month."\t".$country."\t".$date."\t".$location."\n";
		}
        # for my $col ($col_min..$col_max){
            # my $cell = $worksheet->get_cell($row, $col);
            # next unless $cell;

            # print "Value=".$row.", ".$col.":". $cell->value(). "\n";
        # }
		# last;
    }
	
	last;
}


