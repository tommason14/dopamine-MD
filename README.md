# Files associated with "Structural elucidation of polydopamine facilitated by ionic liquid solvation"

## Example simulations

Simulation files are created using the CLPol forcefield, with solute molecules
parameterised via Ligpargen. Atomic polarisabilities were calculated according
to the method by [Heid et al](https://pubs.rsc.org/en/content/articlelanding/2018/CP/C7CP08549D).

Ensure the OpenMM version is compiled with the [velocity-verlet plugin](https://github.com/z-gong/openmm-velocityVerlet) to enable the temperature-grouped Nose-Hoover thermostat.

Simulations were created via Packmol, then the [mstools](https://github.com/z-gong/ms-tools) package was used to add virtual sites and Drude particles, then also scale LJ terms. This steps are incorporated into [create_openmm.py](database/create_openmm.py), with the setup explained in depth in the supporting information.

## Aggregation analysis

In order to use the `gmx clustsize` tool, a gromacs topology of solute
molecules is required - created using
[make-top.py](aggregation-analysis/make-top.py). Likewise, a trajectory
containing only solute molecules is needed, extracted from the overall
trajectory using
[extract_selection.py](aggregation-analysis/extract_selection.py).
`gmx grompp` is used to create the necessary `tpr` file, then `gmx clustsize`
is run, with analysis performed using
[compare_cutoffs.py](aggregation-analysis/compare_cutoffs.py). All
steps are combined in a [shell
script](aggregation-analysis/analyse_clusters.sh) for convenience.
