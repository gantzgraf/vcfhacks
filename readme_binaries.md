__vcfhacks__

This project comprises a set of programs that may be useful for VCF manipulation when trying to discover disease-causing variants in sequencing data. Although more biologists are taking to the commandline many do not have the time or inclination to really get to grips with the more obtuse programs used in the field of bioinformatics. The aim of this project is to provide conceptually simple programs that perform common useful tasks. 

This readme refers to the binary release available for 64-bit Linux and Mac OS X systems. The binary release is designed so that users may run these programs without having to worry about installing the various perl modules required to run the perl scripts. 

Usage examples are included in the attached examples.md markdown document which can also be viewed at https://github.com/gantzgraf/vcfhacks/blob/master/examples_bin.md

__INSTALLATION__

These programs are all command line utilities. To run these programs you simply need to download and extract the tar.bz2 file for your plaform (currently only 64 bit Linux Mac OS X systems are supported) and change into the newly created vcfhacks_binaries directory. Each program can be run from this directory using the command *./[program_name]*  (e.g. *./annotateSnps*) or you may prefer to move the programs somewhere in your $PATH or add the new vcfhacks_binaries to your $PATH to be able to run these programs from any directory. 

__UPDATE__

_VERSION 0.1.16:_

31/03/15

-ensemblGeneAnnotator.pl now supports annotating RefSeq/Entrez IDs (i.e. if VEP was run using --refseq or --merged database options)

-ensemblGeneAnnotator.pl now supports use of SnpEff annotations (as long as -geneId flag was used when running snpEff)

-fixed an issue where files might be incorrectly interpreted as being bgzip compressed

-fixed an issue with filterVcfOnVcf.pl where a rogue progress message might print to STDOUT (and therefore appear in output if using > to redirect output rather than using -o option)

-fixed an issue with annovcfToSimple.pl where an extra column was added when using --summarise option without --contains_variant option

-ensured that INFO lines generated by annotateSnps.pl conform to VCF spec (i.e. GATK does not object to these lines anymore)

-additional modules are now moved into the lib subdirectory for tidyness

-URL for the github examples markdown file provided in readme 

-progress bar in ensemblGeneAnnotator.pl is now optional with the --progress option

