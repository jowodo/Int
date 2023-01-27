set xrange [-0.5:0.5]
set logscale y
set xlabel "voltage [V]"
set ylabel "current [A]"
set term pngcairo size 1200, 900 font ",30"
set out "log-i-v.png"
plot "./156_L05C2_01" u 1:(abs($2)) w l t "" ,\
	"./156_L06C1_01" u 1:(abs($2)) w l t "" ,\
	"./156_L06C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L06C6_01" u 1:(abs($2)) w l t "" ,\
	"./156_L07C1_01" u 1:(abs($2)) w l t "" ,\
	"./156_L07C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L07C3_02" u 1:(abs($2)) w l t "" ,\
	"./156_L10C0_01" u 1:(abs($2)) w l t "" ,\
	"./156_L10C1_01" u 1:(abs($2)) w l t "" ,\
	"./156_L10C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L11C2_01" u 1:(abs($2)) w l t "" ,\
	"./156_L11C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L11C4_01" u 1:(abs($2)) w l t "" ,\
	"./156_L12C2_01" u 1:(abs($2)) w l t "" ,\
	"./156_L12C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L12C4_01" u 1:(abs($2)) w l t "" ,\
	"./156_L12C5_01" u 1:(abs($2)) w l t "" ,\
	"./156_L13C2_01" u 1:(abs($2)) w l t "" ,\
	"./156_L13C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L13C5_01" u 1:(abs($2)) w l t "" ,\
	"./156_L13C6_01" u 1:(abs($2)) w l t "" ,\
	"./156_L14C1_01" u 1:(abs($2)) w l t "" ,\
	"./156_L14C2_01" u 1:(abs($2)) w l t "" ,\
	"./156_L14C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L14C4_01" u 1:(abs($2)) w l t "" ,\
	"./156_L15C1_01" u 1:(abs($2)) w l t "" ,\
	"./156_L15C2_01" u 1:(abs($2)) w l t "" ,\
	"./156_L15C3_01" u 1:(abs($2)) w l t "" ,\
	"./156_L15C3_02" u 1:(abs($2)) w l t "" 
