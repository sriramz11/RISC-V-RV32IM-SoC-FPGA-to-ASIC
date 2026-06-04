# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ADD_BEQ" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AND" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MUL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SLL_BLT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SLTU_BLTU" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SLT_BGE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRA" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SRL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SUB_BNE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "XOR_BGEU" -parent ${Page_0}


}

proc update_PARAM_VALUE.ADD_BEQ { PARAM_VALUE.ADD_BEQ } {
	# Procedure called to update ADD_BEQ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADD_BEQ { PARAM_VALUE.ADD_BEQ } {
	# Procedure called to validate ADD_BEQ
	return true
}

proc update_PARAM_VALUE.AND { PARAM_VALUE.AND } {
	# Procedure called to update AND when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AND { PARAM_VALUE.AND } {
	# Procedure called to validate AND
	return true
}

proc update_PARAM_VALUE.MUL { PARAM_VALUE.MUL } {
	# Procedure called to update MUL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MUL { PARAM_VALUE.MUL } {
	# Procedure called to validate MUL
	return true
}

proc update_PARAM_VALUE.OR { PARAM_VALUE.OR } {
	# Procedure called to update OR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OR { PARAM_VALUE.OR } {
	# Procedure called to validate OR
	return true
}

proc update_PARAM_VALUE.SLL_BLT { PARAM_VALUE.SLL_BLT } {
	# Procedure called to update SLL_BLT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SLL_BLT { PARAM_VALUE.SLL_BLT } {
	# Procedure called to validate SLL_BLT
	return true
}

proc update_PARAM_VALUE.SLTU_BLTU { PARAM_VALUE.SLTU_BLTU } {
	# Procedure called to update SLTU_BLTU when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SLTU_BLTU { PARAM_VALUE.SLTU_BLTU } {
	# Procedure called to validate SLTU_BLTU
	return true
}

proc update_PARAM_VALUE.SLT_BGE { PARAM_VALUE.SLT_BGE } {
	# Procedure called to update SLT_BGE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SLT_BGE { PARAM_VALUE.SLT_BGE } {
	# Procedure called to validate SLT_BGE
	return true
}

proc update_PARAM_VALUE.SRA { PARAM_VALUE.SRA } {
	# Procedure called to update SRA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRA { PARAM_VALUE.SRA } {
	# Procedure called to validate SRA
	return true
}

proc update_PARAM_VALUE.SRL { PARAM_VALUE.SRL } {
	# Procedure called to update SRL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SRL { PARAM_VALUE.SRL } {
	# Procedure called to validate SRL
	return true
}

proc update_PARAM_VALUE.SUB_BNE { PARAM_VALUE.SUB_BNE } {
	# Procedure called to update SUB_BNE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SUB_BNE { PARAM_VALUE.SUB_BNE } {
	# Procedure called to validate SUB_BNE
	return true
}

proc update_PARAM_VALUE.XOR_BGEU { PARAM_VALUE.XOR_BGEU } {
	# Procedure called to update XOR_BGEU when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.XOR_BGEU { PARAM_VALUE.XOR_BGEU } {
	# Procedure called to validate XOR_BGEU
	return true
}


proc update_MODELPARAM_VALUE.ADD_BEQ { MODELPARAM_VALUE.ADD_BEQ PARAM_VALUE.ADD_BEQ } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADD_BEQ}] ${MODELPARAM_VALUE.ADD_BEQ}
}

proc update_MODELPARAM_VALUE.SUB_BNE { MODELPARAM_VALUE.SUB_BNE PARAM_VALUE.SUB_BNE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SUB_BNE}] ${MODELPARAM_VALUE.SUB_BNE}
}

proc update_MODELPARAM_VALUE.SLL_BLT { MODELPARAM_VALUE.SLL_BLT PARAM_VALUE.SLL_BLT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SLL_BLT}] ${MODELPARAM_VALUE.SLL_BLT}
}

proc update_MODELPARAM_VALUE.SLT_BGE { MODELPARAM_VALUE.SLT_BGE PARAM_VALUE.SLT_BGE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SLT_BGE}] ${MODELPARAM_VALUE.SLT_BGE}
}

proc update_MODELPARAM_VALUE.SLTU_BLTU { MODELPARAM_VALUE.SLTU_BLTU PARAM_VALUE.SLTU_BLTU } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SLTU_BLTU}] ${MODELPARAM_VALUE.SLTU_BLTU}
}

proc update_MODELPARAM_VALUE.XOR_BGEU { MODELPARAM_VALUE.XOR_BGEU PARAM_VALUE.XOR_BGEU } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.XOR_BGEU}] ${MODELPARAM_VALUE.XOR_BGEU}
}

proc update_MODELPARAM_VALUE.SRL { MODELPARAM_VALUE.SRL PARAM_VALUE.SRL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRL}] ${MODELPARAM_VALUE.SRL}
}

proc update_MODELPARAM_VALUE.SRA { MODELPARAM_VALUE.SRA PARAM_VALUE.SRA } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SRA}] ${MODELPARAM_VALUE.SRA}
}

proc update_MODELPARAM_VALUE.OR { MODELPARAM_VALUE.OR PARAM_VALUE.OR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OR}] ${MODELPARAM_VALUE.OR}
}

proc update_MODELPARAM_VALUE.AND { MODELPARAM_VALUE.AND PARAM_VALUE.AND } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AND}] ${MODELPARAM_VALUE.AND}
}

proc update_MODELPARAM_VALUE.MUL { MODELPARAM_VALUE.MUL PARAM_VALUE.MUL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MUL}] ${MODELPARAM_VALUE.MUL}
}