-updated pre-built ensemblGeneAnnotator database (<https://github.com/gantzgraf/vcfhacks/releases/download/v.0.1.16/ensAnnotatorDb.zip> or  <http://sourceforge.net/projects/vcfhacks/files/ensAnnotatorDatabase/>) again.

_VERSION 0.1.15:_

11/12/14

-annotateSnps.pl now uses the dbSNP COMMON tag if present to filter variants if --freq argument is equal to or greater than 1 %

-findBiallelicVep.pl and findBiallelicSnpEff.pl make smarter use of --equal_genotypes option if --num_matching argument is used. Previously all samples would have to share identical genotypes even if --num_matching option was used.

-fixed issue with missing MGI and GeneRIFs information in ensemblGeneAnnotator.pl.

-improved database updates with ensemblGeneAnnotator.pl.

-sortVcf.pl can now take a .dict file to provide contig order for output. 

-updated pre-built ensemblGeneAnnotator database (<http://sourceforge.net/projects/vcfhacks/files/ensAnnotatorDatabase/>) for this version. 

_VERSION 0.1.14:_

9/10/14

-added getSampleNames.pl (this actually snuck into version 0.1.13 but was not included in the release notes).

-pre-built ensemblGeneAnnotator database now available from <http://sourceforge.net/projects/vcfhacks/files/ensAnnotatorDatabase/>

-fixed unnecessary memory usage when running  annotateSnps.pl and filterOnEvsMaf.pl without forks.

-added sampleCallsToInfo.pl for converting genotype calls from a VCF into INFO fields in order to reduce file size and/or speed up searching (e.g. with filterVcfOnVcf.pl).

-added ability to filter on INFO fields to filterVcfOnVcf.pl so that allele frequency/genotype based filtering can be performed quicker on data from many (hundreds to thousands) of samples.

-annotateSnps.pl, filterOnEvsMaf.pl, filterOnSample.pl and filterVcfOnVcf.pl only try to determine the contig order if running with forks.

-annovcfToSimple.pl can output variant/genotype counts for given/all samples as well as summarising genotypes by passing '--summarise all' as an argument. Passing '--summarise' on its own still works as before.

-fixed bug in the revamped SortGenomicCoordinates.pm that would cause an infinite loop in filterVcfOnLocation.pl

-ensemblGeneAnnotator only requires bioperl (specifically Bio::SeqIO::entrezgene) if creating/updating the database.

-scripts that write information to the INFO field of a VCF now check in case the same INFO field already exists and replaces it if it does rather than duplicating it.

-added more detailed usage examples to examples.txt (and examples.rtf)

_VERSION 0.1.13:_

30/9/14

-added --summarise option to annovcfToSimple.pl to output variant/genotype counts rather than individual genotypes. Useful for VCFs with lots of samples.

-annovcfToSimple.pl can now work with VCFs containing no samples.

-added documentation for --forks and --cache options to filterOnSample.pl.

-splitMultiallelicVariants.pl now edits AC and AF INFO fields appropriately.

-added --find option to splitMultiallelicVariants.pl to identify and output unbalanced variants without changing variants.

-fixed problem with findBiallelicVep.pl and findBiallelicSnpEff.pl not using --num_matching option correctly when working with PED files.

-getVariantsByLocation.pl now has --vcf_filter option to output variants overlapping those of a another VCF

-also added --matching option to getVariantsByLocation.pl to only output variants with matching alleles to those in VCFs specified by the --vcf_filter option.

-fixed an error that might cause annovcfToSimple.pl to fail as result of trying to merge a single cell


_VERSION 0.1.12:_

1/9/14

-improved getVariantsByLocation.pl handling of missing contigs and invalid regions. Warning are given instead of the program failing.

-added --silent option to getVariantsByLocation.pl to suppress warnings.

-added HGVS annotations to the default fields retrived by annovcfToSimple.pl (when these fields are present).

-getFunctionalVariantsVep.pl and getFunctionalVariantsSnpEff.pl scripts are now more careful with the checking of user-specified variant classes.

-fixed a bug with filterVcfOnVcf.pl where linebreaks would not be added between variants when run without forks. 


_VERSION 0.1.11:_

21/8/14

-fixed a bug in filterOnSample.pl where allele frequency would not be taken into consideration when using --reject or --reject_all_except arguments.

-made filterOnSample.pl quicker

-fixed a bug in filterOnSample.pl where --aff_quality and --un_quality options would be ignored.

-fixed bug when using sortVcf.pl without Sort::External perl module.

-annovcfToSimple.pl correctly handles VEP fields given using the --fields option regardless of case.

-annovcfToSimple.pl now allows you to use the value 'default' with the --fields option to include all default fields plus those specified manually.


_VERSION 0.1.10:_

18/8/14

-in my haste to release v0.1.9 before my holidays I missed a show-stopping bug in the findBiallelic programs due to changes made to enable parallel execution of other scripts. This is now fixed

-fixed a bug where filterOnEvsMaf.pl would not keep track of kept/filtered variants if run without forks

-getVariantsByLocation.pl now allows use of single genomic coordinates (e.g. "X:100000") as well as genomic regions with the --regions option

-support for overlapping CNVs in getVariantsByLocation.pl

-fixed missing line breaks in annovcfToSimple.pl when using text output rather than excel

-added documentation to VcfReader.pm so that the methods are intelligible to other people who may want to use them in their scripts

-sortVcf.pl now uses VcfReader.pm instead of ParseVcf.pm

_VERSION 0.1.9:_

18/7/14

-annotateSnps.pl, filterOnEvsMaf.pl, filterVcfOnVcf.pl and filterOnSample.pl now can all use forks for parallel execution. Execution without forks should be faster also.

-added getVariantsByLocation.pl script to replace filterVcfOnLocation.pl for much faster retrieval of variants by region.

-ensemblGeneAnnotator.pl writes annotations to INFO field, maintaining VCF format.

-annovcfToSimple.pl allows manual selection of VEP fields and INFO fields. Default output is more user-friendly. Gene annotations for multiple genes are now put into split cells.

-VcfReader.pm created to allow for parallel execution in annotateSnps.pl, filterOnEvsMaf.pl, filterVcfOnVcf.pl and filterOnSample.pl and to introduce a faster indexing method for uncompressed VCFs for quicker variant retrieval by positon/region. Version 0.2 will occur once VcfReader.pm replaces the object-oriented ParseVCF.pm in all scripts.

_VERSION 0.1.8a:_

5/6/14

-Fixed bug in findBiallelicSnpEff.pl where --1000_genomes_allele_frequency option would behave opposite to the expected manner (--maf option was not affected by this bug)

-Fixed additional bug in findBiallelicVep.pl and findBiallelicSnpEff.pl when using --min_matching_per_family where unaffected parents would be checked for allele segregation even for a sample without the variant allele.

-when using DBNSFP filter expressions in getFunctionalVariantsSnpEff.pl/findBiallelicSnpEff.pl numeric expressions are no longer converted to string expressions when INFO field type is String/Char if the given expression uses numeric style comparators, but users are still warned that INFO field is of type string.

_VERSION 0.1.8:_

3/6/14

-Added feature to filter on allele frequency in filterOnSample.pl and filterVcfOnVcf.pl

-Added feature to filter variants that are homozygous in --reject samples in filterOnSample.pl and filterVcfOnVcf.pl

-Fixed bug with findBiallelicVep.pl where it would fail to use --min_matching_per_family option properly

-Fixed bug where annovcfToSimple.pl expected to see Cadd Phred Score field by default. Now it decides whether to use it by default after checking whether it is present or not in the header.

_VERSION 0.1.7a:_

20/5/14

-Fixed a bug where rankOnCaddScore.pl would mix up scores of multiallelic variants.

-Corrected --allele_ratio_cutoff short option from -x to -z in filterOnSample.pl

_VERSION 0.1.7:_

15/5/14

-Fixed a bug with rankOnCaddScore.pl that meant that --not_found option never outputted anything.

-annotateSnps.pl now adds SnpAnnotation information to INFO field of variants.

-Fixed a bug with ParseVCF.pm where it would miss some INFO fields when Number was '.'

_VERSION 0.1.6:_

6/5/14

-Tabix.pm installation is now only an absolute requirement if you are actually processing bgzip compressed VCFs. Scripts will only error and exit in the absence of Tabix.pm  when processing compressed VCFs.

-added --aff_genotype_quality and --unaff_genotype_quality arguments to findBiallelicVep.pl, filterOnSample.pl and filterVcfOnVcf.pl

-filterVcfOnVcf.pl now only filters if all ALT alleles in input are matched by the filter VCFs.

-annotateSnps.pl, filterOnEvsMaf.pl and filterVcfOnVcf.pl should now do a better job of resolving different allele representations (due to addition of minimizeAlleles function in ParseVCF.pm) plus bug fixes.

-removed findDenovo.pl in favour of more sophisticated options in filterOnSample.pl (see below). Recommended method for finding de novo variants is now (after normal filtering and annotation) to use a command something like: 

filterOnSample.pl -i [var.vcf] -s [sample ID of child] -r [sample ID of mother] [sample ID of father] -c -d 0.1 [options]

...to only output variants that are confirmed absent in the mother and father (i.e. have a called genotype) and do not have a variant allele making up 10 % or more reads in the mother or father. Alternatively:

filterOnSample.pl -i [var.vcf] -s [sample ID of child] -r [sample ID of mother] [sample ID of father] -c -z 0.2 [options]

...will similarly only output variants that are confirmed absent in the mother and father but also filter variants where either the mother or father have a proportion of variant allele reads equal to or greater than 20 % of the proportion of variant allele reads in the child.

-filterOnSample.pl now has --confirm_missing option. When this option is used, variants are only printed to output if they are present in --samples AND are confirmed as not present in --reject samples. Variants that contain no calls (or genotype qualities below the --un_quality threshold) in --reject samples will be filtered. In this way you may identify likely de novo variants in a sample specified by --samples by specifying parental samples with the --reject option, thus avoiding variants where there is not sufficient information to confirm de novo inheritance.

-filterOnSample.pl now has --depth_allele_cutoff option for assessing allele depth in all samples specified using the --reject argument. Any allele with a proportion of reads greater than or equal to this value will be rejected even if the genotypes are not called by the genotyper. For example, a value of 0.1 will reject any allele making up 10 % of reads for a sample specified by --reject even if the sample is called as homozygous reference.

-filterOnSample.pl now has --allele_ratio_cutoff option for comparing the ratio of variant/total allele depths between samples specified using --samples and samples specified using --reject in order to filter variants based on these values.

-added findBiallelicSnpEff.pl for identification of potential biallelic variants using SnpEff variant functional annotations.

-added rankOnCaddScore.pl to rank or filter variants on their CADD score (http://cadd.gs.washington.edu/)

-made default output of annovcfToSimple.pl more user-friendly (plus minor bug fixes and code improvements).

-added option to annovcfToSimple.pl to use PED files to specify which samples to output genotypes for.

-added option to annovcfToSimple.pl to output INFO fields as columns.

_VERSION 0.1.5:_

28/3/14

-added feature to allow use of a PED file with findBiallelicVep.pl.

-removed --allow_missing feature of findBiallelicVep.pl because it was not working properly.

-added option to report biallelic variants present in a given number of samples rather than all to findBiallelicVep.pl.

-changed default minimum genotype quality (--quality) for findBiallelicVep.pl and filterOnSample.pl from 0 to 20.

-changed filterOnSample.pl to allow users to specify samples to reject without specifying samples to keep.

-added --reject_all_except (-x) option to findBiallelicVep.pl and filterOnSample.pl to allow users to reject variants in all samples in a VCF except for those specified by this option or --samples (-s) option.

-added --num_matching option to filterOnSample.pl to allow users to specify a minimum number of samples that must contain a variant allele in order to print variant.

-made filterVcfOnLocation.pl more lenient regarding region/bed formats.

-annotateSnps.pl checks dbSNP VCF files are sorted in coordinate order.

-annotateSnps.pl checks dbSNP VCF files for relevant INFO fields.

-improved documentation of annotateSnps.pl 

-fixed option spec in getFunctionalVariantsSnpEff.pl

-fixed test for EFF header line in readSnpEffHeader() method in ParseVCF.pm (used by getFunctionalVariantsSnpEff.pl).

-changed filterOnSample.pl to use ParseVCF.pm

-added ParsePedfile.pm module

_VERSION 0.1.4:_

27/1/14

-added getFunctionalVariantsSnpEff.pl program and DbnsfpVcfFilter.pm module.

-added SnpEff annotation parsing functions to ParseVcf.pm.

-added features to getFunctionalVariantsVep.pl and findBiallelicVep.pl enabling filtering of splice_region_variants using annotations from my SpliceConsensus VEP plugin. In practice this means that you can select variants on a slightly stricter definition of the splice consensus region (3 bp before the exon to the first 3 bp of the exon or the last bp of the exon to 6 bp after the exon).

-following report of the Bio::SeqIO::entrezgene bug the bioperl team have fixed the issue, but at the time of writing the fix will not be in the current version of bioperl.  Instead you will need to replace the Bio::SeqIO::entrezgene.pm module in your bioperl installation with the one here: https://github.com/bioperl/bioperl-live/blob/master/Bio/SeqIO/entrezgene.pm if you wish to update your local database for ensemblGeneAnnotator.pl.

-various documentation tidy-ups

-various code tidy-ups, minor optimisations

vcfhacks
--------

This project comprises a set of perl scripts and modules that may be useful for VCF manipulation when trying to discover disease-causing variants in sequencing data. Although more biologists are taking to the commandline many do not have the time or inclination to really get to grips with the more obtuse programs used in the field of bioinformatics. The aim of this project is to provide conceptually simple programs that perform common useful tasks. 

__UPDATE__

_VERSION 0.1.13:_

30/9/14

-added --summarise option to annovcfToSimple.pl to output variant/genotype counts rather than individual genotypes. Useful for VCFs with lots of samples.

-annovcfToSimple.pl can now work with VCFs containing no samples.

-added documentation for --forks and --cache options to filterOnSample.pl.

-splitMultiallelicVariants.pl now edits AC and AF INFO fields appropriately.

-added --find option to splitMultiallelicVariants.pl to identify and output unbalanced variants without changing variants.

-fixed problem with findBiallelicVep.pl and findBiallelicSnpEff.pl not using --num_matching option correctly when working with PED files.

-getVariantsByLocation.pl now has --vcf_filter option to output variants overlapping those of a another VCF

-also added --matching option to getVariantsByLocation.pl to only output variants with matching alleles to those in VCFs specified by the --vcf_filter option.

-fixed an error that might cause annovcfToSimple.pl to fail as result of trying to merge a single cell


_VERSION 0.1.12:_

1/9/14

-improved getVariantsByLocation.pl handling of missing contigs and invalid regions. Warning are given instead of the program failing.

-added --silent option to getVariantsByLocation.pl to suppress warnings.

-added HGVS annotations to the default fields retrived by annovcfToSimple.pl (when these fields are present).

-getFunctionalVariantsVep.pl and getFunctionalVariantsSnpEff.pl scripts are now more careful with the checking of user-specified variant classes.

-fixed a bug with filterVcfOnVcf.pl where linebreaks would not be added between variants when run without forks. 


_VERSION 0.1.11:_

21/8/14

-fixed a bug in filterOnSample.pl where allele frequency would not be taken into consideration when using --reject or --reject_all_except arguments.

-made filterOnSample.pl quicker

-fixed a bug in filterOnSample.pl where --aff_quality and --un_quality options would be ignored.

-fixed bug when using sortVcf.pl without Sort::External perl module.

-annovcfToSimple.pl correctly handles VEP fields given using the --fields option regardless of case.

-annovcfToSimple.pl now allows you to use the value 'default' with the --fields option to include all default fields plus those specified manually.


_VERSION 0.1.10:_

18/8/14

-in my haste to release v0.1.9 before my holidays I missed a show-stopping bug in the findBiallelic programs due to changes made to enable parallel execution of other scripts. This is now fixed

-fixed a bug where filterOnEvsMaf.pl would not keep track of kept/filtered variants if run without forks

-getVariantsByLocation.pl now allows use of single genomic coordinates (e.g. "X:100000") as well as genomic regions with the --regions option

-support for overlapping CNVs in getVariantsByLocation.pl

-fixed missing line breaks in annovcfToSimple.pl when using text output rather than excel

-added documentation to VcfReader.pm so that the methods are intelligible to other people who may want to use them in their scripts

-sortVcf.pl now uses VcfReader.pm instead of ParseVcf.pm

_VERSION 0.1.9:_

18/7/14

-annotateSnps.pl, filterOnEvsMaf.pl, filterVcfOnVcf.pl and filterOnSample.pl now can all use forks for parallel execution. Execution without forks should be faster also.

-added getVariantsByLocation.pl script to replace filterVcfOnLocation.pl for much faster retrieval of variants by region.

-ensemblGeneAnnotator.pl writes annotations to INFO field, maintaining VCF format.

-annovcfToSimple.pl allows manual selection of VEP fields and INFO fields. Default output is more user-friendly. Gene annotations for multiple genes are now put into split cells.

-VcfReader.pm created to allow for parallel execution in annotateSnps.pl, filterOnEvsMaf.pl, filterVcfOnVcf.pl and filterOnSample.pl and to introduce a faster indexing method for uncompressed VCFs for quicker variant retrieval by positon/region. Version 0.2 will occur once VcfReader.pm replaces the object-oriented ParseVCF.pm in all scripts.

_VERSION 0.1.8a:_

5/6/14

-Fixed bug in findBiallelicSnpEff.pl where --1000_genomes_allele_frequency option would behave opposite to the expected manner (--maf option was not affected by this bug)

-Fixed additional bug in findBiallelicVep.pl and findBiallelicSnpEff.pl when using --min_matching_per_family where unaffected parents would be checked for allele segregation even for a sample without the variant allele.

-when using DBNSFP filter expressions in getFunctionalVariantsSnpEff.pl/findBiallelicSnpEff.pl numeric expressions are no longer converted to string expressions when INFO field type is String/Char if the given expression uses numeric style comparators, but users are still warned that INFO field is of type string.

_VERSION 0.1.8:_

3/6/14

-Added feature to filter on allele frequency in filterOnSample.pl and filterVcfOnVcf.pl

-Added feature to filter variants that are homozygous in --reject samples in filterOnSample.pl and filterVcfOnVcf.pl

-Fixed bug with findBiallelicVep.pl where it would fail to use --min_matching_per_family option properly

-Fixed bug where annovcfToSimple.pl expected to see Cadd Phred Score field by default. Now it decides whether to use it by default after checking whether it is present or not in the header.

_VERSION 0.1.7a:_

20/5/14

-Fixed a bug where rankOnCaddScore.pl would mix up scores of multiallelic variants.

-Corrected --allele_ratio_cutoff short option from -x to -z in filterOnSample.pl

_VERSION 0.1.7:_

15/5/14

-Fixed a bug with rankOnCaddScore.pl that meant that --not_found option never outputted anything.

-annotateSnps.pl now adds SnpAnnotation information to INFO field of variants.

-Fixed a bug with ParseVCF.pm where it would miss some INFO fields when Number was '.'

_VERSION 0.1.6:_

6/5/14

-Tabix.pm installation is now only an absolute requirement if you are actually processing bgzip compressed VCFs. Scripts will only error and exit in the absence of Tabix.pm  when processing compressed VCFs.

-added --aff_genotype_quality and --unaff_genotype_quality arguments to findBiallelicVep.pl, filterOnSample.pl and filterVcfOnVcf.pl

-filterVcfOnVcf.pl now only filters if all ALT alleles in input are matched by the filter VCFs.

-annotateSnps.pl, filterOnEvsMaf.pl and filterVcfOnVcf.pl should now do a better job of resolving different allele representations (due to addition of minimizeAlleles function in ParseVCF.pm) plus bug fixes.

-removed findDenovo.pl in favour of more sophisticated options in filterOnSample.pl (see below). Recommended method for finding de novo variants is now (after normal filtering and annotation) to use a command something like: 

filterOnSample.pl -i [var.vcf] -s [sample ID of child] -r [sample ID of mother] [sample ID of father] -c -d 0.1 [options]

...to only output variants that are confirmed absent in the mother and father (i.e. have a called genotype) and do not have a variant allele making up 10 % or more reads in the mother or father. Alternatively:

filterOnSample.pl -i [var.vcf] -s [sample ID of child] -r [sample ID of mother] [sample ID of father] -c -z 0.2 [options]

...will similarly only output variants that are confirmed absent in the mother and father but also filter variants where either the mother or father have a proportion of variant allele reads equal to or greater than 20 % of the proportion of variant allele reads in the child.

-filterOnSample.pl now has --confirm_missing option. When this option is used, variants are only printed to output if they are present in --samples AND are confirmed as not present in --reject samples. Variants that contain no calls (or genotype qualities below the --un_quality threshold) in --reject samples will be filtered. In this way you may identify likely de novo variants in a sample specified by --samples by specifying parental samples with the --reject option, thus avoiding variants where there is not sufficient information to confirm de novo inheritance.

-filterOnSample.pl now has --depth_allele_cutoff option for assessing allele depth in all samples specified using the --reject argument. Any allele with a proportion of reads greater than or equal to this value will be rejected even if the genotypes are not called by the genotyper. For example, a value of 0.1 will reject any allele making up 10 % of reads for a sample specified by --reject even if the sample is called as homozygous reference.

-filterOnSample.pl now has --allele_ratio_cutoff option for comparing the ratio of variant/total allele depths between samples specified using --samples and samples specified using --reject in order to filter variants based on these values.

-added findBiallelicSnpEff.pl for identification of potential biallelic variants using SnpEff variant functional annotations.

-added rankOnCaddScore.pl to rank or filter variants on their CADD score (http://cadd.gs.washington.edu/)

-made default output of annovcfToSimple.pl more user-friendly (plus minor bug fixes and code improvements).

-added option to annovcfToSimple.pl to use PED files to specify which samples to output genotypes for.

-added option to annovcfToSimple.pl to output INFO fields as columns.

_VERSION 0.1.5:_

28/3/14

-added feature to allow use of a PED file with findBiallelicVep.pl.

-removed --allow_missing feature of findBiallelicVep.pl because it was not working properly.

-added option to report biallelic variants present in a given number of samples rather than all to findBiallelicVep.pl.

-changed default minimum genotype quality (--quality) for findBiallelicVep.pl and filterOnSample.pl from 0 to 20.

-changed filterOnSample.pl to allow users to specify samples to reject without specifying samples to keep.

-added --reject_all_except (-x) option to findBiallelicVep.pl and filterOnSample.pl to allow users to reject variants in all samples in a VCF except for those specified by this option or --samples (-s) option.

-added --num_matching option to filterOnSample.pl to allow users to specify a minimum number of samples that must contain a variant allele in order to print variant.

-made filterVcfOnLocation.pl more lenient regarding region/bed formats.

-annotateSnps.pl checks dbSNP VCF files are sorted in coordinate order.

-annotateSnps.pl checks dbSNP VCF files for relevant INFO fields.

-improved documentation of annotateSnps.pl 

-fixed option spec in getFunctionalVariantsSnpEff.pl

-fixed test for EFF header line in readSnpEffHeader() method in ParseVCF.pm (used by getFunctionalVariantsSnpEff.pl).

-changed filterOnSample.pl to use ParseVCF.pm

-added ParsePedfile.pm module

_VERSION 0.1.4:_

27/1/14

-added getFunctionalVariantsSnpEff.pl program and DbnsfpVcfFilter.pm module.

-added SnpEff annotation parsing functions to ParseVcf.pm.

-added features to getFunctionalVariantsVep.pl and findBiallelicVep.pl enabling filtering of splice_region_variants using annotations from my SpliceConsensus VEP plugin. In practice this means that you can select variants on a slightly stricter definition of the splice consensus region (3 bp before the exon to the first 3 bp of the exon or the last bp of the exon to 6 bp after the exon).

-following report of the Bio::SeqIO::entrezgene bug the bioperl team have fixed the issue, but at the time of writing the fix will not be in the current version of bioperl.  Instead you will need to replace the Bio::SeqIO::entrezgene.pm module in your bioperl installation with the one here: https://github.com/bioperl/bioperl-live/blob/master/Bio/SeqIO/entrezgene.pm if you wish to update your local database for ensemblGeneAnnotator.pl.

-various documentation tidy-ups

-various code tidy-ups, minor optimisations


_VERSION 0.1.3:_

16/12/13 

-added sortVcf.pl program

-fixed issues with splitMultiallelicVariants.pl always printing to STDOUT and missing out final header line. 

-Updated location of HMD_human5.rpt reference file for ensemblGeneAnnotator.pl.  Bio::SeqIO::entrezgene no longer parses all entrez gene asn.1 records correctly for creating the database - bug reported but an acceptable workaround needed so it is recommended to only use existing databases at this time.


__CODE__

These scripts were written __David A. Parry__, a geneticist/molecular biologist at the University of Leeds.  These were written and modified over a period of self-tutelage in which my programming styles/skills have been changeable so anyone browsing code may see varying states of readability and documentation. This is an issue I hope to tidy up over time. 

__CREDIT__

These scripts were written __David A. Parry__, a geneticist/molecular biologist at the University of Leeds.

__If you find these programs useful and use them for a paper__ ***please cite the URL <https://sourceforge.net/projects/vcfhacks/> *** 

__COPYRIGHT AND LICENSE__

Copyright 2013,2014  David A. Parry

These programs are free software: you can redistribute them and/or modify them under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. These programs are distributed in the hope that they will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.



__Thanks!__