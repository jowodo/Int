#!/usr/bin/gnuplot 

set term pngcairo
set out "gen-layr.png"
#set term svg
#set out "gen-layr.svg"
filename="../../db_final.gen.tsv"
width=2
set xlabel "generation number"
set ylabel "layers"  
set xtics 0,1
#set range

plot [1:4] filename u 1:9 w l lw width notitle

#pause -1
