#!/usr/bin/perl 
use strict; 

my $file = "$ARGV[0]";
open FILE, $file or die "$file: $!\n";

my $header;

while (my $line = <FILE>){ 
    chomp $line;

    my @seq = split (/>/, $line);
    
    if ($line =~ />(.*)/){
        $header = $1

    } else{
    if ($line !~ />/){
        my $G = ($line =~ tr/G//);
        my $C = ($line =~ tr/C//);
        my $total = $G + $C;
        my $length = length($line);
        my $percent = ($total / $length) * 100;

        print "The percentage of Cs and Gs for $header, @seq[1] is $percent\n";
    }
}


}

close FILE
