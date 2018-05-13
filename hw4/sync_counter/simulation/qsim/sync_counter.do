onerror {quit -f}
vlib work
vlog -work work sync_counter.vo
vlog -work work sync_counter.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.sync_counter_vlg_vec_tst
vcd file -direction sync_counter.msim.vcd
vcd add -internal sync_counter_vlg_vec_tst/*
vcd add -internal sync_counter_vlg_vec_tst/i1/*
add wave /*
run -all
