use warnings;

##This script was modified from the LJEnergy script
# Heavily derived from the Qhist script and the Contact.AA.pl script

#Stuff that needs to be changed
#1.Gromacs path under the variable name $GMXPATH
#2.Total number of residues for different molecules
#3.SKIPFRAMES
#4.The gromacs section of the code is marked. You can introduce more options like -b and -e to look at different sections of the trajectory.

$NoOfRes = 76; #IMPORTANT. arg=76  ile = 75

$CUTOFF = 1.5;

print {STDOUT} "Enter the xtc file name:\n";
$XTCFILENAME = <STDIN>;
chomp($XTCFILENAME);

print {STDOUT} "Enter the contact pairs file. This should be similar to the pairs section from the top file with two extra columns at the end:\n";
## The contacts pairs file is similar to the pairs section from the top file. The two additional columns at the end correspond to the residue numbers for the two atoms in the same order.
$CONTFILE = <STDIN>;
chomp($CONTFILE);

###################################################################
#The contact pairs file is read here and stored into variables

open(CONaa,"$CONTFILE")  or die "no AA contacts file";
$CONNUMaa=0;
while(<CONaa>){
        $ConI=$_;
        chomp($ConI);
        $CONNUMaa ++;

        @TMP=split(" ",$ConI);
        $Iaa[$CONNUMaa]=$TMP[0];
        $Jaa[$CONNUMaa]=$TMP[1];
	#$c6aa[$CONNUMaa]=$TMP[2];
	#$c12aa[$CONNUMaa]=$TMP[3];
	$ResIaa[$CONNUMaa]=$TMP[4];
	$ResJaa[$CONNUMaa]=$TMP[5];
        # this gets the native distances from the 6-12 parameters and converts to Ang.
	$Raa[$CONNUMaa]=(2*$TMP[3]/$TMP[2])**(1/6.0)*10.0;
	 }

close(CONaa);


@weightres = (0) x $NoOfRes;

for($i=1;$i<=$CONNUMaa;$i+=1)
{
        	$weightres[$ResIaa[$i]-1] += 1;
        	$weightres[$ResJaa[$i]-1] += 1;
}



#####################################################################################
#The line below has been moved to the top of the file
####$NoOfRes = 76; #IMPORTANT. arg=76  ile = 75
####################################################################################

@freqres = (0) x $NoOfRes;

print {STDOUT} "Enter the tpr file name:\n";
$TPRFILENAME = <STDIN>;
chomp($TPRFILENAME);

print {STDOUT} "Enter the index file name. This is the regular index file formatted for Gromacs:\n";
$NDXFILENAME = <STDIN>;
chomp($NDXFILENAME);

#print {STDOUT} "Enter the output file name:\n";
#$OUTPUTFILENAME = <>;
#chomp($OUTPUTFILENAME);

#print {STDOUT} "Enter the average file name:\n";
#$AVERAGEFILENAME = <>;
#chomp($AVERAGEFILENAME);

##########################################################################

#Gromacs runs here! Change the $GMXPATH to the suitable path.


$GMXPATH="/home/bandarkar.p/BIN_9/gromacs-pore/bin";
#$GMXPATH="~/Simulations/Installed/BIN_2/gromacs-pore/bin";
$SKIPFRAMES=1;
`echo 0| $GMXPATH/trjconv_mpi -skip $SKIPFRAMES -f $XTCFILENAME -n $NDXFILENAME -s $TPRFILENAME -o tmp.pdb -b 10000 -e 45000`;




###################################################################

#for($i=1;$i<=$NoOfRes;i+=1)
#{
#	open($Histfile)
#}

open(PDB,"tmp.pdb") or die "pdb file missing";
open($OUTPUTFILE,">$XTCFILENAME.QwhamHist_bp") or die "couldn't open the QWHAMhist file";

open($wtOUTPUTFILE,">$XTCFILENAME.QwhamHistwt_bp") or die "couldn't open the QWHAMhistwt file";


#$frame=0;

while(<PDB>)
{
	$LINE=$_;
	chomp($LINE);
	if(substr($LINE,0,5) eq "MODEL")
	{
                $ATOMNUM=0;
        }

	if(substr($LINE,0,4) eq "ATOM")
	{
		$ATOMNUM=$ATOMNUM+1;
		$X[$ATOMNUM]=substr($LINE,30,8);##This stores the coordinates for an atom
		$Y[$ATOMNUM]=substr($LINE,38,8);
		$Z[$ATOMNUM]=substr($LINE,46,8);
	}	

	if(substr($LINE,0,3) eq "TER")
	{
		for($i=0;$i<$NoOfRes;$i=$i+1) ##You reached the end of file, set all the energies from the previous frame to zero
		{
			$freqres[$i]=0;
		}
		
		for($i=1;$i<=$CONNUMaa;$i+=1 ) ##Go over all the lines in the contact pairs file.
		{
			#if(($ResIaa[$i]!=$ResJaa[$i]+1)&&($ResIaa[$i]!=$ResJaa[$i])&&($ResIaa[$i]!=$ResJaa[$i]-1))
			#{
				$R=(sqrt( ($X[$Iaa[$i]]-$X[$Jaa[$i]])**2.0 +
                                	 ($Y[$Iaa[$i]]-$Y[$Jaa[$i]])**2.0 +
                                 	($Z[$Iaa[$i]]-$Z[$Jaa[$i]])**2.0)); ##Calculate the distance R in Angstroms
				##$TempE= ($c12aa[$i]/($R**(12.0)))-($c6aa[$i]/($R**(6.0))); ##Calculate the LJ energy
				if($R<=($CUTOFF*$Raa[$i]))
				{
					$freqres[$ResIaa[$i]-1]+=1;
					$freqres[$ResJaa[$i]-1]+=1;
				}
			#}	
			
		}
		
		
		for($i=0;$i<$NoOfRes;$i=$i+1)
                {
                        print {$OUTPUTFILE} $freqres[$i]," ";  ##This is written to the .LJEprint {$OUTPUTFILE} $freqres[$i]/$weightres[$i]," ";  ##This is written to the .LJE file
			if($weightres[$i]==0)
			{
				print {$wtOUTPUTFILE} $weightres[$i]," ";  ##This is written to the .LJE file
			}
			else
			{
				print {$wtOUTPUTFILE} $freqres[$i]/$weightres[$i]," ";  ##This is written to the .LJE file
			}
                }
		print {$OUTPUTFILE} "\n";
		print {$wtOUTPUTFILE} "\n";

	}
}

close $OUTPUTFILE;
close $wtOUTPUTFILE;

`rm tmp.pdb`
