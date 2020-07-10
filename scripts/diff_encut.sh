#!/bin/bash
cp data data1 | tr -s ' '
cp data1 data
rm data1
python diff_encut.py 

gnuplot << EOF
set terminal png
set output "plot_diffencut.png"
set xlabel "ENCUT"
set ylabel "Energy Difference"
set title "Energy Difference vs. ENCUT Parameter Graph in log-Scale"
plot "diffdata" using 1:2 w l
EOF
cp plot_diffencut.png ~/Desktop/
rm plot_diffencut.png
