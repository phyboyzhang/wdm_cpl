module use /gpfs/u/software/dcs-spack-install/v0133gcc/lmod/linux-rhel7-ppc64le/gcc/7.4.0-1/
module load gcc/7.4.0/1
module load openmpi/3.1.4-mm5hjuq              #mpich/3.2.1/1
module load \
  cmake/3.15.4-mnqjvz6 \
  adios2/2.5.0-rqsvxj4 \
  fftw/3.3.8-b2oxdb5 \
  netlib-scalapack/2.0.2-7bndnga \
  netlib-lapack/3.8.0-dgrqbf7 
  openblas/0.3.7-x7m3b6w \
  zlib/1.2.11-lpgvqh7 \
  hdf5/1.10.3-ftn-tgragps

#export OMPI_CXX=g++
#export OMPI_CC=gcc
#export OMPI_FC=gfortran

export CMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH:~/barn/build-dcs-gcc74-kokkos3/install
export kk=~/barn/kokkos
export OMPI_CXX=$kk/bin/nvcc_wrapper

export CUDA_DIR=/usr/local/cuda-10.2/
export PATH=$PATH:${CUDA_DIR}/bin
