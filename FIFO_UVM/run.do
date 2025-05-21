vlib work
vlog -f src_files.list
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all
run 0
add wave *
add wave /top/f_if/*
run -all
coverage save top.ucdb -onexit -du work.top
#quit -sim
#vcover report top.ucdb -details -annotate -all -output cov_report.txt