#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",20"
set out "phd-layr.png"
#set term svg
#set out "phd-layr.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "layers {/Symbol l}"
set ylabel "pin hole density {/Symbol r}"
set xrange [0.5:12.5]
set yrange [0:1.2]
set xtics 2,2

#:.! head -n2 ../../db_final.gen.tsv
#1    2    3     4         5        6         7         8     9     10    11    12    13
#gen  nr   enr   G         phd      avg1(G)   avg2(G)   conc  layr  vDOC  TDOC  vCal  TCal
#0    212  2947  10.95940  0.00000  -8.43005  -9.76459  4     6     16    80    18    300
#plot filename u 8:4 pt 7 t "O"

plot "../../db_final.tsv" u 8:4 pt 7 t "PO" ,\
    filename u 9:5 pt 7 t "O"
#pause -1
