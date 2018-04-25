onerror {quit -f}
vlib work
vlog -work work absolute_difference.vo
vlog -work work absolute_difference.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.absolute_difference_vlg_vec_tst
vcd file -direction absolute_difference.msim.vcd
vcd add -internal absolute_difference_vlg_vec_tst/*
vcd add -internal absolute_difference_vlg_vec_tst/i1/*
add wave /*
run -all
