set xrange [-0.5:0.5]
set logscale y
set term pngcairo
set out "log-i-v.png"
plot "./150_L1C1_01" u 1:(abs($2)) w l t "" ,\
	"./150_L1C2_01" u 1:(abs($2)) w l t "" ,\
	"./150_L1C4_01" u 1:(abs($2)) w l t "" ,\
	"./150_L1C5_01" u 1:(abs($2)) w l t "" ,\
	"./150_L1C6_01" u 1:(abs($2)) w l t "" ,\
	"./150_L1C7_01" u 1:(abs($2)) w l t "" ,\
	"./150_L1C8_01" u 1:(abs($2)) w l t "" ,\
	"./150_L2C1_01" u 1:(abs($2)) w l t "" ,\
	"./150_L2C5_01" u 1:(abs($2)) w l t "" ,\
	"./150_L2C6_01" u 1:(abs($2)) w l t "" ,\
	"./150_L2C7_01" u 1:(abs($2)) w l t "" ,\
	"./150_L2C8_01" u 1:(abs($2)) w l t "" ,\
	"./150_L3C1_01" u 1:(abs($2)) w l t "" ,\
	"./150_L3C5_01" u 1:(abs($2)) w l t "" ,\
	"./150_L3C6_01" u 1:(abs($2)) w l t "" ,\
	"./150_L3C7_01" u 1:(abs($2)) w l t "" ,\
	"./150_L3C8_01" u 1:(abs($2)) w l t "" ,\
	"./150_L4C1_01" u 1:(abs($2)) w l t "" ,\
	"./150_L4C6_01" u 1:(abs($2)) w l t "" ,\
	"./150_L4C7_01" u 1:(abs($2)) w l t "" ,\
	"./150_L4C8_01" u 1:(abs($2)) w l t "" 
