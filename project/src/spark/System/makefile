ifndef SPARK_STATIC_BUILD
 SPARK_STATIC_BUILD := no
endif
## Usage:
##      gmake  [PROJ=xxxx] [SPARK_CLASSPATH=yyyy] [SPARKPARSER_LOG=zzzz] 
##      [clean or cleanALL or distclean or help or makefile.inc or pkg or 
##       prf or run or solver or stp] [SPARK_STATIC_BUILD=yes] [SPARK_DEBUG=yes]
## Where items in [] are optional .
##
## First time, type:
##      gmake PROJ=xxxx    SPARK_CLASSPATH=../class,...etc...
## To create the file 'makefile.inc' and the solver executable
## that has the same name as PROJ .
##
## If 'PROJ=xxxx' is not specified, the default PROJ name is the current
## directory name.
## If 'SPARK_CLASSPATH=...' is not specified, the default for it is :
##  1) The value of the environment variable SPARK_CLASSPATH if that
##     environment variable exists.
##  or
##  2) .,./class,../class,$(SPARK_DIR)/globalclass,$(SPARK_DIR)/hvactk/class
##
## After the first time, type:
##      gmake
## To rebuild the 'makefile.inc' and the solver executable as
## needed using the previous SPARK_CLASSPATH.
##
## If you want a build with Debug information, either set the environment
## variable SPARK_DEBUG=yes, or run gmake with "SPARK_DEBUG=yes" in command line. e.g.
##      gmake .... SPARK_DEBUG=yes
##
## If you want a build that does not load the problem at run time,
## run gmake with "SPARK_STATIC_BUILD=yes" in command line. e.g.
##      gmake ..... SPARK_STATIC_BUILD=yes
##
## Other targets are:
##      gmake clean	        # Delete all intermediate files and targets.
##      gmake cleanALL      # Clean + delete all run subdirectories.
##      gmake cleanIntermediates    # Clean intermediate files. Leave targets.
##      gmake distclean     # cleanALL + delete .bak .set files.
##      gmake help          # Show this information.
##      gmake makefile.inc  # Create makefile.inc file.
##      gmake pkg           # To make ../PROJ_pkg directory.
##      gmake proj_lib      # To make libPROJ.{lib,a} file that contains a library
##                            of compiled atomic classes.
##      gmake proj_libdyn   # To make libPROJ.{dll,so} file that contains a 
##                            dynamic library of compiled atomic classes.
##      gmake prf           # To make PROJ.prf file.
##      gmake run           # To make a run using PROJ.inp as input and PROJ.run
##                            as run control file.  If PROJ.run is missing a
##                            default one is created.
##      gmake solver        # To make the solver executable i.e. PROJ .
##      gmake stp           # To make PROJ.stp file.
##
##      gmake [svg or gif or jpeg or ps or png]  # To make the graph of the
##                            solution sequence in the file PROJ.{ext}, whereby
##                            ext is the the extension for the specified format.
##      gmake [html]        # To make the PROJ.html file that contains the solution
##                            sequence.
##
## To change the sparkparser log file name from 'sparkparser.log' to
## xyz.log , run:
##      gmake SPARKPARSER_LOG=xyz.log  ...
##
## Exit status values are put in file gmake.status :
##
##   1 : Parser error.  Caused by bad ....pr , ....cm , or ....cc file, or
##       bad SPARK_CLASSPATH .  Look at file sparkparser.log .
##   2 : Setup error.   Look at file sparksetup.log .
##   3 : Compiler error while compiling class.cc file(s).
##   4 : Compiler error while compiling M_PROJ.cpp file.
##   5 : Linker error while linking M_PROJ_.o and <CLASS...>.o files.
##   6 : Run error.  Usually 'cant converge'. Look at file run.log .
##
## makefile.inc looks like:
##      M_PROJ=   xxxx
##      M_DEPsCC= ../../globalclass/aaaa.cc  ../class/bbbb.cc
##      M_DEPsCM= ../../globalclass/mmmm.cm
##      SPARK_CLASSPATH= ".,./class,../class,$(SPARK_DIR)/globalclass"
##
##
##
##

include $(SPARK_DIR)/lib/make_compiler.inc

