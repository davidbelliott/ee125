onerror {quit -f}
vlib work
vlog -work work leading_ones_sequential.vo
vlog -work work leading_ones_sequential.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.leading_ones_sequential_vlg_vec_tst
vcd file -direction leading_ones_sequential.msim.vcd
vcd add -internal leading_ones_sequential_vlg_vec_tst/*
vcd add -internal leading_ones_sequential_vlg_vec_tst/i1/*
add wave /*
run -all
