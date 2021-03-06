#!/usr/bin/env perl
use strict;
use warnings;
use File::Copy::Recursive qw(rcopy);
use File::Path qw (remove_tree);
use File::Basename;
use FindBin qw($Bin);

my $pp = shift;
$pp ||= `which pp`;
chomp $pp;
die "Could not find pp binary\n" if not $pp;

my @needs_tabix =  
qw (
    annotateSnps.pl
    filterOnEvsMaf.pl
    filterVcfOnVcf.pl
    getVariantsByLocation.pl
    rankOnCaddScore.pl
    sampleCallsToInfo.pl
);
my @needs_sort_external = 
qw (
    sortVcf.pl
    rankOnCaddScore.pl
);

my $dir = "$Bin/../";
chdir($dir) or die "Could not move to $dir: $!\n";
my $bin_dir = "for_binaries_$^O";
mkdir($bin_dir) or die "$!\n";
my @scripts = ();
my @bins = ();
copyAndConvert('./');

#we only make binaries now because we need to be sure that 
#the libs folder has already been copied
foreach my $f (@scripts){
    next if $f =~ /^\./;
    next if $f =~ /sexCheckWrapper\.pl/;
    if ($f =~ /\.pl$/){
        (my $exe = $f) =~ s/\.pl$//;
        my $pp_cmd = "$pp --lib lib/ --lib lib/dapPerlGenomicLib --lib lib/Bioperl --lib lib/BioASN1EntrezGene/lib";
        $pp_cmd .= " -c $f -o $exe";
        my $s = fileparse($f); 
        if (grep {$_ eq $s} @needs_tabix){
            $pp_cmd .= " -M Bio::DB::HTS::Tabix";
        }
        if (grep {$_ eq $s} @needs_sort_external){
            $pp_cmd .= " -M Sort::External";
        }
        if ($s eq "geneAnnotator.pl"){
            $pp_cmd .= " -M Bio::SeqIO::entrezgene" . 
                       " -M HTTP::Tiny -M JSON  -M JSON::backportPP";
        } 
        print STDERR "Making binary with command: $pp_cmd\n";
        system($pp_cmd); 
        if ($?){
            print STDERR "WARNING - $pp_cmd exited with status $?\n";
        }else{
            print STDERR "Done.\n"; 
        }
        unlink $f or warn "Error removing $f from $bin_dir: $!\n"; 
        push @bins, fileparse($exe);
    }
}
print STDERR "Cleaning up $bin_dir...\n";
opendir (my $BDIR, $bin_dir) or die "Cannot read directory $bin_dir: $!\n";
my @bfiles = readdir($BDIR); 
close $BDIR;
chdir($bin_dir) or die "Could not move to $bin_dir: $!\n";
foreach my $f (@bfiles){
    next if $f =~ /^\./;
    next if grep {$f eq $_} @bins;
    if ($f !~ /\.pl$/){
        if ( -d $f and $f ne 'data' and $f ne 'accessories' and $f ne 'bin_tests'){
            print STDERR "Recursively removing directory $f.\n";
            remove_tree($f, {verbose => 1} );
        }elsif(not -d $f){
            if (-e $f){
                next if ($f eq 'examples_bin.md' or $f eq 'readme.md');
                print STDERR "Removing file $f.\n";
                unlink $f or warn "ERROR removing $f: $!\n";
            }
        }
    }
}
if (-e 'examples_bin.md'){
    rename 'examples_bin.md', 'examples.md';
    rename 'readme_binaries.md', 'readme.md';
}
if( -d 'bin_tests'){
    rename 'bin_tests', 't';
}
print STDERR "Testing binaries...\n";
system("prove");

sub copyAndConvert{
    my $dir = shift;
    if (not -d "$bin_dir/$dir"){
        mkdir("$bin_dir/$dir") or die "could not create dir $bin_dir/$dir: $!\n";
    } 
    opendir (my $DIR, $dir) or die "Cannot read current directory $dir: $!\n";
    my @files = readdir($DIR); 
    close $DIR;
    @files = grep {$_ !~ /for_binaries|make_binaries/ } @files;
    foreach my $f (@files){
        next if $f =~ /^\./;
        next if $f =~ /sexCheckWrapper\.pl/;
        if ($f =~ /\.pl$/){
            print STDERR "Making refactored copy of $f...\n";
            (my $exe = $f) =~ s/\.pl$//;
            my $out = "$bin_dir/$dir/$f";
            open (my $IN, "$dir/$f") or die "Can't read file $f: $!\n";
            open (my $OUT, ">$out") or die "Can't open $out for writing: $!\n";
            while (my $line = <$IN>){
                $line =~ s/$f/$exe/g; 
                $line =~ s/pod2usage\s*\(/pod2usage(noperldoc => 1, /;
                print $OUT $line;
            }
            close $IN;
            close $OUT;
            push @scripts, "$bin_dir/$dir/$f";
        }elsif($f eq 'accessories'){
            copyAndConvert("$dir/$f");
        }else{
            print STDERR "Copying $dir/$f...\n";
            rcopy("$dir/$f", "$bin_dir/$dir/$f") or die "error copying $dir/$f: $!\n"; 
        }
    }
}
