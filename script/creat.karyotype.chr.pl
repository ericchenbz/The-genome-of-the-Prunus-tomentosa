#!/usr/bin/perl
use strict;
my %hash;
open IN,@ARGV[0] || die $!;
while(<IN>){
	chomp;
	my @info=split(/\t/);
	$hash{$info[0]}=$info[1];
}
close IN;

my $i=1;
open IN,@ARGV[1] || die $!;
while(<IN>){
	chomp;
	print "chr - $_ $i 0 $hash{$_} grey\n";
	$i++;
}
close IN;

