onerror {quit -f}
vlib work
vlog -work work natural_to_thermometer.vo
vlog -work work natural_to_thermometer.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.natural_to_thermometer_test_vlg_vec_tst
vcd file -direction natural_to_thermometer.msim.vcd
vcd add -internal natural_to_thermometer_test_vlg_vec_tst/*
vcd add -internal natural_to_thermometer_test_vlg_vec_tst/i1/*
add wave /*
run -all
