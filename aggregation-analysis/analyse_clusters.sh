#!/usr/bin/env bash

FF=~/dopamine-MD/forcefield/ff
MOLS=~/dopamine-MD/forcefield/mols
SUP=~/dopamine-MD/aggregation-analysis

average=${1:-1} # optionally, pass in number of steps to average over in plots

# Run from base dir

mkdir analysis
cd analysis

###############################################################
#  Making a Gromacs topology file for the dopamine molecules  #
###############################################################

$SUP/make-top.py -f $MOLS/ind.xyz -n 20 -b 55 -ff $FF/ff.zfp -s $FF/CLPol-ljscale.ff -d -o dop.top

################################################################
#  Extracting only the dopamine molecules from the trajectory  #
################################################################

extract_selection.py -sel 'resname ind' ../build/conf.gro ../nvt/dump.dcd -o dop -wrap # creates dop.gro and dop.xtc

#########################
#  Clustering analysis  #
#########################

# most gromacs analysis tools require a binary file that is normally used when running a simulation,
# a .tpr file (portable run file)
# I've added a -maxwarn 1 because gromacs gives a warning when dealing with drude particles

gmx_mpi grompp -f $SUP/em.mdp -c dop.gro -p dop.top -o dop.tpr -maxwarn 1

# Now perform cluster analysis for different cutoff lengths (3-6 angstroms)
mkdir -p {3..6}-angs
for i in {3..6}
do
  echo "Starting $i-angs"
  cd $i-angs
  gmx_mpi clustsize -f ../dop.xtc -s ../dop.tpr -mol -nc -mc -ac -hc -mcn -cut 0.$i >& out.log
  echo "Finished $i-angs"
  cd ..
done

##################################
#  Extract data and plot graphs  #
##################################

# For this example, I only took the first 100 steps of the nvt run.
# When looking at the whole run, you'll probably want to create a rolling mean over time as the number of clusters oscillates a lot.
# Just change this 1 to 50 or 100 to average over every 50 or 100 steps
echo "Plotting data"
python3 $SUP/compare_cutoffs.py $average
