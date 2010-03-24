SET epin=LgOff_main
SET epout=LgOff\Output\LgOff
SET epinext=imf
SET epwthr=Weather\USA_CA_San.Francisco_TMY2.epw
SET eptype=EP
SET pausing=N
SET maxcol=nolimit
SET convESO=N
SET procCSV=N
:  EnergyPlus Batch File for EP-Launch Program 
:  Created on: 8 Mar 2000 by J. Glazer
:  Based on:   RunE+.bat 17 AUG 99 by M.J. Witte
:  Revised:    17 Jul 2000, Linda Lawrie (beta 3 release)
:              27 Sep 2000, Witte/Glazer - add saves for EP-Macro results
:              17 Oct 2000, Lawrie - remove wthrfl option (BLAST weather)
:              09 Feb 2001, Lawrie - Add siz and mtr options, use 3dl and sln files
:              08 Aug 2001, Lawrie - add option for epinext environment variable
:              09 Oct 2001, Lawrie - put in explanation of epinext environment variable
:                                  - also add eplusout.cif for Comis Input Report
:              05 Dec 2001, Lawrie - add new eplusout.bnd (Branch/Node Details)
:              17 Dec 2001, Glazer - explain eptype for no weather case
:              19 Dec 2001, Lawrie - add eplusout.dbg, eplusout.trn, eplusmtr.csv
:                                  - also create eplusmtr.csv 
:              20 Sep 2002, Witte  - Delete all "pausing" stops except the one right
:                                    after EnergyPlus.exe
:              18 Feb 2003, Lawrie - change name of audit.out to eplusout.audit and save it
:              29 Jul 2003, Glazer - add tabular report file handling
:              21 Aug 2003, Lawrie - add "map" file handling
:              21 Aug 2003, Lawrie - change to "styled" output for sizing, map and tabular files
:              29 Aug 2003, Glazer - delete old .zsz and .ssz files if present
:               8 Sep 2003, Glazer - add ReadVars txt and tab outputs
:                                    unlimited columns option
:              09 Feb 2004, Lawrie - add DElight files
:              30 Mar 2004, Glazer - get rid of TRN file
:              30 Jul 2004, Glazer - added use of epout variable as part of groups in ep-launch
:              22 Feb 2005, Glazer - added ExpandObjects preprocessor
:              06 Jun 2006, Lawrie - remove cfp file, add shd file
:              21 Aug 2006, Lawrie - add wrl file
:              22 Aug 2006, Glazer - add convertESOMTR
:              27 Nov 2006, Lawrie - add mdd file
:              20 Feb 2007, Glazer - add csvProc
:              03 Mar 2008, Glazer - add weather stat file copying
:
:  This batch file can execute EnergyPlus using either command line parameters
:  or environmental variables. The most common method is to use environmental
:  variables but for some systems that do not allow the creation of batch files
:  the parameter passing method should be used.   When not passing parameters the
:  environmental variables are set as part of RUNEP.BAT file and are shown below
:
:  When passing parameters instead the first parameter (%1) should be PARAM and the other
:  parameters are shown in the list.
:
:        %epin% or %1 contains the file with full path and no extensions for input files
:
:        %epout% or %2 contains the file with full path and no extensions for output files
:
:        %epinext% or %3 contains the extension of the file selected from the EP-Launch
:          program.  Could be imf or idf -- having this parameter ensures that the
:          correct user selected file will be used in the run.
:
:        %epwthr% or %4 contains the file with full path and extension for the weather file
:         
:        %eptype% or %5 contains either "EP" or "NONE" to indicate if a weather file is used
:
:        %pausing% or %6 contains Y if pause should occur between major portions of
:          batch file
:
:        %maxcol% or %7 contains "250" if limited to 250 columns otherwise contains
:                 "nolimit" if unlimited (used when calling readVarsESO)
:
:        %convESO% or %8 contains Y if convertESOMTR program should be called
:
:        %procCSV% or %9 contains Y if csvProc program should be called
:
:        
:  This batch file is designed to be used only in the EnergyPlus directory that
:  contains the EnergyPlus.exe, Energy+.idd and Energy+.ini files.
:
:  EnergyPlus requires the following files as input:
:
:       Energy+.ini   - ini file with path to idd file (blank = current dir)
:       Energy+.idd   - input data dictionary
:       In.idf        - input data file (must be compatible with the idd version)
:
:       In.epw        - EnergyPlus format weather file
:
:  EnergyPlus will create the following files:
: 
:       Eplusout.audit-  Echo of input (Usually without echoing IDD)
:       Eplusout.end  -  A one line synopsis after the run (success/fail)
:       Eplusout.err  -  Error file
:       Eplusout.eso  -  Standard output file
:       Eplusout.eio  -  One time output file
:       Eplusout.rdd  -  Report variable data dictionary
:       Eplusout.dxf  -  DXF (from report, Surfaces, DXF;)
:       Eplusout.mtr  -  Meter output (similar to ESO format)
:       Eplusout.mtd  -  Meter Details (see what variable is on what meter)
:       Eplusout.bnd  -  Branch/Node Details Report File
:       Eplusout.dbg  -  A debugging file -- see Debug Output object for description
:       Others -- see "Clean up Working Directory for current list"
:
:  The Post Processing Program (PPP) requires the following files as input:
:
:       Eplusout.inp  -  PPP command file (specifies input and output files)
:         This file name is user specified as standard input on the command line  
:         but we will standardize on Eplusout.inp (optional)
:
:       Eplusout.eso  -  Input data (the standard output file from EnergyPlus)
:         This file name is user specified in Eplusout.inp but we will 
:         standardize on Eplusout.eso (can also accept the eplusout.mtr file)
:                        
:
:  The Post Processing Program produces the following output files:
:
:       Eplusout.csv  -  PPP output file in CSV format
:         This file name is user specified in Eplusout.inp but we will 
:         standardize on Eplusout.csv
:
:  This batch file will perform the following steps:
:
:   1.  Clean up directory by deleting old working files from prior run
:   2.  Copy %1.idf (input) into In.idf (or %1.imf to in.imf)
:   3.  Copy %2 (weather) into In.epw
:   4.  Execute EnergyPlus
:   5.  If available Copy %1.rvi (post processor commands) into Eplusout.inp
:       If available Copy %1.mvi (post processor commands) into eplusmtr.inp
:       or create appropriate input to get meter output from eplusout.mtr
:   6.  Execute ReadVarsESO.exe (the Post Processing Program)
:       Execute ReadVarsESO.exe (the Post Processing Program) for meter output
:   7.  Copy Eplusout.* to %1.*
:   8.  Clean up directory.
:
: Set the variables if a command line is used
IF "%9"=="" GOTO skipSetParams
SET epin=%~1
SET epout=%~2
SET epinext=%3
SET epwthr=%~4
SET eptype=%5
SET pausing=%6
SET maxcol=%7
SET convESO=%8
SET procCSV=%9
:skipSetParams
:
:  1. Clean up working directory
IF EXIST eplusout.inp   DEL eplusout.inp
IF EXIST eplusout.end   DEL eplusout.end
IF EXIST eplusout.eso   DEL eplusout.eso
IF EXIST eplusout.rdd   DEL eplusout.rdd
IF EXIST eplusout.mdd   DEL eplusout.mdd
IF EXIST eplusout.dbg   DEL eplusout.dbg
IF EXIST eplusout.eio   DEL eplusout.eio
IF EXIST eplusout.err   DEL eplusout.err
IF EXIST eplusout.dxf   DEL eplusout.dxf
IF EXIST eplusout.csv   DEL eplusout.csv
IF EXIST eplusout.tab   DEL eplusout.tab
IF EXIST eplusout.txt   DEL eplusout.txt
IF EXIST eplusmtr.csv   DEL eplusmtr.csv
IF EXIST eplusmtr.tab   DEL eplusmtr.tab
IF EXIST eplusmtr.txt   DEL eplusmtr.txt
IF EXIST eplusout.sln   DEL eplusout.sln
IF EXIST epluszsz.csv   DEL epluszsz.csv
IF EXIST epluszsz.tab   DEL epluszsz.tab
IF EXIST epluszsz.txt   DEL epluszsz.txt
IF EXIST eplusssz.csv   DEL eplusssz.csv
IF EXIST eplusssz.tab   DEL eplusssz.tab
IF EXIST eplusssz.txt   DEL eplusssz.txt
IF EXIST eplusout.mtr   DEL eplusout.mtr
IF EXIST eplusout.mtd   DEL eplusout.mtd
IF EXIST eplusout.bnd   DEL eplusout.bnd
IF EXIST eplusout.dbg   DEL eplusout.dbg
IF EXIST eplusout.trn   DEL eplusout.trn
IF EXIST eplusout.sci   DEL eplusout.sci
IF EXIST eplusmap.csv   DEL eplusmap.csv
IF EXIST eplusmap.txt   DEL eplusmap.txt
IF EXIST eplusmap.tab   DEL eplusmap.tab
IF EXIST eplustbl.csv   DEL eplustbl.csv
IF EXIST eplustbl.txt   DEL eplustbl.txt
IF EXIST eplustbl.tab   DEL eplustbl.tab
IF EXIST eplustbl.htm   DEL eplustbl.htm
IF EXIST eplusout.log   DEL eplusout.log
IF EXIST eplusout.svg   DEL eplusout.svg
IF EXIST eplusout.shd   DEL eplusout.shd
IF EXIST eplusout.wrl   DEL eplusout.wrl
IF EXIST eplusout.delightin   DEL eplusout.delightin
IF EXIST eplusout.delightout  DEL eplusout.delightout
IF EXIST eplusout.delighteldmp  DEL eplusout.delighteldmp
IF EXIST eplusout.delightdfdmp  DEL eplusout.delightdfdmp
IF EXIST eplusout.sparklog  DEL eplusout.sparklog
IF EXIST eplusscreen.csv  DEL eplusscreen.csv
IF EXIST in.imf         DEL in.imf
IF EXIST in.idf         DEL in.idf
IF EXIST in.stat        DEL in.stat
IF EXIST out.idf        DEL out.idf
IF EXIST eplusout.inp   DEL eplusout.inp
REM DMcQ commenting this line out since we've just written in.EPW from LearnHVAC
REM IF EXIST in.epw         DEL in.epw
IF EXIST eplusout.audit DEL eplusout.audit
IF EXIST eplusmtr.inp   DEL eplusmtr.inp
IF EXIST test.mvi       DEL test.mvi
IF EXIST expanded.idf   DEL expanded.idf
IF EXIST expandedidf.err   DEL expandedidf.err
IF EXIST readvars.audit   DEL readvars.audit
:if %pausing%==Y pause

