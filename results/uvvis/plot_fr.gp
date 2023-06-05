#!/bin/envs gnuplot

# needs calibration 

outfile1="fr.png"
outfile2="fr_abs.png"

f00="../../../data/uvvis/139_f_00L_R.dpt"
f03="../../../data/uvvis/119_f_03L_R.dpt"
f05="../../../data/uvvis/115_f_05L_R.dpt"
#f10="../../../data/uvvis/117_f_10dL_R.dpt"
f10="../../../data/uvvis/135_f_10L_R.dpt"
f11="../../../data/uvvis/137_f_11L_R.dpt"

set xrange[300:1200]
set term pngcairo size 1200, 900 font ",30"
set xlabel "wavelength [nm]"

set ylabel "Absorbance"
#set yrange[0.75:1.00]
set out outfile1
plot \
	f00 w l t "0"  , \
	f03 w l t "3"  , \
	f05 w l t "5"  , \
	f10 w l t "10" , \
	f11 w l t "11"

set ylabel "Absorbance"
#set yrange[0:0.2]
set out outfile2
plot \
	f00 u 1:(log10(1/$2)) w l t "0"  , \
	f03 u 1:(log10(1/$2)) w l t "3"  , \
	f05 u 1:(log10(1/$2)) w l t "5"  , \
	f10 u 1:(log10(1/$2)) w l t "10" , \
	f11 u 1:(log10(1/$2)) w l t "11"

#pause -1
