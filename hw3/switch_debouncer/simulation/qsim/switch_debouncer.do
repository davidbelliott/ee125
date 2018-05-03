onerror {quit -f}
vlib work
vlog -work work switch_debouncer.vo
vlog -work work switch_debouncer.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.debouncer_demo_vlg_vec_tst
vcd file -direction switch_debouncer.msim.vcd
vcd add -internal debouncer_demo_vlg_vec_tst/*
vcd add -internal debouncer_demo_vlg_vec_tst/i1/*
add wave /*
run -all
