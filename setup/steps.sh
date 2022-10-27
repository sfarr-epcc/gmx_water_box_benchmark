
# from here, but using TIP3P:
# https://group.miletic.net/en/tutorials/gromacs/1-tip4pew-water/


# L controls the boxsize
L=1


BOXSIZE=$(python -c "print(3.0*${L}**(1.0/3.0))")

NTMPI=4


echo $BOXSIZE

export  OMP_NUM_THREADS=1

module load gromacs

export GMX_MAXCONSTRWARN=-1

## make topolgy

rm topol.top
echo '#include "oplsaa.ff/forcefield.itp"' > topol.top
echo '#include "oplsaa.ff/tip3p.itp"' >> topol.top
echo '' >> topol.top
echo '[ System ]' >> topol.top
echo 'TIP3P water' >> topol.top
echo '' >> topol.top
echo '[ Molecules ]' >> topol.top



## make the box of water
gmx solvate -cs spc216.gro -o conf.gro -box $BOXSIZE $BOXSIZE $BOXSIZE -p topol.top


## minimisation 1
gmx grompp -f mdp/min.mdp -o min -pp min -po min
gmx mdrun -deffnm min -ntmpi ${NTMPI}

## minimisation 2
gmx grompp -f mdp/min2.mdp -o min2 -pp min2 -po min2 -c min -t min
gmx mdrun -deffnm min2 -ntmpi ${NTMPI}

## nvt
gmx grompp -f mdp/nvt.mdp -o nvt -pp nvt -po nvt -c min2 -t min2
gmx mdrun -deffnm nvt -ntmpi ${NTMPI} -v

## npt
gmx grompp -f mdp/npt.mdp -o npt -pp npt -po npt -c nvt -t nvt
gmx mdrun -deffnm npt -ntmpi ${NTMPI} -v

## setup md
gmx grompp -f mdp/md.mdp -o md -pp md -po md -c npt -t npt


