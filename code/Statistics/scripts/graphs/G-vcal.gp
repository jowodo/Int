#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "G-vcal.png"
#set term svg
#set out "G-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "v_{cal} [^oC/min]"
set ylabel "leakage {/Symbol g} [a.u.]"
set xrange [11:21]
set yrange [0:140]
set xtics 10,2

set key font ",30"
plot filename u 12:4 pt 7 ps width notitle
#pause -1
