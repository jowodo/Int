#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "gen-phd.png"
#set term svg
#set out "gen-phd.svg"
filename="../../db_final.gen.tsv"
width=3
set xlabel "generation number"
set ylabel "{/Symbol r}"  
set xtics 0,1
set yrange [-0.1:1.1]

plot [1:4] filename u 1:5 w l lw width notitle

#pause -1