:  2. Copy input data file to working directory
IF EXIST "%epout%.epmidf" DEL "%epout%.epmidf"
IF EXIST "%epout%.epmdet" DEL "%epout%.epmdet"

: DMcQ Learn HVAC will always save in.imf to Input directory, so copy from there
IF EXIST Input/in.imf copy Input/in.imf in.imf

if "%epinext%" == "" set epinext=idf
if exist "%epin%.%epinext%" copy "%epin%.%epinext%" in.%epinext%
if exist in.imf EPMacro
if exist out.idf copy out.idf "%epout%.epmidf"
if exist audit.out copy audit.out "%epout%.epmdet"
if exist audit.out erase audit.out
if exist out.idf MOVE out.idf in.idf
if exist in.idf ExpandObjects
if exist expanded.idf COPY expanded.idf "%epout%.expidf"
if exist expanded.idf MOVE expanded.idf in.idf
if not exist in.idf copy "%epin%.idf" In.idf
:if %pausing%==Y pause

REM DMcQ commenting this out as we handle .epw copying in Learn HVAC
REM :  3. Test for weather file type and copy to working directory
REM if %eptype%==EP    copy "%epwthr%" In.epw
REM : Convert from an extension of .epw to .stat
REM if %eptype%==EP    SET wthrstat=%epwthr:~0,-4%.stat
REM if %eptype%==EP    copy "%wthrstat%" in.stat
REM :if %pausing%==Y pause

