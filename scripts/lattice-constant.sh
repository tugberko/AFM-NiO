#!/bin/sh

for i in $(seq 2.5 0.05 3.5)
do
echo "===============================================================The program is running for a = $i================================================================================"
b1=$(echo "$i/2" | bc -l)
b2=$(echo "$b1*sqrt(3)" | bc -l)
c1=$b1
c2=$(echo "$b2/3" | bc -l)
c3=$(echo "$i*sqrt(2)/sqrt(3)" | bc -l)

cat >POSCAR <<EOF
N1 O1
1.0
$i 0 0
$b1 $b2 0
$c1 $c2 $c3
Ni    O
1    1
Direct
0.000000000         0.000000000         0.000000000
0.500000000         0.500000000         0.500000000
EOF

mpirun -np 2 ~/vasp-portable/bins/vasp_std

cp OSZICAR OSZICAR_$i
cp OUTCAR OUTCAR_$i
cp POSCAR POSCAR_$i
done

awk '/F=/ {print FILENAME,$0}' OSZICAR_* | tr -d 'OSZICAR_' > data

gnuplot << EOF
set terminal png
set output "plot.png"
set xlabel "Lattice Constant (A)"
set ylabel "Free Energy (eV)"
set title "Energy vs. Lattice Constant Graph"
plot "data" using 1:4 w l
EOF
cp plot.png ~/Desktop/
