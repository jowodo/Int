#!/bin/envs gnuplot 

outfile1="gt.png"
outfile2="gt_abs.png"
f00="../../data/uvvis/138_g_00L_T.dpt"
f03="../../data/uvvis/118_g_03L_T.dpt"
f05="../../data/uvvis/114_g_05L_T.dpt"
f10="../../data/uvvis/130_g_10L_T.dpt"
f11="../../data/uvvis/136_g_11L_T.dpt"

set xrange[300:1200]
set term pngcairo size 1200, 900 font ",30" dashed
set xlabel "wavelength [nm]"

set ylabel "Tranmission"
set yrange[0.75:1.00]
set out outfile1
p \
	f00 w l dashtype 1 lw 5 t "0"  , \
	f03 w l dashtype 2 lw 5 t "3"  , \
	f05 w l dashtype 3 lw 5 t "5"  , \
	f10 w l dashtype 4 lw 5 t "10" , \
	f11 w l dashtype 5 lw 5 t "11"

set ylabel "Transmittance"
set yrange[0:0.2]
set out outfile2
plot \
	f00 u 1:(log10(1/$2)) w l dashtype 1 lw 5 t "0"  , \
	f03 u 1:(log10(1/$2)) w l dashtype 2 lw 5 t "3"  , \
	f05 u 1:(log10(1/$2)) w l dashtype 3 lw 5 t "5"  , \
	f10 u 1:(log10(1/$2)) w l dashtype 4 lw 5 t "10" , \
	f11 u 1:(log10(1/$2)) w l dashtype 5 lw 5 t "11"

#pause -1
