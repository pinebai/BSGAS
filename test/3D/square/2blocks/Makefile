HOMEDIR=../../../../

all: run

run: compile grid.h5
	@$(HOMEDIR)/bin/BSGAS

compile:
	@$(MAKE) -C $(HOMEDIR) --no-print-directory

../gridgen: ../gridgen.F90
	@$(MAKE) -C ../ gridgen

grid.h5: ../gridgen
	@$< 2

clean:
	@rm -vf *.o *.mod *.dat *.plt *.png *.vtk *.txt *.bin gridgen *.dx stubex *.csv *.h5 *.xdmf fort.*
	@rm -vf bc.cfg
	@rm -vrf *~