:  4. Execute EnergyPlus
EnergyPlus
if %pausing%==Y pause

:  5. Copy Post Processing Program command file(s) to working directory
IF EXIST "%epin%.rvi" copy "%epin%.rvi" Eplusout.inp
IF EXIST "%epin%.mvi" copy "%epin%.mvi" Eplusmtr.inp
:if %pausing%==Y pause

:  6. Run Post Processing Program(s)
if %maxcol%==250     SET rvset=
if %maxcol%==nolimit SET rvset=unlimited
: readvars creates audit in append mode.  start it off
echo %date% %time% ReadVars >readvars.audit

IF NOT EXIST postprocess\convertESOMTRpgm\convertESOMTR.exe GOTO skipConv
COPY postprocess\convertESOMTRpgm\convert.txt convert.txt
IF %convESO%==Y postprocess\convertESOMTRpgm\convertESOMTR
IF EXIST ip.eso DEL eplusout.eso
IF EXIST ip.eso MOVE ip.eso eplusout.eso
IF EXIST ip.mtr DEL eplusout.mtr
IF EXIST ip.mtr MOVE ip.mtr eplusout.mtr
IF EXIST convert.txt DEL convert.txt
:skipConv

IF EXIST eplusout.inp postprocess\ReadVarsESO.exe eplusout.inp %rvset%
IF NOT EXIST eplusout.inp postprocess\ReadVarsESO.exe " " %rvset%
IF EXIST eplusmtr.inp postprocess\ReadVarsESO.exe eplusmtr.inp %rvset%
IF NOT EXIST eplusmtr.inp echo eplusout.mtr >test.mvi
IF NOT EXIST eplusmtr.inp echo eplusmtr.csv >>test.mvi
IF NOT EXIST eplusmtr.inp postprocess\ReadVarsESO.exe test.mvi %rvset%


