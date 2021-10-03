#!/usr/bin/env bash
MOLS=~/dopamine-MD/database/mols
FF=~/dopamine-MD/database/ff
create_openmm.py -f $MOLS/c2c1im.zmat $MOLS/otf.zmat $MOLS/dhi.xyz -n 500 500 20 -ff $FF/ff.zfp -s $FF/CLPol-ljscale.ff -d -b 60