ifneq ("$(MAKECMDGOALS)","help")
 ifndef PROJ
  PROJ := $(notdir $(CURDIR))
 endif
 M_PROJ := $(PROJ)
 ifndef  SPARK_CLASSPATH
  ifneq ("$(wildcard classpath.env)","")
   include classpath.env
  endif
 endif
 ifndef  SPARK_CLASSPATH
  ifneq ("$(wildcard ../classpath.env)","")
   include ../classpath.env
  endif
 endif
 ifndef  SPARK_CLASSPATH
  ifneq ("$(wildcard $(SPARK_DIR)/classpath.env)","")
   include $(SPARK_DIR)/classpath.env
  endif
 endif
 ifndef  SPARK_CLASSPATH
  SPARK_CLASSPATH := .,./class,../class,$(SPARK_DIR)/globalclass,$(SPARK_DIR)/hvactk/class
 endif
 ifeq ($(wildcard gmake.status),gmake.status)
  _TMP_COMMAND_ := $(shell rm -f gmake.status)
 endif
 include  makefile.inc
endif

SPARKPARSER     := $(SPARK_DIR)/bin/sparkparser$(EXE)
override SPARKPARSER_FLAGS := $(SPARKPARSER_FLAGS) -e4 -s6 -p "$(SPARK_CLASSPATH)" 
SPARKPARSER_LOG := sparkparser.log
SPARKSETUP := $(SPARK_DIR)/bin/sparksetup$(EXE)
override SPARKSETUP_FLAGS := $(SPARKSETUP_FLAGS)
SPARKSETUP_LOG := sparksetup.log
MKMAKINC  := $(SPARK_DIR)/bin/mkmakinc$(EXE)
SPARKPREF := $(SPARK_DIR)/bin/sparkpref$(EXE)

override CXXINCLUDES :=-I$(SPARK_DIR)/inc

DEBUGPREFIX :=
ifdef SPARK_DEBUG
 ifeq ($(SPARK_DEBUG),yes)
  DEBUGPREFIX := DEBUG/
 endif
endif

ifeq ($(SPARK_STATIC_BUILD),yes)
 override CXXDEFINES :=$(CXXDEFINES) -DSPARK_STATIC_BUILD
 LIBS := sparksolver_static.$(OBJ_EXT) *_static.$(LIB_EXT)
else
 LIBS := libspark*.$(LIBDYN_EXT)
 ifdef WINDIR
  ifeq ($(CXX),vcpp.sh)
   LIBDYNLIBS := $(SPARK_DIR)/lib/$(DEBUGPREFIX)libsparksolver.$(LIB_EXT)
  else
   LIBDYNLIBS := $(SPARK_DIR)/bin/$(DEBUGPREFIX)libspark*.$(LIBDYN_EXT)
  endif
 else
  LIBDYNLIBS :=
 endif
endif

ifdef WINDIR
 SYSLIBS := -lm
else
 SYSLIBS := -lm -ldl
endif

override LDXXLIBS := $(addprefix $(SPARK_DIR)/lib/$(DEBUGPREFIX),$(LIBS)) $(SYSLIBS)

DEPsO    := $(M_DEPsCC:%.cc=%.$(OBJ_EXT))
DEPsODYN := $(M_DEPsCC:%.cc=%.$(LIBDYN_EXT))

%.$(OBJ_EXT) :	%.cc
	-rm -f	$@
	$(CXX) -c -o $@ $(CXXFLAGS) $(CXXOPTIONS) $(CXXDEFINES) $(CXXINCLUDES) $(SPARK_COMPILE_OPTIONS) $< ;\
	 if [ $$? != 0 ] ; then  echo 3 > gmake.status ; exit 3 ; fi

%.$(OBJ_EXT) :	%.cpp
	-rm -f	$@
	$(CXX) -c -o $@ $(CXXFLAGS) $(CXXOPTIONS) $(CXXDEFINES) $(CXXINCLUDES) $(SPARK_COMPILE_OPTIONS) $< ;\
	 if [ $$? != 0 ] ; then  echo 3 > gmake.status ; exit 3 ; fi

%.$(LIBDYN_EXT) :  %.$(OBJ_EXT)
	-rm -f  $@
	$(LIBDYN_COMMAND) -o $@ $^ $(LIBDYNLIBS) $(SPARK_LINK_DYNAMIC_OPTIONS) ;\
	 if [ $$? != 0 ] ; then  echo 3 > gmake.status ; exit 3 ; fi
ifeq ($(CXX),vcpp.sh)
	-rm -f $*.lib $*.exp
endif

ifeq ($(SPARK_STATIC_BUILD),yes)
 TARGET := $(M_PROJ)$(EXE)
else
 TARGET := $(M_PROJ).xml
endif


