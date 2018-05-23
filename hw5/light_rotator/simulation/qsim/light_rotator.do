onerror {quit -f}
vlib work
vlog -work work light_rotator.vo
vlog -work work light_rotator.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.light_rotator_vlg_vec_tst
vcd file -direction light_rotator.msim.vcd
vcd add -internal light_rotator_vlg_vec_tst/*
vcd add -internal light_rotator_vlg_vec_tst/i1/*
add wave /*
run -all
