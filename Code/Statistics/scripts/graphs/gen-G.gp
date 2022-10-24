#!/usr/bin/gnuplot 

set term pngcairo
set out "gen-G.png"
#set term svg
#set out "gen-G.svg"
filename="../../db_final.gen.tsv"
width=2
set xlabel "generation number"
set ylabel "conductivity pG [a.u.]"  
set xtics 0,1
#set range

plot [1:4] filename u 1:4 w l lw width notitle

#pause -1
