#! /usr/bin/perl  -w

use IO::File;

## $source_strain_list="gisaid_cov2020_acknowledgement_table.xls";
$source_strain_dir="gisaid";
$source_orginial_chr_dir="321-518";

### system("./parse_excel.pl source/".$source_strain_list." strains; ");
# my $fileReportDir = "source/".$source_strain_dir;
# system("mkdir tmp;");
# if(-e $fileReportDir){

	# opendir DIR, $fileReportDir || die "Error in opening dir $fileReportDir\n";
	# while( my $file = readdir(DIR)){
		# next if $file eq ".";
		# next if $file eq "..";
		# my $fileAll = $fileReportDir."/".$file;
		# print $fileAll."\n";
		
		# system("./parse_excel.pl ".$fileAll." tmp/".$file);
	# }

# }
# system("cd tmp; cat *.xls > ../strains; ");
# system("rm -rf tmp;");

# system(" cd source/".$source_orginial_chr_dir."; for i in *.fasta; do cat \$i >> ../tmp_chr.fa; echo -e '\n' >> ../tmp_chr.fa; done;");
# system("./chgfmt.pl source/tmp_chr.fa; ");
# system("./mkchrs.pl; ");
# system("rm -rf muscle/result; mkdir muscle/result;");
# system("./do_muscle.pl ./muscle"); 

# system("rm -rf muscle/compat; mkdir muscle/compat;");
# system("cd muscle/result; for i in *.fa; do ../../fmt_clw.pl \$i ../compat/\$i; done; ");

# system("./get_freq.pl");
# system("./get_freq_contry.pl");
# system("./get_freq_region.pl");


# system("rm -rf orglist; mkdir orglist; ./get_orglist.pl; ");
# system("cd chrs; rm -rf axt; mkdir axt; j=MN908947.fa; for i in  *.fa; do lastz \$i ../\$j --ambiguous=iupac --format=axt --output=axt/\$i.\$j.axt; done;  i=MN908947.fa; for j in *.fa; do lastz ../\$i \$j --ambiguous=iupac --format=axt --output=axt/\$i.\$j.axt; done;");
# system("cat chrs/*.fa MN908947.fa > varipop/allchr.fa; cd varipop; ../fmt_clw_nt.pl allchr.fa pallchr.fa; mv allchr.fa pre_allchr.fa; mv pallchr.fa allchr.fa; ./mk_chr_len.pl; ");
# system("./mk_orglist.pl; ");
# system("./get_3state.pl; ");
# system("./get_3state_post.pl; ");
system("cd varipop/ongoing; ./do.sh");
system("cd varipop/clr; ./do.sh");
system("cd varipop/clr/result; ./do.sh; cd sorted; ./do.sh");
system("./get_align_file.pl; ");
system("cd varipop/fst; ./do_fst.sh;");
# system("./find_all_mutation.pl; "); 
# system("./get_country2.pl; ");
# system("cd all_country; ./dolog.sh; ");
# system("./do_rcb3.pl; ");
system("cd rcb; cat *.xls > all_rcb; ");
system("./proc_rcb_all.pl; ");