.PHONY :  clean cleanALL cleanIntermediates distclean help pkg prf proj_lib \
  proj_libdyn run solver stp $(M_PROJ).out

solver :  makefile.inc
	$(MAKE) $(TARGET)
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

run :  makefile.inc
	$(MAKE) $(M_PROJ).out
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

ifeq ($(SPARK_STATIC_BUILD),yes)
 $(TARGET) :  $(M_PROJ)_.$(OBJ_EXT) $(DEPsO)
	-rm -f $@
	$(LDXX) -o $@ $(LDXXFLAGS) $(LDXXOPTIONS) $^ $(LDXXLIBS) $(SPARK_LINK_STATIC_OPTIONS) ;\
	 if [ $$? != 0 ] ; then  echo 5 > gmake.status ; exit 5 ; fi
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

 $(M_PROJ)_.$(OBJ_EXT) :  $(M_PROJ).cpp
	-rm -f $@
	$(CXX) -c -o $@ $(CXXFLAGS) $(CXXOPTIONS) $(CXXDEFINES) $(CXXINCLUDES) $(SPARK_COMPILE_OPTIONS) $< ;\
	  if [ $$? != 0 ] ; then  echo 4 > gmake.status ; exit 4 ; fi
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"
else
 $(TARGET) :  $(DEPsODYN)
endif

.PRECIOUS :  $(DEPsODYN)

.PRECIOUS :  lib$(M_PROJ).$(LIB_EXT)  lib$(M_PROJ).$(LIBDYN_EXT)

proj_lib :  lib$(M_PROJ).$(LIB_EXT)
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

lib$(M_PROJ).$(LIB_EXT) :  $(DEPsO)
	-rm -f $@
	$(LIB_FROM_OBJs) $(SPARK_LIBS) $(SPARK_LINK_STATIC_OPTIONS) $(SPARK_LINK_DYNAMIC_OPTIONS)
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

proj_libdyn :  lib$(M_PROJ).$(LIBDYN_EXT)
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

lib$(M_PROJ).$(LIBDYN_EXT) :  $(DEPsO)
	@echo "Building project dynamic library $@"
	-rm -f  $@
	$(LIBDYN_COMMAND) -o $@ $^ $(LIBDYNLIBS) $(SPARK_LINK_DYNAMIC_OPTIONS) $(SPARK_LINK_STATIC_OPTIONS) ;\
	 if [ $$? != 0 ] ; then  echo 3 > gmake.status ; exit 3 ; fi
ifeq ($(CXX),vcpp.sh)
	-rm -f $*.lib $*.exp
endif
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"


.PRECIOUS :  $(M_PROJ).prf $(M_PROJ).cpp $(M_PROJ).xml
prf :  $(M_PROJ).prf
$(M_PROJ).prf :  $(M_PROJ).cpp
$(M_PROJ).cpp :  $(M_PROJ).xml
$(M_PROJ).xml :  $(M_PROJ).stp	$(SPARKSETUP)
	-rm -f	$@  $(SPARKSETUP_LOG)
	if [ -r $(M_PROJ).eqs ] ; then \
	 rm -f $(M_PROJ).eqs.tmp ; tail +6 $(M_PROJ).eqs > $(M_PROJ).eqs.tmp ;\
	 rm -f $(M_PROJ).prf.tmp ; cp -p $(M_PROJ).prf $(M_PROJ).prf.tmp ; fi
	$(SPARKSETUP)  $(SPARKSETUP_FLAGS)  $(M_PROJ)   > $(SPARKSETUP_LOG)  2>&1 ;\
	 if [ $$? != 0 ] ; then  echo 2 > gmake.status ; exit 2 ; fi
	if [ -r $(M_PROJ).eqs.tmp -a -r $(M_PROJ).eqs ] ; then \
	 tail +6 $(M_PROJ).eqs > $(M_PROJ).eqsNew.tmp ; \
	 if cmp -s  $(M_PROJ).eqs.tmp $(M_PROJ).eqsNew.tmp ; then \
	  cp -p $(M_PROJ).prf.tmp $(M_PROJ).prf ;\
	 fi ; rm -f $(M_PROJ).eqsNew.tmp ; fi
	rm -f  $(M_PROJ).eqs.tmp  $(M_PROJ).prf.tmp
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

