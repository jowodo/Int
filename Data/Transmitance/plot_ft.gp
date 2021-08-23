#set yrange[0.0:1.1]
set term pngcairo
set out "ft.png"
plot \
	"139_f_00L_T.dpt" w l , \
	"119_f_03L_T.dpt" w l , \
	"121_f_3L_T.dpt" w l , \
	"115_f_05L_T.dpt" w l , \
	"117_f_10dL_T.dpt" w l , \
	"135_f_10L_T.dpt" w l , \
	"137_f_11L_T.dpt" w l 

set out "ft_abs.png"
set ylabel "Absorbance"
plot \
	"139_f_00L_T.dpt"  u 1:(log10(1/$2)) w l , \
	"119_f_03L_T.dpt"  u 1:(log10(1/$2)) w l , \
	"121_f_3L_T.dpt"   u 1:(log10(1/$2)) w l , \
	"115_f_05L_T.dpt"  u 1:(log10(1/$2)) w l , \
	"117_f_10dL_T.dpt" u 1:(log10(1/$2)) w l , \
	"135_f_10L_T.dpt"  u 1:(log10(1/$2)) w l , \
	"137_f_11L_T.dpt"  u 1:(log10(1/$2)) w l 

#pause -1 
