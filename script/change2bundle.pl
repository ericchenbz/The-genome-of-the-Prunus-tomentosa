#!//perl
use strict;
open IN,@ARGV[0] || die $!;
my %color;
my $i=1;
my @info;
my $color;
my $rcolor;
while(<IN>){
chomp;
@info=split(/\s+/);
#my $color;
#my $rcolor;
my %deep=("1"=>"vvd","2"=>"vd","3"=>"d","4"=>"l","5"=>"vl","6"=>"vl","7"=>"vl","8"=>"vl");
if ($info[0] =~/1/){
$color="chr1";
}
elsif($info[0] =~/2/){
$color="chr2";
}
elsif($info[0] =~/3/){
$color="chr3";
}
elsif($info[0] =~/4/){
$color="chr4";
}
elsif($info[0] =~/5/){
$color="chr5";
}
elsif($info[0] =~/6/){
$color="chr6";
}
elsif($info[0] =~/7/){
$color="chr7";
}
elsif($info[0] =~/8/){
$color="chr8";
}
elsif($info[0] =~/9/){
$color="chr9";
}
elsif($info[0] =~/10/){
$color="chr10";
}

#my $n=$color{$info[0]};
#$rcolor="$deep{$n}"."$color";
print "link$i"."bundle $info[0] $info[2] $info[3] z=0,color=$color\nlink$i"."bundle $info[4] $info[6] $info[7] z=0,color=$color\n";
$i++;
}
