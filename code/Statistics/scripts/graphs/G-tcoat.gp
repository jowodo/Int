#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "G-tcoat.png"
#set term svg
#set out "G-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "T_{coat} [^oC]"
set ylabel "{/Symbol g} [a.u.]"
set xrange [35:85]
set yrange [0:140]
set xtics 40,10,80

set key font ",30"
plot filename u 11:4 pt 7 ps width notitle
#pause -1