stp :  $(M_PROJ).stp
$(M_PROJ).stp :  $(M_PROJ).pr  $(M_DEPsCM)  $(M_DEPsCC)	 $(SPARKPARSER)
	-rm -f $(M_PROJ).stp $(M_PROJ).tmp $(SPARKPARSER_LOG)
	$(SPARKPARSER) $(SPARKPARSER_FLAGS)  $< 2>&1 | tee $(SPARKPARSER_LOG);\
	  if [ $$? != 0 ] ; then  echo 1 > gmake.status ; exit 1 ; fi
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

$(M_PROJ).out :  $(TARGET) $(M_PROJ).prf $(M_PROJ).run $(M_PROJ).xml
	-rm -f $@ run.log
ifeq ($(SPARK_STATIC_BUILD),yes)
	./$(TARGET) $(M_PROJ).prf $(M_PROJ).run > run.log ;\
	  X=$$? ; if [ $$X != 0 ]; then  echo $$X > gmake.status; exit $$X ; fi
else
	$(SPARK_DIR)/bin/$(DEBUGPREFIX)sparksolver $(M_PROJ).prf $(M_PROJ).run $(M_PROJ).xml > run.log ;\
	  X=$$? ; if [ $$X != 0 ]; then  echo $$X > gmake.status; exit $$X ; fi
endif
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

$(M_PROJ).run :
	@echo "Creating a default $(M_PROJ).run file"
	-rm -f  $@ ;  cp $(SPARK_DIR)/lib/default.run  $@
	if [ -r $(M_PROJ).inp ]; then  $(SPARKPREF) $@ InputFiles = "$(M_PROJ).inp" ;\
	  else  echo "WARNING: Input file $(M_PROJ).inp does not exist." ;  fi
	$(SPARKPREF) $@  OutputFile = "$(M_PROJ).out"
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

makefile.inc :  $(M_PROJ).pr  $(M_DEPsCM)  $(SPARKPARSER)
	-rm -f  $(M_PROJ).stp $(M_PROJ).tmp $(SPARKPARSER_LOG)
	$(SPARKPARSER) $(SPARKPARSER_FLAGS) $< 2>&1 | tee $(SPARKPARSER_LOG) ;\
	if [ -r $(M_PROJ).stp ]	; then	 \
	 Stp=$(M_PROJ).stp 		;\
	elif [ -r $(M_PROJ).tmp ] ; then \
	 Stp=$(M_PROJ).tmp		;\
	 echo 1 > gmake.status		;\
	else \
	 echo 1 > gmake.status ; exit 1	;\
	fi;\
	rm -f makefile.inc;\
	$(MKMAKINC)  $$Stp  >  makefile.inc	;\
	echo "SPARK_CLASSPATH=$(SPARK_CLASSPATH)" >> makefile.inc
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

## [DC/LBNL] 09/16/04 -- Graph of the solution sequence
##   gmake [svg or gif or jpeg or ps or png]  
##
svg : $(M_PROJ).svg
$(M_PROJ).svg : $(M_PROJ).xml
	$(MAKE) -f $(SPARK_DIR)/utils/viewer/makefile.viewer TARGET=$@
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

gif : $(M_PROJ).gif
$(M_PROJ).gif : $(M_PROJ).xml
	$(MAKE) -f $(SPARK_DIR)/utils/viewer/makefile.viewer TARGET=$@
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

jpeg : $(M_PROJ).jpeg
$(M_PROJ).jpeg : $(M_PROJ).xml
	$(MAKE) -f $(SPARK_DIR)/utils/viewer/makefile.viewer TARGET=$@
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

ps : $(M_PROJ).ps
$(M_PROJ).ps : $(M_PROJ).xml
	$(MAKE) -f $(SPARK_DIR)/utils/viewer/makefile.viewer TARGET=$@
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

png : $(M_PROJ).png
$(M_PROJ).png : $(M_PROJ).xml
	$(MAKE) -f $(SPARK_DIR)/utils/viewer/makefile.viewer TARGET=$@
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

html : $(M_PROJ).html
$(M_PROJ).html : $(M_PROJ).xml
	$(MAKE) -f $(SPARK_DIR)/utils/viewer/makefile.viewer TARGET=$@
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"


