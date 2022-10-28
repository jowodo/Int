set xrange [-0.5:0.5]
set logscale y
set yrange [1e-14:1e-1]
set xlabel "voltage [V]"
set ylabel "current [A]"
set term pngcairo
set out "log-i-v.png"
plot "./154_L04C2_01_best_contactspot" u 1:(abs($2)) w l t "" ,\
	"./154_L11C0_01" u 1:(abs($2)) w l t "" ,\
	"./154_L11C2_01" u 1:(abs($2)) w l t "" ,\
	"./154_L11C2_02" u 1:(abs($2)) w l t "" ,\
	"./154_L11C3_01" u 1:(abs($2)) w l t "" ,\
	"./154_L11C4_01" u 1:(abs($2)) w l t "" ,\
	"./154_L15C0_01" u 1:(abs($2)) w l t "" ,\
	"./154_L15C2_01" u 1:(abs($2)) w l t "" 
