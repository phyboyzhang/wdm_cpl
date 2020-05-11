cmake_minimum_required(VERSION 3.12)
project(wdm_cpl VERSION 0.0.1)
ENABLE_LANGUAGE(CXX Fortran)
#adios2 adds C and Fortran depending on how it was built

set(CMAKE_Fortran_COMPILER gfortran)
set(CMAKE_CC_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)

OPTION(OPENMP_ENABLED       "Enable use of OpenMP library" on)
OPTION(MPI_ENABLED          "Enable use of MPI library"  ON)

SET(CMAKE_FORTRAN_FLAGS "-llpack -lblas -ldfftpack -lfftw3 -lm")

#SET(CMAKE_CXX_FLAGS "-llpack -lblas -ldfftpack -lfftw3 -lm")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)
SET (CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/CMake ${CMAKE_MODULE_PATH} )

SET_DIRECTORY_PROPERTIES(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES ${CMAKE_BINARY_DIR}/modules/)
SET_DIRECTORY_PROPERTIES(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES ${CMAKE_BINARY_DIR}/bin/)
SET_DIRECTORY_PROPERTIES(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES ${CMAKE_BINARY_DIR}/include/) 
ADD_CUSTOM_TARGET( clear
COMMAND find . -name *.mod -delete
COMMAND find . -name *.a -delete
COMMAND find . -name *.o -delete
COMMAND find . -name *.cmake -delete
COMMAND find . -name *.xmf -delete
COMMAND find . -name *.h5 -delete
COMMAND find . -name *.gnu -delete
COMMAND find . -name *.dat -delete
COMMAND rm -rf bin
WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
COMMENT "Delete all .a, .mod, .o and folders /modules, /bin" VERBATIM)

find_package(LAPACK)
if(LAPACK_FOUND)
  MESSAGE(STATUS "The path of lapack is ${LAPACK_LIBRARIES}")
endif()
find_package(BLAS)
if(BLAS_FOUND)
  MESSAGE(STATUS "The path of blas is ${BLAS_LIBRARIES}")
endif()
find_library(FFTW3_LIBRARIES fftw3)

find_package(HDF5)
if(HDF5_FOUND)
  MESSAGE(STATUS "HDF5_INCLUDE_DIRS: ${HDF5_INCLUDE_DIRS}")
  set(HDF5LIBS ${HDF5_LIBRARIES})
  MESSAGE(STATUS "HDF5_LIBRARIES: ${HDF5_LIBRARIES}")
  include_directories(${HDF5_INCLUDE_DIRS})
endif()

find_package(MPI REQUIRED)
include_directories(${MPI_INCLUDE_PATH})

FILE(GLOB_RECURSE MACROS ${PROJECT_SOURCE_DIR}/src/*.h)
FILE(COPY ${MACROS} DESTINATION ${CMAKE_BINARY_DIR}/include)
INCLUDE_DIRECTORIES(${CMAKE_BINARY_DIR}/include)


include(CTest)
enable_testing()

ADD_SUBDIRECTORY(test)

file(GLOB TARGETS "*.EXE *.dll")
set_target_properties(
  ${GLOB}
  PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
  )
