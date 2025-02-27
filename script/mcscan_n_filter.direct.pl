#! /usr/bin/perl -w

=head1  Name

    mcscan_n_filter.direct.pl

=head1  Description

    this program is used to generate the synteny block information according to the *.aligns file
    and *.gff file(the format is like the inputfile of MCscan),and you can filter the numbers of 
    pairwise synteny block by use the --gene_number parameter.Moreover,this program can identify
    the orientation of the syntenic block.
    
=head1  Version

    Author: Xinming Liang, liangxinming@genomics.org.cn
    date: 2011-03-28
 
=head1  Usage
    
    perl mcscan_n_filter.direct.pl --gene_number <int> *.gff *.aligns outputfile
    --gene_number: the limitation number of the pairwise synteny blocks.
    
=head1 Example
    
    perl mcscan_n_filter.direct.pl --gene_number 20 test.gff test.aligns chr_syn.filter20.txt
    
=cut
use strict;
my ($gene_number,$reference,$compare,$help);
use Getopt::Long;
GetOptions(
        "gene_number:i"=>\$gene_number,
        "ref:s"=>\$reference,
        "cmp:s"=>\$compare,
        "help"=>\$help
        );
$gene_number ||= 20;
$reference ||="";
$compare ||="";

my $gff_file = shift;
my $align_file = shift;
my $syn_file = shift;
my %hash;
die `pod2text $0` if(!$gff_file || !$align_file || !$syn_file || $help);

open GFF,"$gff_file" || die $!;
while (<GFF>)
{
    chomp;
    next if ($_ eq "");
    my ($chr,$gene,$head,$tail) = split /\s+/,$_;
    $hash{$gene} = [$chr,$head,$tail];
}
close GFF;

my ($t,$total_gene,$total_length) = (0,0,0);
open SYN,">$syn_file" || die $!;
open ALI,"$align_file" || die $!;
my $flag = "";
my ($temp,$direct);
my @array;
while (<ALI>)
{
    chomp;
    next if (/^# / or /^####/ or $_ eq "");
    if (/## Alignment.*N=(\d+).*([mp]\S+)$/)
    {
        if ($flag eq 'y')
        {
            &stat (\@array,$direct);
            @array = ();
        }
#        if ($1 > $gene_number and /$reference/ and /$compare/)
        if ($1 > $gene_number)
        {
            $flag = 'y';
            $temp = $1;
            $direct = $2;
            next;
        }else
        {
            $flag = 'n';
            next;
        }
    }
## judge if flag == 'y'	
    if ($flag eq 'y')
    {
        my @info = split /\t/,$_;
        push @array,[$info[1],$info[2]];
    }elsif($flag eq 'n')
    {
        next;
    }
}

if ($flag eq 'y')
{
    &stat (\@array,$direct);
    @array = ();
}
close ALI;
close SYN;

###############################################################
sub stat 
{
    my ($array,$direct) = @_;
    for (my $i=0;$i<scalar(@{$array});$i++)
    {
        my $gene1 = $array->[$i][0];
        my $gene2 = $array->[$i][1];
        print SYN "$hash{$gene1}[0]\t$gene1\t$hash{$gene1}[1]\t$hash{$gene1}[2]\t$hash{$gene2}[0]\t$gene2\t$hash{$gene2}[1]\t$hash{$gene2}[2]\t$direct\n"; 
    }
}
