use warnings;
use strict;


my $DIHFILENAME=<STDIN>;
chomp($DIHFILENAME);


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
	$sum+=(sqrt($DIHDIST[$i]) - sqrt(1/360))**2;
}

$sum=sqrt($sum/2);

print STDOUT $sum;