if %pausing%==Y pause

:  7. Copy output files to input/output path
IF EXIST "%epout%.eso" DEL "%epout%.eso"
IF EXIST "%epout%.rdd" DEL "%epout%.rdd"
IF EXIST "%epout%.mdd" DEL "%epout%.mdd"
IF EXIST "%epout%.eio" DEL "%epout%.eio"
IF EXIST "%epout%.err" DEL "%epout%.err"
IF EXIST "%epout%.dxf" DEL "%epout%.dxf"
IF EXIST "%epout%.csv" DEL "%epout%.csv"
IF EXIST "%epout%.tab" DEL "%epout%.tab"
IF EXIST "%epout%.txt" DEL "%epout%.txt"
IF EXIST "%epout%Meter.csv" DEL "%epout%Meter.csv"
IF EXIST "%epout%Meter.tab" DEL "%epout%Meter.tab"
IF EXIST "%epout%Meter.txt" DEL "%epout%Meter.txt"
IF EXIST "%epout%.det" DEL "%epout%.det"
IF EXIST "%epout%.sln" DEL "%epout%.sln"
IF EXIST "%epout%.Zsz" DEL "%epout%.Zsz"
IF EXIST "%epout%Zsz.csv" DEL "%epout%Zsz.csv"
IF EXIST "%epout%Zsz.tab" DEL "%epout%Zsz.tab"
IF EXIST "%epout%Zsz.txt" DEL "%epout%Zsz.txt"
IF EXIST "%epout%.ssz" DEL "%epout%.ssz"
IF EXIST "%epout%Ssz.csv" DEL "%epout%Ssz.csv"
IF EXIST "%epout%Ssz.tab" DEL "%epout%Ssz.tab"
IF EXIST "%epout%Ssz.txt" DEL "%epout%Ssz.txt"
IF EXIST "%epout%.mtr" DEL "%epout%.mtr"
IF EXIST "%epout%.mtd" DEL "%epout%.mtd"
IF EXIST "%epout%.bnd" DEL "%epout%.bnd"
IF EXIST "%epout%.dbg" DEL "%epout%.dbg"
IF EXIST "%epout%.sci" DEL "%epout%.sci"
IF EXIST "%epout%Map.csv" DEL "%epout%Map.csv"
IF EXIST "%epout%Map.tab" DEL "%epout%Map.tab"
IF EXIST "%epout%Map.txt" DEL "%epout%Map.txt"
IF EXIST "%epout%.audit" DEL "%epout%.audit"
IF EXIST "%epout%Table.csv" DEL "%epout%Table.csv"
IF EXIST "%epout%Table.tab" DEL "%epout%Table.tab"
IF EXIST "%epout%Table.txt" DEL "%epout%Table.txt"
IF EXIST "%epout%Table.html" DEL "%epout%Table.html"
IF EXIST "%epout%DElight.in" DEL "%epout%DElight.in"
IF EXIST "%epout%DElight.out" DEL "%epout%DElight.out"
IF EXIST "%epout%DElight.dfdmp" DEL "%epout%DElight.dfdmp"
IF EXIST "%epout%DElight.eldmp" DEL "%epout%DElight.eldmp"
IF EXIST "%epout%.svg" DEL "%epout%.svg"
IF EXIST "%epout%.shd" DEL "%epout%.shd"
IF EXIST "%epout%.wrl" DEL "%epout%.wrl"
IF EXIST "%epout%Screen.csv" DEL "%epout%Screen.csv"
IF EXIST "%epout%.rvaudit" DEL "%epout%.rvaudit"
IF EXIST "%epout%-PROC.csv" DEL "%epout%-PROC.csv"

