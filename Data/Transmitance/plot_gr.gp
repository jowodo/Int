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

#pause -1
