# -*- Makefile -*-

FC      = ifort
OPTIM   = -g -C

FITSDIR = -L/mn/stornext/u3/hke/local/lib -lcfitsio
LAPACK  = -L/mn/stornext/u3/hke/local/lib -llapack -lblas
HEALPIX = -L/mn/stornext/u3/hke/local/lib -lhealpix
HEALINC = -I/mn/stornext/u3/hke/local/include
OUTPUT  = dang

OBJS    = init_mod.o linalg_mod.o foreground_mod.o data_mod.o dang.o

fit_ame: $(OBJS)
	$(FC) $(OBJS) $(HEALPIX) $(FITSDIR) $(LAPACK) -fopenmp -o $(OUTPUT)

# Dependencies
linalg_mod.o           : init_mod.o
data_mod.o             : init_mod.o
foreground_mod.o       : init_mod.o
dang.o : linalg_mod.o data_mod.o foreground_mod.o

# Compilation stage
%.o : %.f90
	$(FC) $(OPTIM) $(HEALINC) $(LAPACK) $(CFITSIO) -c $<

# Cleaning command
.PHONY: clean
clean:
	rm *.o *.mod *~ dang
