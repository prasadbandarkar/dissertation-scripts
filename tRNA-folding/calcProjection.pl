use warnings;

print {STDOUT} "Enter the xtc file name:\n";
my $XTCFILENAME = <STDIN>;
chomp($XTCFILENAME);

print {STDOUT} "Enter the index file name:\n";
my $NDXFILENAME = <STDIN>;
chomp($NDXFILENAME);

print {STDOUT} "Enter the tpr file name:\n";
my $TPRFILENAME = <STDIN>;
chomp($TPRFILENAME);

print {STDOUT} "Enter the output file name:\n";
my $OUTPUTFILENAME = <>;
chomp($OUTPUTFILENAME);

my $GMXPATH="/home/bandarkar.p/BIN_9/gromacs-pore/bin";
my $SKIPFRAMES=1;
`$GMXPATH/trjconv_mpi -skip $SKIPFRAMES -f $XTCFILENAME -n $NDXFILENAME -s $TPRFILENAME -o tmp.pdb -b 20000 -e 40000`;

open(PDB,"tmp.pdb") or die "pdb file missing";
open my $OUTPUTFILE , ">" , $OUTPUTFILENAME;

##$Sll=5.0;
##$Sul=15.0;
##$Lll=-5.0;
##$Lul=25.0;

##$Scount = 0;
##$Scountext = 0;
##$Szavg = 0;

##$zcurrent=0;

##$Lcount=0;
##$Lcountext = 0;
##$Lzavg = 0;



while(<PDB>){
        $LINE = $_;
        chomp($LINE);
        if(substr($LINE,0,4) eq "ATOM"){
                $zcurrent =substr($LINE,46,8)/10;
                if( ($zcurrent >= $Sll) && ($zcurrent <= $Sul )){
                        $Szavg += $zcurrent;
                        $Scount++;
                }
		if( $zcurrent > $Sul ){
			$Scountext++;
		}
		if( ($zcurrent >= $Lll) && ($zcurrent <= $Lul )){
                        $Lzavg += $zcurrent;
                        $Lcount++;
                }
		if( $zcurrent > $Lul ){
                        $Lcountext++;
                }
        }
        if(substr($LINE,0,3) eq "TER"){
                if($Scount !=0){
			$Szavg = $Szavg/$Scount;
		}
		if($Lcount !=0){
                        $Lzavg = $Lzavg/$Lcount;
                }

                print {$OUTPUTFILE} $Scountext," ",$Scount," ",$Szavg," ",$Lcountext," ",$Lcount," ",$Lzavg,"\n";
                $Scount=0;
		$Scountext=0;
                $Szavg=0;
		$Lcount=0;
		$Lcountext=0;
		$Lzavg = 0;
                $zcurrent=0;
        }
}

close(PDB);
close($OUTPUTFILE);

`rm tmp.pdb`;
