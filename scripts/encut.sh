#!/bin/sh

for i in $(seq 400 50 1500)
do
echo "===============================================================The program is running for ENCUT = $i================================================================================"

cat >INCAR <<EOF
System = NiO
ISTART = 0
ENCUT = $i
ISMEAR = 0
SIGMA = 0.001
EDIFF = 1E-8
EOF

mpirun -np 2 ~/vasp-portable/bins/vasp_std

cp OSZICAR OSZICAR_$i
cp INCAR INCAR_$i
done

awk '/F=/ {print FILENAME,$0}' OSZICAR_* | tr -d 'OSZICAR_' > data_tmp
sort -k 1n data_tmp >data
rm data_tmp

gnuplot << EOF
set terminal png
set output "plot_encut.png"
set xlabel "ENCUT"
set ylabel "Free Energy (eV)"
set title "Energy vs. ENCUT Parameter Graph"
plot "data" using 1:4 w l
EOF
cp plot_encut.png ~/Desktop/
rm plot_encut.png
