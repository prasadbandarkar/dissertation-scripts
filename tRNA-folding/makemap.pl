#use warnings;

open(reslist,"reslist");
my %resContlist;
my $counter=0;
while(<reslist>){
    $counter++;
    my $line=$_;
    chomp($line);
    $line =~  s/^\s+|\s+$//g;
    $line =~ s/\s+/ /g;
    $resContlist{$counter}=$line;
}
close(reslist);


open(resmap,"resmap");
my %resContmap;
$counter=0;
while(<resmap>){
    $counter++;
    my $line=$_;
    chomp($line);
    $line =~ s/^\s+|\s+$//g;
    $resContmap{$counter}=$line;
}
close(resmap);


open(pairlist,"arg.cont");

open(pairsout,">contres");

$counter=0;
while(<pairlist>){
    $counter++;
    my $line=$_;
    chomp($line);
    $line =~ s/^\s+|\s+$//g;
    $line =~ s/\s+/ /g;
    @A=split(/ /,$line);
    @B=split(/ /,$resContlist{$resContmap{$counter}});
    print pairsout "$A[0] $A[1] $B[0] $B[1]\n";
}

close(pairlist);
close(pairsout);
