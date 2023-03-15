#!/bin/bash

set -e

cd clarity3d
qsub remote8.pbs  
qsub remote4.pbs
qsub localonly.pbs
cd ..

cd gromacs/polymer_physics_pspss5
qsub submit_broadwell_1node.sh
qsub submit_broadwell_2nodes.sh
qsub submit_broadwell_4nodes.sh
cd ../..

cd lammps/polymer_physics_cpu_uef/atomistic/
qsub submit.v100.kokkos.cpu.noneigh1node
qsub submit.v100.kokkos.cpu.noneigh2nodes
qsub submit.v100.kokkos.cpu.noneigh4nodes
cd ../../..

cd lammps/polymer_physics_cpu_uef/beadspring/
qsub submit.v100.kokkos.cpu.noneigh.1node
qsub submit.v100.kokkos.cpu.noneigh.2nodes
qsub submit.v100.kokkos.cpu.noneigh.4nodes
cd ../../..

cd lammps/polymer_physics_nouef
qsub submit.p100.1node
qsub submit.p100.2nodes
qsub submit.p100.4nodes
cd ..


