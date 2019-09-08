#!/bin/bash

#BATCH --job-name=arg3.8
#SBATCH --output=opeql1
#SBATCH --error=ereql1
#SBATCH --time=23:00:00
###SBATCH -n 4
#SBATCH --exclusive
###SBATCH --cpus-per-task=2
#SBATCH --partition=ser-par-10g

#SBATCH -N 1
#SBATCH --open-mode=append




source /home/bandarkar.p/BIN_9/gromacs-pore/bin/GMXRC.bash
export OMP_NUM_THREADS=1


## energy minimization
##grompp -f enmin.mdp -c AKE.gro -p AKE.top -o min.tpr
##sleep 10
##mdrun -s min.tpr -v -noddcheck -c min.gro -table table_file.xvg -tablep table_file.xvg -pore
##sleep 10

## md-run

MYGMXPATH=/home/bandarkar.p/BIN_9/gromacs-pore/bin

##seq 18.0 -0.2 8.0 > list.txt
LAST=18.0

cp arg.15031.3.8nm.gro  $LAST.gro
 
for i in `seq 18.0 -0.2 5.0`
do
  s=`echo "(${i})-1.0" | bc`

  sed 's/$PULLDIST/'$s'/' <enm_arg_3.7r.mdp > ${i}_enm.mdp

  sed 's/$PULLDIST/'$s'/' <arg_3.7r.mdp > $i.mdp


  $MYGMXPATH/grompp_mpi -f ${i}_enm.mdp -c $LAST.gro -p arg_w.15031.top -n arg_ACL.ndx -o ${i}_min.tpr -po ${i}enmout.mdp
  sleep 10

  mpirun -prot -TCP -srun -n 4 $MYGMXPATH/mdrun_mpi -s ${i}_min.tpr -v -noddcheck  -maxh 23 -pore -deffnm enmin_${i} -table table_file6_12.xvg -tablep table_file6_12.xvg
  sleep 10

  cp enmin_${i}.gro out_${i}.gro
  rm enmin_${i}*
  
  $MYGMXPATH/grompp_mpi -f $i.mdp  -c out_${i}.gro -p arg_w.15031.top -n arg_ACL.ndx -o $i.tpr -po ${i}out.mdp
  sleep 10
  
  mpirun -prot -TCP -srun -n 4 $MYGMXPATH/mdrun_mpi -s $i.tpr -v -noddcheck -cpi $i.cpt -maxh 23  -pore -deffnm $i -px ${i}x.xvg -pf ${i}f.xvg -xvg none -table table_file6_12.xvg -tablep table_file6_12.xvg
  sleep 10
  LAST=$i
done
