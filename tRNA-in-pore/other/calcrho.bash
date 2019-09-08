#!/bin/sh



#SBATCH --job-name=3.8arho
#SBATCH --output=op_rho
#SBATCH --error=er_rho
#SBATCH --time=23:00:00
###SBATCH -n=10
#SBATCH --exclusive
###SBATCH --cpus-per-task=4
#SBATCH --partition=ser-par-10g-4
#SBATCH -N 1
#SBATCH --open-mode=append

MYGMXPATH=/home/bandarkar.p/BIN_9/gromacs-pore/bin
source $MYGMXPATH/GMXRC.bash

pore=3.8

for i in `seq 5.0 0.2 33.0`
do
  cd ${pore}nm_${i}/sim0/
  echo 2 | $MYGMXPATH/g_traj_mpi -f ${pore}nm_${i}.xtc -s REMD.tpr -n ../../files/arg_ACL.ndx -ox coord.xvg -com -b 10000 -e 45000 -xvg none
  awk '{ print sqrt(($2-7.9)^2 + ($3-7.9)^2) }' coord.xvg > rho
  rm coord.xvg
  cd ../..
done