IF EXIST eplusout.eso MOVE eplusout.eso "%epout%.eso"
IF EXIST eplusout.rdd MOVE eplusout.rdd "%epout%.rdd"
IF EXIST eplusout.mdd MOVE eplusout.mdd "%epout%.mdd"
IF EXIST eplusout.eio MOVE eplusout.eio "%epout%.eio"
IF EXIST eplusout.err MOVE eplusout.err "%epout%.err"
IF EXIST eplusout.dxf MOVE eplusout.dxf "%epout%.dxf"
IF EXIST eplusout.csv MOVE eplusout.csv "%epout%.csv"
IF EXIST eplusout.tab MOVE eplusout.tab "%epout%.tab"
IF EXIST eplusout.txt MOVE eplusout.txt "%epout%.txt"
IF EXIST eplusmtr.csv MOVE eplusmtr.csv "%epout%Meter.csv"
IF EXIST eplusmtr.tab MOVE eplusmtr.tab "%epout%Meter.tab"
IF EXIST eplusmtr.txt MOVE eplusmtr.txt "%epout%Meter.txt"
IF EXIST eplusout.sln MOVE eplusout.sln "%epout%.sln"
IF EXIST epluszsz.csv MOVE epluszsz.csv "%epout%Zsz.csv"
IF EXIST epluszsz.tab MOVE epluszsz.tab "%epout%Zsz.tab"
IF EXIST epluszsz.txt MOVE epluszsz.txt "%epout%Zsz.txt"
IF EXIST eplusssz.csv MOVE eplusssz.csv "%epout%Ssz.csv"
IF EXIST eplusssz.tab MOVE eplusssz.tab "%epout%Ssz.tab"
IF EXIST eplusssz.txt MOVE eplusssz.txt "%epout%Ssz.txt"
IF EXIST eplusout.mtr MOVE eplusout.mtr "%epout%.mtr"
IF EXIST eplusout.mtd MOVE eplusout.mtd "%epout%.mtd"
IF EXIST eplusout.bnd MOVE eplusout.bnd "%epout%.bnd"
IF EXIST eplusout.dbg MOVE eplusout.dbg "%epout%.dbg"
IF EXIST eplusout.sci MOVE eplusout.sci "%epout%.sci"
IF EXIST eplusmap.csv MOVE eplusmap.csv "%epout%Map.csv"
IF EXIST eplusmap.tab MOVE eplusmap.tab "%epout%Map.tab"
IF EXIST eplusmap.txt MOVE eplusmap.txt "%epout%Map.txt"
IF EXIST eplusout.audit MOVE eplusout.audit "%epout%.audit"
IF EXIST eplustbl.csv MOVE eplustbl.csv "%epout%Table.csv"
IF EXIST eplustbl.tab MOVE eplustbl.tab "%epout%Table.tab"
IF EXIST eplustbl.txt MOVE eplustbl.txt "%epout%Table.txt"
IF EXIST eplustbl.htm MOVE eplustbl.htm "%epout%Table.html"
IF EXIST eplusout.delightin MOVE eplusout.delightin "%epout%DElight.in"
IF EXIST eplusout.delightout MOVE eplusout.delightout "%epout%DElight.out"
IF EXIST eplusout.delightdfdmp MOVE eplusout.delightdfdmp "%epout%DElight.dfdmp"
IF EXIST eplusout.delighteldmp MOVE eplusout.delighteldmp "%epout%DElight.eldmp"
IF EXIST eplusout.svg MOVE eplusout.svg "%epout%.svg"
IF EXIST eplusout.shd MOVE eplusout.shd "%epout%.shd"
IF EXIST eplusout.wrl MOVE eplusout.wrl "%epout%.wrl"
IF EXIST eplusscreen.csv MOVE eplusscreen.csv "%epout%Screen.csv"
IF EXIST eplusout.sparklog MOVE eplusout.sparklog "%epout%Spark.log"
IF EXIST readvars.audit MOVE readvars.audit "%epout%.rvaudit"

IF NOT EXIST postprocess\CSVproc.exe GOTO skipProc
IF %procCSV%==Y postprocess\CSVproc.exe %epout%.csv
:skipProc

:if %pausing%==Y pause

:  8.  Clean up directory.
IF EXIST eplusout.inp DEL eplusout.inp
IF EXIST eplusmtr.inp DEL eplusmtr.inp
IF EXIST in.idf       DEL in.idf
IF EXIST in.imf       DEL in.imf
IF EXIST in.epw       DEL in.epw
IF EXIST in.stat      DEL in.stat
IF EXIST eplusout.dbg DEL eplusout.dbg
IF EXIST test.mvi DEL test.mvi
IF EXIST expandedidf.err DEL expandedidf.err
IF EXIST readvars.audit DEL readvars.audit
:if %pausing%==Y pause
:  Finished
