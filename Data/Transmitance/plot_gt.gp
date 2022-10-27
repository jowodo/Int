#set yrange[0.75:1.0]
set term pngcairo
set ylabel "Tranmission"
set xlabel "wavenumber [cm^{-1}]"
set xlabel "wavelength [nm]"
set out "gt.png"
plot \
	"138_g_00L_T.dpt" w l t "0" , \
	"118_g_03L_T.dpt" w l t "3" , \
	"114_g_05L_T.dpt" w l t "5" , \
	"130_g_10L_T.dpt" w l t "10" , \
	"136_g_11L_T.dpt" w l t "11"
#	"116_g_10dL_T.dpt" w l t "10d" , \
#	"118_g_03L_T00.dpt" w l , \
#	"118_g_03L_T01.dpt" w l , \

set out "gt_abs.png"
set ylabel "Absorbance"
plot \
	"138_g_00L_T.dpt"  u 1:(log10(1/$2))  w l , \
	"118_g_03L_T.dpt"  u 1:(log10(1/$2))  w l , \
	"114_g_05L_T.dpt"  u 1:(log10(1/$2))  w l , \
	"116_g_10dL_T.dpt" u 1:(log10(1/$2))  w l , \
	"130_g_10L_T.dpt"  u 1:(log10(1/$2))  w l , \
	"136_g_11L_T.dpt"  u 1:(log10(1/$2))  w l
#	"118_g_03L_T00.dpt" w l , \
#	"118_g_03L_T01.dpt" w l , \

#pause -1
