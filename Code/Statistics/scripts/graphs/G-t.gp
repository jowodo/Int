#!/usr/bin/gnuplot 

set term pngcairo
set out "G-t.png"
#set term svg
#set out "G-t.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
width=2
set xlabel "sample number"
set ylabel "conductivity G a.u." 
#set xrange [0:550]
#set yrange [0:550]
#set xtics 0,60

plot filename u 1:3 w l lw width notitle

#pause -1
