set xrange[300:1200]
set yrange[0:0.3]
set term pngcairo size 1200, 900 font ",30"
set ylabel "Reflection"
set xlabel "wavenumber [cm^{-1}]"
set xlabel "wavelength [nm]"
set out "gr.png"
p \
	"138_g_00L_R.dpt"  w l t "0"  , \
	"118_g_03L_R.dpt"  w l t "3"  , \
	"114_g_05L_R.dpt"  w l t "5"  , \
	"130_g_10L_R2.dpt" w l t "10" , \
	"136_g_11L_R.dpt"  w l t "11"
#
#	"138_g_00L_R.dpt"  every :::1 w l t "0"  , \
#	"118_g_03L_R.dpt"  every :::1 w l t "3"  , \
#	"114_g_05L_R.dpt"  every :::1 w l t "5"  , \
#	"130_g_10L_R2.dpt" every :::1 w l t "10" , \
#	"136_g_11L_R.dpt"  every :::1 w l t "11"
#
#	"116_g_10dL_R.dpt" w l t "10d", \
#	"130_g_10L_R1.dpt" w l t "10" , \

set out "gr_abs.png"
set ylabel "Reflectance"
set yrange[0:1.2]
p \
	"138_g_00L_R.dpt"  u 1:(log10(1/$2)) w l , \
	"118_g_03L_R.dpt"  u 1:(log10(1/$2)) w l , \
	"114_g_05L_R.dpt"  u 1:(log10(1/$2)) w l , \
	"130_g_10L_R2.dpt" u 1:(log10(1/$2)) w l , \
	"136_g_11L_R.dpt"  u 1:(log10(1/$2)) w l 
#
#	"116_g_10dL_R.dpt" u 1:(log10(1/$2)) w l , \
#	"130_g_10L_R1.dpt" u 1:(log10(1/$2)) w l , \

#pause -1
