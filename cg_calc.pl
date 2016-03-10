#!/usr/bin/perl 
use strict; 

my $infile = "$ARGV[0]";
open INFILE, $infile or die "$infile: $!\n";

my $label;

while (my $line = <INFILE>){ 
    chomp $line;

    my @seq = split (/>/, $line);
    
    if ($line =~ />(.*)/){
        $label = $1

    } else{
    if ($line !~ />/){
        my $G = ($line =~ tr/G//);
        my $C = ($line =~ tr/C//);
        my $total = $G + $C;
        my $length = length($line);
        my $percent = ($total / $length) * 100;

        print "The percentage of G's and C's for $label, @seq[1] is $percent\n";
    }
}


}

close INFILE
