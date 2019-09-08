use warnings;

use List::Util 'max';

print "Enter the atoms list file name. Pass the atoms section of the top file here.:\n" ;
$ATOMSFILENAME = <STDIN>;
chomp($ATOMSFILENAME);

open(ATOMSFILE,"$ATOMSFILENAME");

while(<ATOMSFILE>)
{
	$LINE=$_;
	chomp($LINE);
	$LINE =~ s/^\s+|\s+$//g;
	$LINE =~ s/\s+/ /g;
	@A = split(/ /,$LINE);
	$atomno=$A[0];
	$RESNO[$atomno-1]=$A[2];##The index of this array start from zero instead of one. There for index number = (atom number)-1
	$atomNAME[$atomno-1] = $A[1];
	$RESNAME[$atomno-1] = $A[3]
}


print {STDOUT} "Atom indexing done\n\n";


##for($i = 0; $i< max(@RESNO); $i=$i+1){
##	$writecount[$i] = 0;
##}




print {STDOUT} "Enter the dihedrals list file name. This is the dihedrals section of the top file\n";

$DIHSFILENAME = <STDIN>;

chomp($DIHSFILENAME);

open(DIHSFILE,"$DIHSFILENAME");

##open my $OUTPUT, '>',"full.cont";

##$paircount=1;
##$writebool = 0; 
while(<DIHSFILE>)
{
	$LINE=$_;
	chomp($LINE);
	$LINE =~ s/^\s+|\s+$//g;
        $LINE =~ s/\s+/ /g;
	@A = split(/ /,$LINE);
	##$atom1 = substr($LINE,0,6);
	##$atom2 = substr($LINE,7,6);
	$at0=$atomNAME[$A[0]-1];
	$at1=$atomNAME[$A[1]-1];
        $at2=$atomNAME[$A[2]-1];
        $at3=$atomNAME[$A[3]-1];
	if(($at0 eq 'P') && ( $at1 eq 'O5*') && ( $at2 eq 'C5*') && ($at3 eq 'C4*') ){##Dihedral bond 1
		if($A[7] eq "1"){
			##$writecount[$RESNO[$A[0]-1]-1]+=1;
			open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
			##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
			print {$OUTPUT} "\[ dih1 \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
			close($OUTPUT);
		}
	}
	if(($at0 eq 'O5*') && ( $at1 eq 'C5*') && ( $at2 eq 'C4*') && ($at3 eq 'C3*')){##Dihedral bond 2
                if($A[7] eq "1"){
                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
			open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                	##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                	print {$OUTPUT} "\[ dih2 \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                	close($OUTPUT);
		}
        }
        if(($at0 eq 'C5*') && ( $at1 eq 'C4*') && ( $at2 eq 'C3*') && ($at3 eq 'O3*')){##Dihedral bond 3
                if($A[7] eq "1"){
                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
			open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                	##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                	print {$OUTPUT} "\[ dih3 \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                	close($OUTPUT);
        	}
	}
        if(($at0 eq 'C4*') && ( $at1 eq 'C3*') && ( $at2 eq 'O3*') && ($at3 eq 'P')){##Dihedral bond 4
                if($A[7] eq "1"){
                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
			open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                	##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                	print {$OUTPUT} "\[ dih4 \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                	close($OUTPUT);
		}
        }
        if(($at0 eq 'C3*') && ( $at1 eq 'O3*') && ( $at2 eq 'P') && ($at3 eq 'O5*')){##Dihedral bond 5
                if($A[7] eq "1"){
                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
			open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                	##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                	print {$OUTPUT} "\[ dih5 \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                	close($OUTPUT);
		} 
        }
        if(($at0 eq 'O3*') && ( $at1 eq 'P') && ( $at2 eq 'O5*') && ($at3 eq 'C5*')){##Dihedral bond 6
                if($A[7] eq "1"){
                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
			open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                	##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                	print {$OUTPUT} "\[ dih6 \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                	close($OUTPUT);
		}
        }
	if(($RESNAME[$A[0]-1] eq 'U') ||($RESNAME[$A[0]-1] eq 'C') ){
		if(($at0 eq 'C2') && ( $at1 eq 'N1') && ( $at2 eq 'C1*') && ($at3 eq 'O4*')){##Dihedral Sidechain
			if($A[7] eq "1"){
	                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
                        	open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                        	##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                        	print {$OUTPUT} "\[ sidechain \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                        	close($OUTPUT);
			}
		}
		if(($at0 eq 'O4*') && ( $at1 eq 'C1*') && ( $at2 eq 'N1') && ($at3 eq 'C2')){##Dihedral Sidechain
                        if($A[7] eq "1"){
	                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
                                open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                                ##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                                print {$OUTPUT} "\[ sidechain \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                                close($OUTPUT);
                        }
                }
	}
	
	if(($RESNAME[$A[0]-1] eq 'G') ||($RESNAME[$A[0]-1] eq 'A') ){
                if(($at0 eq 'C4') && ( $at1 eq 'N9') && ( $at2 eq 'C1*') && ($at3 eq 'O4*')){##Dihedral Sidechain
                        if($A[7] eq "1"){
	                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
                                open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                                ##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                                print {$OUTPUT} "\[ sidechain \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                                close($OUTPUT);
                        }
                }
                if(($at0 eq 'O4*') && ( $at1 eq 'C1*') && ( $at2 eq 'N9') && ($at3 eq 'C4')){##Dihedral Sidechain
                        if($A[7] eq "1"){
	                        ##$writecount[$RESNO[$A[0]-1]-1]+=1;
                                open $OUTPUT, ">>", "res$RESNO[$A[0]-1].dih.ndx";
                                ##print {$OUTPUT} $A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n";
                                print {$OUTPUT} "\[ sidechain \]\n",$A[0]," ",$A[1]," ",$A[2]," ",$A[3],"\n\n";
                                close($OUTPUT);
                        }
                }
        }

	
	#$ResDiff = abs($RESNO[$atom2-1]-$RESNO[$atom1-1]);
	#if(1)### Use the condition you want to choose the pairs here. You can obtain the residue number by $RESNO[$atom1-1]
	#{
	#	substr($LINE,14,4," ");
	#	print {$OUTPUT} $LINE," ",$RESNO[$atom1-1]," ",$RESNO[$atom2-1],"\n";
	#}
}

##close($OUTPUT);
close(DIHSFILE);
