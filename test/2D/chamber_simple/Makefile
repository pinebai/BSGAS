HOMEDIR=../../../

include $(HOMEDIR)Makefile.global

TOOLS_OBJ=$(HOMEDIR)$(TOOLS_DIR)/obj/
CODE_OBJ=$(HOMEDIR)obj/
INCLUDE += -I$(TOOLS_OBJ) -I$(CODE_OBJ)

all: run

gridgen: gridgen.F90 $(TOOLS_OBJ)/module_gridgen.o
	$(FC) $(CFLAGS) $^ -o $@ $(LIBS) $(INCLUDE)


run: compile grid.h5
	@$(HOMEDIR)/bin/BSGAS

compile:
	@$(MAKE) -C $(HOMEDIR) --no-print-directory

grid.h5: gridgen
	@./$<

clean:
	@rm -vf *.o *.mod *.dat *.plt *.png *.vtk *.txt *.bin gridgen *.dx stubex *.csv *.h5 *.xdmf fort.*
	@rm -vf bc.cfg
	@rm -vrf *~

.PHONY: compile 
