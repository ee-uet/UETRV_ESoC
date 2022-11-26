# open project
open_project ../RVProc_Final/RVProc_Final.xpr
update_compile_order -fileset sources_1

# suppress warning about debug core
set_msg_config -id "Labtools 27-1434 Labtools 27-3361" -suppress

# connect to FPGA and program it
open_hw
connect_hw_server
open_hw_target
set_property PROGRAM.FILE {../RVProc_Final/RVProc_Final.runs/impl_1/wrapperProc.bit} [get_hw_devices xc7a100t_0]
current_hw_device [get_hw_devices xc7a100t_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xc7a100t_0] 0]
set_property PROBES.FILE {} [get_hw_devices xc7a100t_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xc7a100t_0]
program_hw_devices [get_hw_devices xc7a100t_0]
refresh_hw_device [lindex [get_hw_devices xc7a100t_0] 0]
exit
