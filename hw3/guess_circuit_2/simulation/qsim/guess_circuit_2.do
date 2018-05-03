onerror {quit -f}
vlib work
vlog -work work guess_the_circuit.vo
vlog -work work guess_circuit_2.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.guess_the_circuit_vlg_vec_tst
vcd file -direction guess_circuit_2.msim.vcd
vcd add -internal guess_the_circuit_vlg_vec_tst/*
vcd add -internal guess_the_circuit_vlg_vec_tst/i1/*
add wave /*
run -all
