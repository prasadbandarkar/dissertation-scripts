#!/bin/sh


#SBATCH --job-name=3.8arid$PULLDIST
#SBATCH --output=oparidQ
#SBATCH --error=eraridQ
#SBATCH --time=23:00:00
#SBATCH -n 1
##SBATCH --exclusive
###SBATCH --cpus-per-task=4
#SBATCH --partition=ser-par-10g,ser-par-10g-2
#SBATCH -N 1
#SBATCH --open-mode=append



##BSUB -J 3.7arid$PULLDIST
##BSUB -o op_HelDis
##BSUB -e er_HelDis
##BSUB -n 1
##BSUB -R "span[ptile=1]"
##BSUB -q ser-par-10g-2
##BSUB -cwd /gss_gpfs_scratch/bandarkar.p/TRNA/REMD/conical/arg/3.7nmHighT/3.7nm_$PULLDIST/sim0/dihdist

MYGMXPATH=/home/bandarkar.p/BIN_9/gromacs-pore/bin
MYDIHFILESPATH=/gss_gpfs_scratch/bandarkar.p/TRNA/REMD/conical/arg/3.7nmHighT/dihfiles/
MYREFFILESPATH=/gss_gpfs_scratch/bandarkar.p/TRNA/REMD/free/arg/dihdist
source $MYGMXPATH/GMXRC.bash

for i in `seq 1 75`
do
   cd res${i}
   for j in `seq 1 6`
   do
     Heldist=`echo -e "$MYREFFILESPATH/res${i}/dih${j}.xvg\ndih${j}.xvg\n" | perl $MYDIHFILESPATH/HellingerDis.pl`; ##Shouldn't work properly. The perl script is incompatible with the arguments. Use Hellinger.pl instead of HellingerDis.pl
     echo -e "$j $Heldist\n" >> HelDis${i} 
   done
   Heldist=`echo -e "$MYREFFILESPATH/res${i}/sidechain.xvg\nsidechain.xvg\n" | perl $MYDIHFILESPATH/HellingerDis.pl`;
   echo -e "sidechain $Heldist\n" >> HelDis${i}
   cd ..
done

i=76
cd res${i}
for j in `seq 1 3`
do
  Heldist=`echo -e "$MYREFFILESPATH/res${i}/dih${j}.xvg\ndih${j}.xvg\n" | perl $MYDIHFILESPATH/HellingerDis.pl`;
  echo -e "$j $Heldist\n" >> HelDis${i}
done
Heldist=`echo -e "$MYREFFILESPATH/res${i}/sidechain.xvg\nsidechain.xvg\n" | perl $MYDIHFILESPATH/HellingerDis.pl`;
echo -e "sidechain $Heldist\n" >> HelDis${i}
cd ..

