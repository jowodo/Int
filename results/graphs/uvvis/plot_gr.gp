#!/bin/envs gnuplot 

outfile1="gr.png"
outfile2="gr_abs.png"
f00="../../../data/uvvis/138_g_00L_R.dpt"
f03="../../../data/uvvis/118_g_03L_R.dpt"
f05="../../../data/uvvis/114_g_05L_R.dpt"
f10="../../../data/uvvis/130_g_10L_R2.dpt"
f11="../../../data/uvvis/136_g_11L_R.dpt"

set xrange[300:1200]
set term pngcairo size 1200, 900 font ",30"
set xlabel "wavelength [nm]"

set ylabel "Reflection"
set yrange[0:0.3]
set out outfile1
p \
	f00 w l t "0"  , \
	f03 w l t "3"  , \
	f05 w l t "5"  , \
	f10 w l t "10" , \
	f11 w l t "11"

set ylabel "Reflectance"
set yrange[0:1.2]
set out outfile2
p \
	f00 u 1:(log10(1/$2)) w l t "0"  , \
	f03 u 1:(log10(1/$2)) w l t "3"  , \
	f05 u 1:(log10(1/$2)) w l t "5"  , \
	f10 u 1:(log10(1/$2)) w l t "10" , \
	f11 u 1:(log10(1/$2)) w l t "11"

#pause -1
