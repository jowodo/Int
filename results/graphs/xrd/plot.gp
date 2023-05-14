#!/bin/envs gnuplot
#
sample=   "../../../data/XRD/2021_03_30/207_6113_10x2F_v18T40_T500v2.txt"
substrate="../../../data/XRD/2021_03_30/steel.txt"
reference="../../../data/XRD/2021_03_30/ref.txt"

outfile="xrd.png"
set term pngcairo size 1200,900
set out outfile
set key autotitle columnhead
set yrange [0:3500]
set xrange [0:140]
set ylabel "Intensity [a.u.] "
set xlabel "2{/symbol q} [°]"

p [0:110]  reference u 1:4 w i lw 3 t "ZrO_2", \
    reference u 1:($5*3) w i lw 3 t "{/Symbol a}-Fe", \
    [0:110]  sample u ($2+0.5):($3-4500) w l t "6113" , \
    [0:110]  substrate u ($2+0.5):($3 -5500) w l t "substrate (steel)" 
