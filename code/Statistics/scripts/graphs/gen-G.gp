#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",30"
set out "gen-G.png"
#set term svg
#set out "gen-G.svg"
filename="../../db_final.gen.tsv"
width=3
set xlabel "generation number"
set ylabel "{/Symbol g} [a.u.]"  
set xtics 0,1
#set range

#plot [1:4] filename u 1:4 w l lw width notitle
plot filename every :::1 u 1:4 w l lw width notitle ,\
    filename every :::0::0 u 1:4 pt 7 ps width notitle ,\
	"../../db_final.avg.tsv" u 1:2 w l lw 4 notitle ,\
	"../../db_final.avg.tsv" u 1:4 w l lw 4 notitle

#pause -1
