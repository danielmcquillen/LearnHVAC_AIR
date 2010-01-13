P0:=.
P1:=./class
P2:=../class
P3:=C:/vspark210rc7/globalclass
P4:=C:/vspark210rc7/hvactk/class
M_DEPsCC=	\
	$(P0)./class/FileRead.cc	\
	$(P0)./class/FileWrite.cc	\
	$(P0)./class/time.cc	\
	$(P0)./class/runcontrol.cc	\
	$(P0)./class/safprod.cc	\
	$(P0)./class/PIplusminus.cc	\
	$(P0)./class/uSplitter.cc	\
	$(P0)./class/VAVsetpointmanager.cc	\
	$(P0)./class/sum.cc	\
	$(P0)./class/bfd.cc	\
	$(P0)./class/fan.cc	\
	$(P0)./class/coil_mixing.cc	\
	$(P0)./class/heatingcoil_fault.cc	\
	$(P0)./class/cap_rate.cc	\
	$(P0)./class/capratel.cc	\
	$(P0)./class/prod.cc	\
	$(P0)./class/quot.cc	\
	$(P0)./class/cond.cc	\
	$(P0)./class/effc1u.cc	\
	$(P0)./class/equal.cc	\
	$(P0)./class/valve.cc	\
	$(P0)./class/neg.cc	\
	$(P0)./class/coolingcoil_fault.cc	\
	$(P0)./class/effctr.cc	\
	$(P0)./class/safrecip.cc	\
	$(P0)./class/cpair.cc	\
	$(P0)./class/humratio.cc	\
	$(P0)./class/satpress.cc	\
	$(P0)./class/enthalpy.cc	\
	$(P0)./class/diff.cc	\
	$(P0)./class/lintrp.cc	\
	$(P0)./class/effntu1.cc	\
	$(P0)./class/min2.cc	\
	$(P0)./class/cclogic.cc	\
	$(P0)./class/sercond.cc	\
	$(P0)./class/select.cc	\
	$(P0)./class/UASplit.cc	\
	$(P0)./class/abs1.cc	\
	$(P0)./class/mix.cc	\
	$(P0)./class/VAV_damper.cc	\
	$(P0)./class/VAV_damper_position.cc	\
	$(P0)./class/VAV_control.cc	\
	$(P0)./class/room.cc	\
	$(P0)./class/filter.cc	\
	$(P0)./class/boiler_logic.cc	\
	$(P0)./class/boiler_fuel.cc	\
	$(P0)./class/boiler_parasitic.cc	\
	$(P0)./class/bound.cc	\
	$(P0)./class/chillerDOE2.cc	\
	$(P0)./class/coolingTowerNTU.cc	\
	$(P0)./class/air_satpress.cc	\
	$(P0)./class/air_enthalpy.cc	\
	$(P0)./class/air_humratio.cc	\
	$(P0)./class/air_eq31.cc	\
	$(P0)./class/noop.cc
M_DEPsCM=	\
	$(P0)./class/sensor_dryBulb_generic.cm	\
	$(P0)./class/sensor_generic_offset_bfdDynamics.cm	\
	$(P0)./class/safquot.cm	\
	$(P0)./class/sensor_staticPressure_generic.cm	\
	$(P0)./class/heatingcoil.cm	\
	$(P0)./class/drcc1u.cm	\
	$(P0)./class/htxc1u.cm	\
	$(P0)./class/coolingcoil.cm	\
	$(P0)./class/ccsim.cm	\
	$(P0)./class/drcctr.cm	\
	$(P4)/htxctr.cm	\
	$(P0)./class/wtcctr.cm	\
	$(P4)/enthsat.cm	\
	$(P4)/dewpt.cm	\
	$(P4)/enthxctr.cm	\
	$(P3)/propdiff.cm	\
	$(P4)/wcoilout.cm	\
	$(P0)./class/sboiler.cm	\
	$(P0)./class/wetbulb_accl.cm	\
	$(P0)./class/air_enthsat.cm	\
	$(P0)./class/air_wetbulb.cm	\
	$(P0)./class/equal_link.cm
SPARK_CLASSPATH=.,./class,../class,C:/vspark210rc7/globalclass,C:/vspark210rc7/hvactk/class
