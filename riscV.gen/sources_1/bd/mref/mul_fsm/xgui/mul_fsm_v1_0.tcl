# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "IDLE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "mul_stage_1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "mul_stage_2" -parent ${Page_0}


}

proc update_PARAM_VALUE.IDLE { PARAM_VALUE.IDLE } {
	# Procedure called to update IDLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IDLE { PARAM_VALUE.IDLE } {
	# Procedure called to validate IDLE
	return true
}

proc update_PARAM_VALUE.mul_stage_1 { PARAM_VALUE.mul_stage_1 } {
	# Procedure called to update mul_stage_1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.mul_stage_1 { PARAM_VALUE.mul_stage_1 } {
	# Procedure called to validate mul_stage_1
	return true
}

proc update_PARAM_VALUE.mul_stage_2 { PARAM_VALUE.mul_stage_2 } {
	# Procedure called to update mul_stage_2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.mul_stage_2 { PARAM_VALUE.mul_stage_2 } {
	# Procedure called to validate mul_stage_2
	return true
}


proc update_MODELPARAM_VALUE.IDLE { MODELPARAM_VALUE.IDLE PARAM_VALUE.IDLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IDLE}] ${MODELPARAM_VALUE.IDLE}
}

proc update_MODELPARAM_VALUE.mul_stage_1 { MODELPARAM_VALUE.mul_stage_1 PARAM_VALUE.mul_stage_1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.mul_stage_1}] ${MODELPARAM_VALUE.mul_stage_1}
}

proc update_MODELPARAM_VALUE.mul_stage_2 { MODELPARAM_VALUE.mul_stage_2 PARAM_VALUE.mul_stage_2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.mul_stage_2}] ${MODELPARAM_VALUE.mul_stage_2}
}

