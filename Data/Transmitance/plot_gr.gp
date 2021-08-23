#set yrange[0:1.1]
set term pngcairo
set out "gr.png"
p \
	"118_g_03L_R.dpt" w l , \
	"114_g_05L_R.dpt" w l , \
	"116_g_10dL_R.dpt" w l , \
	"130_g_10L_R1.dpt" w l , \
	"130_g_10L_R2.dpt" w l , \
	"136_g_11L_R.dpt" w l 

set out "gr_abs.png"
set ylabel "Absorbance"
p \
	"118_g_03L_R.dpt"  u 1:(log10(1/$2)) w l , \
	"114_g_05L_R.dpt"  u 1:(log10(1/$2)) w l , \
	"116_g_10dL_R.dpt" u 1:(log10(1/$2)) w l , \
	"130_g_10L_R1.dpt" u 1:(log10(1/$2)) w l , \
	"130_g_10L_R2.dpt" u 1:(log10(1/$2)) w l , \
	"136_g_11L_R.dpt"  u 1:(log10(1/$2)) w l 

#pause -1
