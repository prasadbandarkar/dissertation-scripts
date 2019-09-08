#!/bin/sh



#SBATCH --job-name=3.8ordpar
#SBATCH --output=op_ordpar
#SBATCH --error=er_ordpar
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
  echo 2 | $MYGMXPATH/g_principal_mpi -f ${pore}nm_${i}.xtc -s REMD.tpr -n ../../files/arg_ACL.ndx -a1 axis1.dat -a2 axis2.dat -a3 axis3.dat -om moi.dat -b 10000 -e 45000
  rm axis1.dat axis2.dat moi.dat
  awk '{ print $1,$2}' axis3.dat > cosineangle
  rm axis3.dat
  cd ../..
done
