# GROMACS water box benchmark

This repo contains files to create and run GROMACS benchmarks of a TIP3P water box.

It is based on work from here: https://gaseri.org/en/tutorials/gromacs/1-tip4pew-water/

in "./bench_files" there are prepared .tpr files for different system sizes. The "xN" suffix denotes the size relative the size of the smallest system.
"bench_water_x1.tpr" is a box with volume 3.0nm^3, and contains 884 water molecules.  "bench_water_x2.tpr" is twice the volume and contains approximately twice the number of water molecules. 
We have included upto x1024 which was a volume of 3072nm^3 and contains approximately 900,000 water molecules.

The benchmarks can be run as
>gmx mdrun -s water_x1.tpr


## Creating larger boxes
The scripts to create the water boxes are in "./setup"
To create a box size with a different multiplier you can change the value of "L" on line 7 of "setup/steps.sh".
you can then run the script "steps.sh" from within the setup directory.
>bash steps.sh

This script should work on ARCHER2, it may need configuring to work on a different system.
