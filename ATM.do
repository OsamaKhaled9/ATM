vlib work
vlog ATM.v ATM_TB.v +cover -covercells
vsim -voptargs=+acc work.ATM_TB -cover
add wave *
coverage save ATM_TB.ucdb -onexit
run -all