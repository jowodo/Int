#!/bin/bash 

if [ "x" ==  "x$1" ] ; 
then 
	echo "USAGE: ./plot-single-iv.sh I-V_146_2021_02_03" ; exit 1  
fi 
pushd $1
mkdir -p tmp 
pushd tmp 
for i in $(ls ../*L*C*) ; do 
	echo "
	set term pngcairo size 1200, 900 font \",30\"
	set xlabel \"voltage [V]\"
	set ylabel \"current [A]\"
	set out \"$i.png\"
	set xrange [-0.5:0.5]
	plot \"$i\" w l notitle" > plot.gp ; 
	gnuplot plot.gp ; 
	mv $i.png . 
done
rm plot.gp ; 
