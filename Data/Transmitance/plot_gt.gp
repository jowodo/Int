set yrange[0.75:1.0]
set term pngcairo
set out "gt.png"
plot \
	"138_g_00L_T.dpt" w l , \
	"118_g_03L_T.dpt" w l , \
	"114_g_05L_T.dpt" w l , \
	"116_g_10dL_T.dpt" w l , \
	"130_g_10L_T.dpt" w l , \
	"136_g_11L_T.dpt" w l
#	"118_g_03L_T00.dpt" w l , \
#	"118_g_03L_T01.dpt" w l , \

#pause -1
