# GBE200707
Perl scripts used in analysis

The Perl scripts in the folder 'consensus' are scripts used for mutation analysis based on the consensus sequences of SARS-CoV-2.

The Perl scripts in the folder 'intra_host' are scripts used for mutation analysis based on the raw-sequencing data (.fastq) of SARS-CoV-2.

For specifics, the descriptions of each script are listed below
The scripts in consensus folder
chgfmt.pl Change the format of fasta format files.
do_muscle.pl Do alignment by MUSCLE of the reference sequence and single sequences
do_rcb3.pl Do a multi-process run to obtain linkage disequilibrium parameters
find_all_mutation.pl  find mutations with rapid increase or decrease
find_all_mutation_all.pl find mutations with rapid increase or decrease in four months
fmt_clw.pl The re-format of clustal alignment results
fmt_clw_nt.pl The re-format of clustal alignment results of DNA
get_2state.pl Obtain the status of specific alleles in February
get_3state.pl Obtain the status of specific alleles in March
get_3state_post.pl Obtain the status of specific alleles in March in another format
get_4state.pl Obtain the status of specific alleles in April
get_4state_post.pl Obtain the status of specific alleles in April in another format
get_align_file.pl Obtain the aligned sequences
get_country2.pl Obtain the status of mutants by country
get_freq.pl Obtain the frequencies of mutants
get_freq_contry.pl Obtain the frequencies of mutants in different countries
get_freq_region.pl Obtain the frequencies of mutants in different regions
get_orglist.pl Obtain a mutant list
get_percental.pl Obtain the changes in frequencies of mutants
get_rcb3.pl  Obtain linkage disequilibrium parameters
index.pl The index file showing the pipeline.
mk_orglist.pl Create a list of mutants
mk_orglist_flexible.pl Create a list of mutants in another format
mkchrs.pl Process of sequence files
parse_excel.pl Parse excel files to obtain a list of strains 
part_mission_1.pl Action to do variation anlysis
proc_rcb_all.pl Obtain linkage disequilibrium parameters for all data


The scripts in intra_host folder
create_table.pl the process of files related to phenotype obtained from GISAID
fmt_table.pl the process of files obtained from GISAID
get_freq.pl Obtain the frequency of mutants based on clinic data
gs2.pl Obtain a segment from a alignment file
mk_file.pl Create file in format 1
mk_file2.pl Create file in format 2
proc_r_aus.pl The process of tables from NCBI SRA tables, e.g. the data in Australia
proc_uk_table.pl The process of tables in another format from NCBI SRA tables, e.g. the data in UK.

