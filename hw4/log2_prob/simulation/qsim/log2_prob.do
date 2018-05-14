onerror {quit -f}
vlib work
vlog -work work log2_prob.vo
vlog -work work log2_prob.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.log2_prob_vlg_vec_tst
vcd file -direction log2_prob.msim.vcd
vcd add -internal log2_prob_vlg_vec_tst/*
vcd add -internal log2_prob_vlg_vec_tst/i1/*
add wave /*
run -all
