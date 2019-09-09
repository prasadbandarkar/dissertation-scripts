use warnings;
#use Data::Dumper;

print {STDOUT} "Enter the region list file:\n";
my $RGFILENAME = <STDIN>;
chomp($RGFILENAME);

open(RGfile,"$RGFILENAME") or die "No region list file found\n";
##my $rgcounter=0;
##my %REGION;
my %regA ;
my %regB ;

while(<RGfile>){
    my $line=$_;
    cleanstr($line);
    my @temp=split(/ /,$line);
    %regA = map { $_ => 1 } @temp;
    $line=<RGfile>;
    cleanstr($line);
    @temp=split(/ /,$line);
    %regB = map { $_ => 1 } @temp;
}

close(RGfile);

#print Dumper(\%regA);
#print Dumper(\%regB);

print {STDOUT} "Enter the atom to residue contact list file:\n";
my $mapresFILENAME = <STDIN>;
chomp($mapresFILENAME);

open(mapresfile,"$mapresFILENAME") or die "No atom to residue contact file found\n";

@atomI=();
@atomJ=();
@resI=();
@resJ=();

my $possibleQ=0;

while(<mapresfile>){
    my $line=$_;
    cleanstr($line);
    @A=split(/ /,$line);
    push(@atomI,$A[0]);
    push(@atomJ,$A[1]);
    push(@resI,$A[2]);
    push(@resJ,$A[3]);
    if( (exists($regA{$A[2]}) && (exists($regB{$A[3]}))) || (exists($regB{$A[2]}) && (exists($regA{$A[3]}))) ){
        $possibleQ++;
    }
};

close(mapresfile);

print {STDOUT} "Possible Q is $possibleQ \n\n";

print {STDOUT} "Enter the .AA.Q file name:\n";
my $AAQFILENAME = <STDIN>;
chomp($AAQFILENAME);
open(AAQfile,"$AAQFILENAME") or die "No .AA.Q file found!\n";

print {STDOUT} "Enter the .AA.Qi file name:\n";
my $AAQIFILENAME = <STDIN>;
chomp($AAQIFILENAME);
open(AAQifile,"$AAQIFILENAME") or die "No .AA.Qi file file found\n"; 

print {STDOUT} "Enter the Qregion output file name:\n";
my $REGQFILENAME = <STDIN>;
chomp($REGQFILENAME);
open(RegQfile,">$REGQFILENAME") or die "Can't open an output file\n";


@Qvst=();
while(<AAQfile>){
    my $line=$_;
    cleanstr($line);
    push(@Qvst,$line);
    my $countQ=0;
    for(my $i=0;$i<$line;$i++){
        my $cN=<AAQifile>;#cN is the contact number in the pairs file
        cleanstr($cN);
        if((exists($regA{$resI[$cN-1]}) && exists($regB{$resJ[$cN-1]})) or (exists($regA{$resJ[$cN-1]}) && exists($regB{$resI[$cN-1]})) ){
            $countQ++;
        }
    }
    my $fraction= $countQ/$possibleQ;
    print {RegQfile} "$fraction $countQ\n"
}

close(AAQfile);
close(AAQifile);
close(RegQfile);


sub cleanstr {
    my $text = \shift;
    chomp($text);
    ${$text} =~ s/^\s+|\s+$//g;
    ${$text} =~ s/\s+/ /g;
}