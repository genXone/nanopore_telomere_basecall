#!/usr/bin/perl

use strict;
use warnings;

my $original_fastq 	= $ARGV[0];
my $rebasecalled_fastq 	= $ARGV[1];
#my $fixed_fasta		= 


open(my $FIXED_READS, "|-", "pigz -cd $rebasecalled_fastq") || die $!;
my %fixed_reads_hash;
my %fixed_quals_hash;
while(my $readname = <$FIXED_READS>){
	chomp($readname);
	my $readname_clean = substr($readname, 1);
	my $sequence = <$FIXED_READS>;
	chomp($sequence);
	$fixed_reads_hash{$readname_clean} = $sequence;
	my $sep = <$FIXED_READS>;
	chomp($sep);
	my $qual = <$FIXED_READS>;
	chomp($qual);
	$fixed_quals_hash{$readname_clean} = $qual;
}
close($FIXED_READS);


open(my $ORIGINAL_READS, "|-", "pigz -cd $original_fastq") || die $!;
while(my $readname = <$ORIGINAL_READS>){
	chomp($readname);
	my $readname_long = substr($readname, 1);
	my $sequence = <$ORIGINAL_READS>;
	chomp($sequence);
	my $sep = <$ORIGINAL_READS>;
	chomp($sep);
	my $qual = <$ORIGINAL_READS>;
	chomp($qual);

	my @readname_split = split(" ",$readname_long); 
	my $readname_clean = $readname_split[0];
	# Replace with fixed reads if name matches
	if(exists($fixed_reads_hash{$readname_clean})){
		my $fixed_read_curr_sequence = $fixed_reads_hash{$readname_clean};
		my $fixed_qual_curr_sequence = $fixed_quals_hash{$readname_clean};
		print "@" . $readname_long . "\n";
		print $fixed_read_curr_sequence . "\n";
		print $sep . "\n";
		print $fixed_qual_curr_sequence . "\n";
	}
	# Use original reads if does not match
	else{
		print "@" . $readname_clean . "\n";
		print $sequence . "\n";
		print $sep . "\n";
		print $qual . "\n";
	}
}
close($ORIGINAL_READS);


