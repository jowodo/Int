#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "G-t.png"
#set term svg
#set out "G-t.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "sample number"
set ylabel "leakage {/Symbol g} [a.u.]"
#set xrange [0:550]
#set yrange [0:550]
#set xtics 0,60

#plot filename u 1:3 w l lw width notitle
plot filename u ($0+1):4 w l lw width notitle

#pause -1
