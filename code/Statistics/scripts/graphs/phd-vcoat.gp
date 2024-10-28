#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "phd-vcoat.png"
#set term svg
#set out "phd-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "v_{coat} [mm/s]"
set ylabel "{/Symbol r}"
set xrange [9:21]
set yrange [0:1.4]
set xtics 10,2
set ytics 0.2,0.2,1


set key font ",30"
plot filename u 10:5 pt 7 ps width notitle

#pause -1
