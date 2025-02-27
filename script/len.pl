#!/usr/bin/perl
use strict;

open IN,@ARGV[0] || die $!;
$/=">"; <IN>; $/="\n";
while(<IN>){
	my $name=$1 if( $_=~/^(\S+)/ );
	#print "$name\n";
	$/=">";
	my $seq=<IN>;
	chomp $seq;
	$seq=~s/\s+//g;
	my $len=length($seq);
	$/="\n";
	print "$name\t$len\n";
}
close IN;
