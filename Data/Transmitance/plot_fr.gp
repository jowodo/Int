set yrange[0.0:0.3]
set term pngcairo
set out "fr.png"
plot \
	"139_f_00L_R.dpt" w l , \
	"115_f_05L_R.dpt" w l , \
	"119_f_03L_R.dpt" w l , \
	"117_f_10dL_R.dpt" w l , \
	"135_f_10L_R.dpt" w l , \
	"137_f_11L_R.dpt" w l 

#pause -1
