set xrange [-0.5:0.5]
set logscale y
set xlabel "voltage [V]"
set ylabel "current [A]"
set term pngcairo size 1200, 900 font ",30"
set out "log-i-v.png"
plot "./146_L02C1_01_dot" u 1:(abs($2)) w l t "" ,\
	"./146_L02C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L02C2_02" u 1:(abs($2)) w l t "" ,\
	"./146_L02C2_03" u 1:(abs($2)) w l t "" ,\
	"./146_L03C1_01_dot" u 1:(abs($2)) w l t "" ,\
	"./146_L03C2_01_dot" u 1:(abs($2)) w l t "" ,\
	"./146_L03C3_01" u 1:(abs($2)) w l t "" ,\
	"./146_L04C1_01_dot" u 1:(abs($2)) w l t "" ,\
	"./146_L04C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L04C3_01" u 1:(abs($2)) w l t "" ,\
	"./146_L06C1_01" u 1:(abs($2)) w l t "" ,\
	"./146_L06C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L07C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L08C1_01" u 1:(abs($2)) w l t "" ,\
	"./146_L08C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L08C2_02" u 1:(abs($2)) w l t "" ,\
	"./146_L08C3_01" u 1:(abs($2)) w l t "" ,\
	"./146_L08C4_01" u 1:(abs($2)) w l t "" ,\
	"./146_L09C1_01" u 1:(abs($2)) w l t "" ,\
	"./146_L09C1_02" u 1:(abs($2)) w l t "" ,\
	"./146_L09C1_03" u 1:(abs($2)) w l t "" ,\
	"./146_L09C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L09C2_02" u 1:(abs($2)) w l t "" ,\
	"./146_L09C2_03" u 1:(abs($2)) w l t "" ,\
	"./146_L09C3_01" u 1:(abs($2)) w l t "" ,\
	"./146_L09C3_02" u 1:(abs($2)) w l t "" ,\
	"./146_L09C3_03" u 1:(abs($2)) w l t "" ,\
	"./146_L09C4_01" u 1:(abs($2)) w l t "" ,\
	"./146_L09C4_02" u 1:(abs($2)) w l t "" ,\
	"./146_L09C5_01" u 1:(abs($2)) w l t "" ,\
	"./146_L09C5_02" u 1:(abs($2)) w l t "" ,\
	"./146_L10C1_01" u 1:(abs($2)) w l t "" ,\
	"./146_L10C1_02" u 1:(abs($2)) w l t "" ,\
	"./146_L10C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L10C2_02" u 1:(abs($2)) w l t "" ,\
	"./146_L10C3_01" u 1:(abs($2)) w l t "" ,\
	"./146_L10C3_02" u 1:(abs($2)) w l t "" ,\
	"./146_L10C4_01" u 1:(abs($2)) w l t "" ,\
	"./146_L10C4_02" u 1:(abs($2)) w l t "" ,\
	"./146_L10C4_03" u 1:(abs($2)) w l t "" ,\
	"./146_L10C4_04" u 1:(abs($2)) w l t "" ,\
	"./146_L11C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L11C3_01" u 1:(abs($2)) w l t "" ,\
	"./146_L11C4_01" u 1:(abs($2)) w l t "" ,\
	"./146_L11C4_02" u 1:(abs($2)) w l t "" ,\
	"./146_L11C5_01" u 1:(abs($2)) w l t "" ,\
	"./146_L12C1_01" u 1:(abs($2)) w l t "" ,\
	"./146_L12C1_02" u 1:(abs($2)) w l t "" ,\
	"./146_L12C2_01" u 1:(abs($2)) w l t "" ,\
	"./146_L12C3_01" u 1:(abs($2)) w l t "" ,\
	"./146_L12C3_02" u 1:(abs($2)) w l t "" 