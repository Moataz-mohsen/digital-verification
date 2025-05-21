vlib work
vlog *.*v +cover -covercells +define+SIM
vsim -voptargs=+acc work.top_FIFO -cover
coverage save FIFO.ucdb -onexit
run 0
add wave /top_FIFO/f_if/*


run -all
#quit -sim
#vcover report FIFO.ucdb -details -annotate -all