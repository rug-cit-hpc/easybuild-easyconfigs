# 
# This file is part of the SIESTA package.
#
# Copyright (c) Fundacion General Universidad Autonoma de Madrid:
# E.Artacho, J.Gale, A.Garcia, J.Junquera, P.Ordejon, D.Sanchez-Portal
# and J.M.Soler, 1996- .
# 
# Use of this software constitutes agreement with the full conditions
# given in the SIESTA license, as signed by all legitimate users.
#
.SUFFIXES:
.SUFFIXES: .f .F .o .a .f90 .F90

SIESTA_ARCH=x86_64-unknown-linux-gnu--unknown

FPP=
FPP_OUTPUT= 
FC=mpif90
FC_SERIAL=gfortran
RANLIB=ranlib

SYS=nag

SP_KIND=4
DP_KIND=8
KINDS=$(SP_KIND) $(DP_KIND)

FFLAGS=-g -O2
FPPFLAGS= -DMPI -DFC_HAVE_FLUSH -DFC_HAVE_ABORT -DCDF
LDFLAGS=

ARFLAGS_EXTRA=

FCFLAGS_fixed_f=
FCFLAGS_free_f90=
FPPFLAGS_fixed_F=
FPPFLAGS_free_F90=

BLAS_LIBS=-lpthread -lopenblas
LAPACK_LIBS=-lopenblas
BLACS_LIBS=/software/software/BLACS/1.1-gompi-2016a/lib/blacsCinit_MPI-LINUX-0.a /software/software/BLACS/1.1-gompi-2016a/lib/blacsF77init_MPI-LINUX-0.a /software/software/BLACS/1.1-gompi-2016a/lib/blacs_MPI-LINUX-0.a
SCALAPACK_LIBS=/software/software/ScaLAPACK/2.0.2-gompi-2016a-OpenBLAS-0.2.15-LAPACK-3.6.0/lib/libscalapack.a

COMP_LIBS=dc_lapack.a 

NETCDF_ROOT=/software/software/netCDF/4.4.0-foss-2016a
NETCDFF_ROOT=/software/software/netCDF-Fortran/4.4.3-foss-2016a
NETCDF_LIBS=-L$(NETCDF_ROOT)/lib64 -L$(NETCDFF_ROOT)/lib -lnetcdf -lnetcdff
NETCDF_INCFLAGS=-I$(NETCDF_ROOT)/include -I$(NETCDFF_ROOT)/include
NETCDF_INTERFACE=

LIBS=$(SCALAPACK_LIBS) $(BLACS_LIBS) $(LAPACK_LIBS) $(BLAS_LIBS) $(NETCDF_LIBS)

#SIESTA needs an F90 interface to MPI
#This will give you SIESTA's own implementation
#If your compiler vendor offers an alternative, you may change
#to it here.
MPI_INTERFACE=libmpi_f90.a
MPI_INCLUDE=.

#Dependency rules are created by autoconf according to whether
#discrete preprocessing is necessary or not.
.F.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_fixed_F)  $< 
.F90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_free_F90) $< 
.f.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FCFLAGS_fixed_f)  $<
.f90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FCFLAGS_free_f90)  $<

