#!/usr/bin/perl
#use strict;
#use warnings;
package BellmanFord;
use Carp;
our @ISA = qw(Exporter);
our @EXPORT = qw();
=head1 NAME
#
# BellmanFord : implements the  algorithm for Directed path to find the shortest path from one node to any other on a network.
#
=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does:
The Module is a Flexible and userfriendly implementation of BellmanFord Alorithm and most important, it works for floating point weights!!!.
It reads the graph input from a txt file and outputs the distance and path from source node to all nodes in the graph
Then it gives required shortest path to the destination node.
Output as follows:

Total Nodes = 5  and Links = 8

Welcome to My Bellman algorithm we find solution for source = b and destination
= e
a                  122.0     Null -> a
b                      0     Null -> b
c                     10     Null -> b -> c
d                     20     Null -> b -> c -> d
e                     75     Null -> b -> e

The required solution:
                             Null -> a -> d



Input File format:
nodes <number of nodes>;Links <number of Links>
<node1>,<node2>,<Distance between them (in floating point format)>
once list all nodes separated by comma
path <source node>,<destination node>
nodes 5;links 8
a,b,50.0
a,d,10.0
b,c,10.0
b,e,75.0
c,b,10.0
c,d,10.0
d,c,10.0
d,a,10.0
a,b,c,d,e
path b,e
path a,d


Usage:
use BellmanFord;

$obj = new BellmanFord ('input file path', 'output file path');
$obj->calculate();

example
$obj = new BellmanFord ('C:\input.txt', 'C:\output.txt');
$obj->calculate();

=head1 SUBROUTINES/METHODS
calculate: will calculate the shortest distance and path and will print to output file.
         
=head2 

=cut
#####################################################################################################
=head1 AUTHOR

Rohan Kachewar, C<<  at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests. I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Arjun Surendra.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut




######################### variables #######
sub new
{
       $class = shift;
       $self = {
        input_file => shift,
		output_file => shift,
        };
    # Print all the values just for clarification.
    bless $self, $class;     
	return $self;
	}
sub calculate
{
open FILE, "$self->{input_file}" or die $!;
open FILE2, "$self->{output_file}" or die $!;
 @lines = <FILE>;

 $lines[0] =~/nodes ([0-9]+);links ([0-9]+)/;
 $totNodes = $1;
$links = $2;
print "\nTotal Nodes = $totNodes  and Links = $links\n";
@u1;
@v1;

for ( $i=1; $i<=$links; $i++ ) 
{
$lines[$i] =~/([a-z]),([a-z]),([0-9]+\.[0-9]+)/;
$u1[$i-1] = $1;
$v1[$i-1] = $2;
$wt[$i-1] = $3;
}
$nodeStr = $lines[$links + 1];
chomp ($nodeStr);
@nodes12 = split(',',$nodeStr);
 
@startNode;
@endNode;
$infinity = "122.0";
$lenOfFile = @lines;
$m = 0;
for ($t = $links + 2; $t < $lenOfFile-1; $t++) {
$lines[$t] =~/^path ([a-z]),([a-z])/;
$startEndNode[$m] = "$1,$2";
$m++;
}

foreach  $pair (@startEndNode) {

$pair =~/([a-z]),([a-z])/;
$root = $1;
$destination = $2;
print "\nWelcome to My Bellman algorithm we find solution for source = $1 and destination = $2\n";
open FILE2, ">>output.txt" or die $!;
print FILE2 "\nWelcome to My Bellman algorithm we find solution for source = $1 and destination = $2\n";
@node = @nodes12;

%dist;
%prev;

############################ the algorithm ####

# first, set all distances to infinity
foreach $n (@node) { 
	$dist{$n} = $infinity; 
	$prev{$n}= Null; 	
	}

# .. except the source
$dist{$root} = 0;

for ($l=0; $l < $totNodes - 1; $l++) {
	for ($n=0; $n < $links - 1; $n++) {
	 $u = $u1[$n];
	 $v = $v1[$n];
	 if ($dist{$u} + $wt[$n] < $dist{$v}) {
	  $dist{$v} = $dist{$u} + $wt[$n];
	  $prev{$v} = $u;
	}	
  }
}



##### print the solutions ######
$p = 0;
$path;

format STDOUT =
@<<<<<<<<<<<<<<   @>>>>>     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    $p,           $dist{$p}, $path;
.

foreach $p (@node) { 
    $t = $p;
    $path = $t;
    while ($t ne Null) { $t = $prev{$t}; $path = "$t -> " . $path; }
    write;
}

$n = $destination; 
$t = $n;
$path = $t;
print "\nThe required solution:\n"; 
while ($t ne Null) { $t = $prev{$t}; $path = "$t -> " . $path; }
write;

##########writing to output file



format FILE2 =
@<<<<<<<<<<<<<<   @>>>>>     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    $n,           $dist{$n}, $path;
.

foreach $n (@node) { 
    $t = $n;
    $path = $t;
    while ($t ne Null) { $t = $prev{$t}; $path = "$t -> " . $path; }
    write FILE2;
}

$n = $destination; 
$t = $n;
$path = $t;
print FILE2 "\nThe required solution:\n"; 
while ($t ne Null) { $t = $prev{$t}; $path = "$t -> " . $path; }
write FILE2;

  }
}
1;





