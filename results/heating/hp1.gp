#!/bin/envs gnuplot 

svgout="hp1.svg"
pngout="hp1.png"

infile="hp1.csv"
width=2
set xlabel "Time [min]"
set ylabel "Temperature [°C]"
set xrange [0:550]
set yrange [0:550]
set xtics 0,60

set term svg
set out "hp1.svg"

plot infile u 3:1 w l lw width t "HP1" ,\
	infile u 4:1 w l lw width t "NT1"	,\
	infile u 5:1 w l lw width t "NT2" ,\
	infile u 6:1 w l lw width t "NT3" ,\
	infile u 7:1 w l lw width t "NT4" ,\
	infile u 8:1 w l lw width t "NT5" ,\
	infile u 9:1 w l lw width t "NT6"

set term pngcairo
set out "hp1.png"

plot infile u 3:1 w l lw width t "HP1" ,\
	infile u 4:1 w l lw width t "NT1"	,\
	infile u 5:1 w l lw width t "NT2" ,\
	infile u 6:1 w l lw width t "NT3" ,\
	infile u 7:1 w l lw width t "NT4" ,\
	infile u 8:1 w l lw width t "NT5" ,\
	infile u 9:1 w l lw width t "NT6"
#pause -1
