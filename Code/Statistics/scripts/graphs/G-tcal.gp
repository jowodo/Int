#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",20"
set out "G-tcal.png"
#set term svg
#set out "G-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=2
set xlabel "T_{cal} [^oC]"
set ylabel "MAE (pG) {/Symbol g} [a.u.]"
set xrange [250:550]
set yrange [0:120]
#set xtics 0,60

#plot filename u 13:4 pt 7 notitle 

plot "../../db_final.tsv" u 12:3 pt 7 t "PO" ,\
    filename u 13:4 pt 7 t "O"
#pause -1
