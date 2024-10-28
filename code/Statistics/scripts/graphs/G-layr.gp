#!/usr/bin/gnuplot

set term pngcairo size 1200, 900 font ",30"
set out "G-layr.png"
#set term svg
#set out "G-layr.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "layers {/Symbol l}"
set ylabel "MAE (pG) {/Symbol g} [a.u.]"
set xrange [3:13]
set yrange [0:120]
set xtics 4,2,12

#:.! head -n2 ../../db_final.gen.tsv
#1    2    3     4         5        6         7         8     9     10    11    12    13
#gen  nr   enr   G         phd      avg1(G)   avg2(G)   conc  layr  vDOC  TDOC  vCal  TCal
#0    212  2947  10.95940  0.00000  -8.43005  -9.76459  4     6     16    80    18    300
#plot filename u 8:4 pt 7 t "O"

plot filename u 9:4 pt 7 ps width notitle
#pause -1
