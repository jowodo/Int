#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "phd-tcal.png"
#set term svg
#set out "phd-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "T_{cal} [^oC]"
set ylabel "{/Symbol r}"
set xrange [250:550]
set yrange [0:1.4]
set xtics 300,100
set ytics 0.2,0.2,1

set key font ",30"
plot filename u 13:5 pt 7 ps width notitle

#pause -1
