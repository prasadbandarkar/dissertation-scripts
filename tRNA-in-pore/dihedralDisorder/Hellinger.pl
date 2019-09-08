use warnings;
use strict;

my $REFFILENAME=<STDIN>;
chomp($REFFILENAME);

my $DIHFILENAME=<STDIN>;
chomp($DIHFILENAME);

open(my $REFFILE,$REFFILENAME) or die "Can't open".$REFFILENAME."file!";

my @REFDIST;
while(<$REFFILE>){
	my $LINE=$_;
	chomp($LINE);
	$LINE =~ s/^\s+|\s+$//g;
	$LINE =~ s/\s+/ /g;
	my @A = split (/ /,$LINE);
	push(@REFDIST,$A[1]);
}
close($REFFILE);

open(my $DIHFILE, $DIHFILENAME) or die "Can't open".$DIHFILENAME."file!";

my @DIHDIST;
while(<$DIHFILE>){
        my $LINE=$_;
        chomp($LINE);
        $LINE =~ s/^\s+|\s+$//g;
        $LINE =~ s/\s+/ /g;
        my @A = split (/ /,$LINE);
        push(@DIHDIST,$A[1]);
}
close($DIHFILE);

my $sum=0;
for(my $i=0; $i< $#DIHDIST; $i++){
	$sum+=(sqrt($DIHDIST[$i]) - sqrt($REFDIST[$i]))**2;
}

$sum=sqrt($sum/2);

print STDOUT $sum;
