#!/usr/bin/gnuplot 

set term pngcairo size 1200, 900 font ",45"
set out "phd-tcal.png"
#set term svg
#set out "phd-tcal.svg"
#filename="../../db_final.sorted.tsv"
filename="../../db_final.tsv"
filename="../../gen.tsv"
filename="../../db_final.gen.tsv"
width=3
set xlabel "T_{cal} [^oC]"
set ylabel "{/Symbol r}"
set xrange [250:550]
set yrange [0:1.4]
set xtics 300,100

set key font ",30"
plot "../../db_final.tsv" u 12:4 pt 7 ps width t "pre-EMMA" ,\
    filename u 13:5 pt 9 ps width t "EMMA"

#pause -1
