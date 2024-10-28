#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "gen-vcal.png"
#set term svg
#set out "gen-vcal.svg"
filename="../../db_final.gen.tsv"
width=2
set xlabel "generation number"
set ylabel "heating rate calcination"  
set xtics 0,1
#set range

plot [1:4] filename u 1:12 w l lw width notitle

#pause -1