pkg :  makefile.inc
	-rm -rf	$(M_PROJ)_pkg
	mkdir	$(M_PROJ)_pkg
	cp -p	$(M_DEPsCC)  $(M_DEPsCM)	$(M_PROJ)_pkg
	-cp -p	*.set $(M_PROJ)_pkg
	cp -p	$(M_PROJ).pr $(M_PROJ)_pkg/$(M_PROJ)_pkg.pr
	cp -p   makefile.inc $(M_PROJ)_pkg/makefile.inc.old
	if [ -r  $(M_PROJ).inp ] ;   then \
	  cp -p  $(M_PROJ).inp $(M_PROJ)_pkg/$(M_PROJ)_pkg.inp ;\
	fi
	-cp -p *.inp  $(M_PROJ)_pkg
	-cp -p *.prf  $(M_PROJ)_pkg
	-cp -p *.run  $(M_PROJ)_pkg
	if [ -d  ../$(M_PROJ)_pkg ] ; then  rm -rf ../$(M_PROJ)_pkg ; fi
	mv  $(M_PROJ)_pkg ..
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

clean :  cleanIntermediates
	rm -f $(TARGET)  $(M_PROJ)_.$(OBJ_EXT)
	rm -f lib$(M_PROJ).$(LIB_EXT)
	rm -f lib$(M_PROJ).$(LIBDYN_EXT)
	rm -f $(M_PROJ).html $(M_PROJ).ps $(M_PROJ).svg $(M_PROJ).xml
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

cleanIntermediates :
	-rm -f gmake.status  gmake.log  solver.status 
	-rm -f $(M_PROJ).stp  $(SPARKPARSER_LOG)  $(SPARKSETUP_LOG) 
	-rm -f $(M_PROJ).cpp  $(M_PROJ).eqs
	-rm -f $(M_PROJ).out  $(M_PROJ).init  $(M_PROJ).snap
	-rm -f $(M_PROJ).dot  $(M_PROJ).html  $(M_PROJ).svg  $(M_PROJ).gif  $(M_PROJ).jpeg $(M_PROJ).ps $(M_PROJ).png
	-rm -f $(DEPsO)
	-rm -f $(DEPsODYN)
	-rm -f $(M_PROJ).*.log debug.log error.log run.log .m.log xml.log
	-rm -f backtracking_$(M_PROJ)_*.log
	-rm -f *.template
	-rm -f *.tmp
	-rm -f \#*
	-rm -f *~
	-rm -f *\%
	-rm -f *.rsp
	rm -f makestp.log symbolics.log sparksym.log matho.err tmp.txt
	if [ -r makefile.inc ] ;  then  rm -f   makefile.inc.bak ; \
		mv makefile.inc makefile.inc.bak ;  fi
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

cleanALL :  clean
	if [ -r $(M_PROJ).prf ] ; then \
	 rm -f  $(M_PROJ).prf.bak ; mv $(M_PROJ).prf $(M_PROJ).prf.bak ;  fi
	-rm -f  default.prf
	if [ -r *.set ] ;  then \
	 for I in *.set ;  do  rm -rf `basename $$I .set` ;  done ; fi
	-rm -f *.trc
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

distclean :  cleanALL
	-rm -f $(M_PROJ).*.bak
	-rm -f makefile  makefile.inc.bak
	-rm -f  $(M_PROJ)_inp.set
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"

help :
	@head -81 $(SPARK_DIR)/lib/makefile.prj
	@echo "SPARK_CLASSPATH=$(SPARK_CLASSPATH)"
	@echo "PROJ=$(PROJ)"
	@echo "SPARK_DEBUG=$(SPARK_DEBUG)"
	@echo "SPARK_STATIC_BUILD=$(SPARK_STATIC_BUILD)"
	@echo "(wildcard classpath.env)=$(wildcard classpath.env)"
	@echo "(wildcard ../classpath.env)=$(wildcard ../classpath.env)"
	@echo "(wildcard $(SPARK_DIR)/classpath.env)=$(SPARK_DIR)/classpath.env)"
	@echo "CXXFLAGS=$(CXXFLAGS)"
	@echo "CXXOPTIONS=$(CXXOPTIONS)"
	@echo "CXXDEFINES=$(CXXDEFINES)"
	@echo "CXXINCLUDES=$(CXXINCLUDES)"
	@echo "LDXXFLAGS=$(LDXXFLAGS)"
	@echo "LDXXOPTIONS=$(LDXXOPTIONS)"
	@echo "LDXXLIBS=$(LDXXLIBS)"
	@echo "SPARK_COMPILE_OPTIONS=$(SPARK_COMPILE_OPTIONS)"
	@echo "SPARK_LINK_DYNAMIC_OPTIONS=$(SPARK_LINK_DYNAMIC_OPTIONS)"
	@echo "SPARK_LINK_STATIC_OPTIONS=$(SPARK_LINK_STATIC_OPTIONS)"
	@echo "----- $@ :  DONE. CURDIR=$(CURDIR) -----"
