#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",20"
set out "phd-tcal.png"
#set term svg
#set out "phd-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "T_{cal} [^oC]"
set ylabel "pin hole density {/Symbol r}"
set xrange [250:550]
set yrange [0:1.2]
#set xtics 0,60

#plot filename u 13:5 pt 7 notitle

plot "../../db_final.tsv" u 12:4 pt 7 t "PO" ,\
    filename u 13:5 pt 7 t "O"

#pause -1
