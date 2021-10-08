MOLS=~/dopamine-MD/database/mols
FF=~/dopamine-MD/database/ff
sed 's/SCALE_SIGMA 0.985/SCALE_SIGMA 0.975/' ~/dopamine-MD/database/ff/CLPol-ljscale.ff > ljscale.ff
create_openmm.py -f $MOLS/ind.xyz $MOLS/water.zmat -n 20 2000 -ff $FF/ff.zfp $FF/SWM4-NDP.zfp -s ljscale.ff -d -v -b 55
