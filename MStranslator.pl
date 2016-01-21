#!/usr/bin/perl
#________________________________________________________________________LICENSE
#    Use of this software and  associated  documentation  files  (the
#    "Software"), is governed by the Creative Commons  Public  Domain
#    License(the "License"). You may obtain a copy of the License at:
#        https://creativecommons.org/licenses/publicdomain/
#_______________________________________________________________________________
#use strict;
use warnings;
use IO::File;	
use Cwd; my $originalCwd = getcwd()."/";
#___________________________________________________m-expression to s-expression
#equal[xy] =
#	[atom[x] -> [atom[y] -> eq[xy]; T -> F];
#	equal [car [x]car[y]] -> equal [cdr[x];cdr[y]];
#	T -> F]

#m-expression above can be translated into the following S-expresslon:

#(LABEL EQUAL (LAMBDA (X Y) (COND
#	((ATOM X) (COND ((ATOM Y) (EQ X Y)) ((QUOTE T) (QUOTE F))))
#	((EQUAL (CAR X) (CAR Y)) (EQUAL (CDR X) (CDR Y)))
#	((QUOTE T) (QUOTE F)) )))
#______________________________________________________________________open file
$FILE = new IO::File;
$FILE->open("< ".$originalCwd."evalquote-original-M-ex.ocr.txt") || die("Could not open file!");
while (<$FILE>){ $field .= $_; }
$FILE->close;
#_______________________________________________________________________________
#[
#]
$field =~ s/\]/\)/gsm;
#(
#)
$field =~ s/\[/\(/gsm;
#;
# 
#$field =~ s/\;/ /gsm;
#_______________________________________________________________________________
#$1($2) =
#))(LABEL MC.$1 (LAMBDA ($2)
$field =~ s/\n\t{0,0}([^\t\n]*?)\((.*?)\) \=\n/\n))\n\n(LABEL MC.$1 (LAMBDA ($2)\n/gsm;
$field =~ s/\n\n\)\)/))/gsm;
$field =~ s/[^\n]*?\n([^\n]*?)\n(.*\))/$2$1\n/gsm;
#_______________________________________________________________________________
#(a -> b; x -> y)
#(MC.COND ((A)(B)) ((X)(Y)))


#$field =~ s///gsm;
#not working currently
#(A )->( B; X )->( Y)
#(MC.COND ((A)(B)) ((X)(Y)))

#(MC.COND 
#((A)(B))
#)



#(
#(MC.COND ((

#->
#)->( z)

#)


#)->(

#;

#(MC.COND ((



#_______________________________________________________________________________
#justification and various fixes
$field =~ s/( |\t)+\n/\n/gsm;#removes trailing spaces or tabs
#______________________________________________________________________save file
$fh = new IO::File "> ".$originalCwd."evalquote-original-S-ex.txt";
if (defined $fh) { print $fh $field; $fh->close; }


