#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "G-tcal.png"
#set term svg
#set out "G-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "T_{cal} [^oC]"
set ylabel "leakage {/Symbol g} [a.u.]"
set xrange [250:550]
set yrange [0:140]
set xtics 300,100

set key font ",30"
plot filename u 13:4 pt 7 ps width notitle
#pause -1
