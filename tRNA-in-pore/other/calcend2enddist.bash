#!/bin/bash

#SBATCH --job-name=3.8end2end
#SBATCH --output=op_3.8end2end
#SBATCH --error=er_3.8end2end
#SBATCH --time=23:00:00
###SBATCH -n=10
#SBATCH --exclusive
###SBATCH --cpus-per-task=4
#SBATCH --partition=ser-par-10g-2
#SBATCH -N 1
#SBATCH --open-mode=append


MYGMXPATH=/home/bandarkar.p/BIN_9/gromacs-pore/bin

source $MYGMXPATH/GMXRC.bash

for i in `seq 5.0 0.2 33.0`
do
  cd 3.8nm_${i}/sim0/
  echo -e "0\n1\n"|$MYGMXPATH/g_dist_mpi -f 3.8nm_${i}.xtc -s REMD.tpr -n ../../files/argendP.ndx -o dist172_1 -xvg none -b 10000 -e 45000
  cd ../..
done
