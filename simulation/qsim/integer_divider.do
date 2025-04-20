onerror {quit -f}
vlib work
vlog -work work integer_divider.vo
vlog -work work integer_divider.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.is_zero_vlg_vec_tst
vcd file -direction integer_divider.msim.vcd
vcd add -internal is_zero_vlg_vec_tst/*
vcd add -internal is_zero_vlg_vec_tst/i1/*
add wave /*
run -all
