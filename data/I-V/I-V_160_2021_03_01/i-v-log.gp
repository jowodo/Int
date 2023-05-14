set xrange [-0.5:0.5]
set logscale y
set term pngcairo
set out "log-i-v.png"
plot "./160_L04C1_01" u 1:(abs($2)) w l t "" ,\
	"./160_L04C2_01" u 1:(abs($2)) w l t "" ,\
	"./160_L04C3_01" u 1:(abs($2)) w l t "" ,\
	"./160_L10C1_01" u 1:(abs($2)) w l t "" ,\
	"./160_L10C2_01" u 1:(abs($2)) w l t "" ,\
	"./160_L11C1_01" u 1:(abs($2)) w l t "" ,\
	"./160_L12C1_01" u 1:(abs($2)) w l t "" ,\
	"./160_L13C2_01" u 1:(abs($2)) w l t "" ,\
	"./160_L13C5_01" u 1:(abs($2)) w l t "" ,\
	"./160_L14C1_01" u 1:(abs($2)) w l t "" ,\
	"./160_L14C2_01" u 1:(abs($2)) w l t "" ,\
	"./160_L14C6_01" u 1:(abs($2)) w l t "" 
