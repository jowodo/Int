#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "phd-tcoat.png"
#set term svg
#set out "phd-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "T_{coat} [^oC]"
set ylabel "{/Symbol r}"
set xrange [35:85]
set yrange [0:1.4]
set xtics 40,10
set ytics 0.2,0.2,1

set key font ",30"
plot filename u 11:5 pt 7 ps width notitle

#pause -1
