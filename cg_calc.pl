#!/usr/bin/perl 
use strict; 

# opens file. ARGV tells program to get file specified on command line. die kills the program if no infile is found
my $infile = "$ARGV[0]";
open INFILE, $infile or die "$infile: $!\n";

# records headers from file to create output labels
my $label;

# reads each line chomp removes a trailing record separeter from a string so the rest of the sequence can be read
while (my $line = <INFILE>){ 
    chomp $line;

    #creates an array. split splits up a string using a regex delimiter 
    my @seq = split (/>/, $line);
    
    #creates labels for each sequence based on identifying line. If first symbol is >, don't analyze, go to next line
    if ($line =~ />(.*)/){
        $label = $1

    # Calculates percent by calculating the number of Gs and number of Cs in each entry, counts the total number of bases, adds the Gs and Cs together, divides by total base number and multiples by 100
    } else{
    if ($line !~ />/){
        my $G = ($line =~ tr/G//);
        my $C = ($line =~ tr/C//);
        my $total = $G + $C;
        my $length = length($line);
        my $percent = ($total / $length) * 100;

        #prints the percentage of G's and C's for label is x%
        print "The percentage of G's and C's for $label, @seq[1] is $percent\n";
    }
}


}

close INFILE