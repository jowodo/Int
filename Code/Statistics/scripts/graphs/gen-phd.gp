#!/usr/bin/gnuplot 

set term pngcairo
set out "gen-phd.png"
#set term svg
#set out "gen-phd.svg"
filename="../../db_final.gen.tsv"
width=2
set xlabel "generation number"
set ylabel "pin hole density {/Symbol r}"  
set xtics 0,1
set yrange [-0.1:1.1]

plot [1:4] filename u 1:5 w l lw width notitle

#pause -1
