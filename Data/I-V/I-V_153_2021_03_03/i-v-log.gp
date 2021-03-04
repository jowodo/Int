set xrange [-0.5:0.5]
set logscale y
set term pngcairo
set out "log-i-v.png"
plot "./153_L02C1_01" u 1:(abs($2)) w l t "" ,\
	"./153_L02C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L02C4_01" u 1:(abs($2)) w l t "" ,\
	"./153_L03C1_01" u 1:(abs($2)) w l t "" ,\
	"./153_L03C2_01" u 1:(abs($2)) w l t "" ,\
	"./153_L03C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L04C0_01" u 1:(abs($2)) w l t "" ,\
	"./153_L04C1_01" u 1:(abs($2)) w l t "" ,\
	"./153_L04C2_01" u 1:(abs($2)) w l t "" ,\
	"./153_L04C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L04C4_01" u 1:(abs($2)) w l t "" ,\
	"./153_L05C1_01" u 1:(abs($2)) w l t "" ,\
	"./153_L05C2_01" u 1:(abs($2)) w l t "" ,\
	"./153_L05C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L05C4_01" u 1:(abs($2)) w l t "" ,\
	"./153_L05C5_01" u 1:(abs($2)) w l t "" ,\
	"./153_L06C0_01" u 1:(abs($2)) w l t "" ,\
	"./153_L06C2_01" u 1:(abs($2)) w l t "" ,\
	"./153_L06C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L06C4_01" u 1:(abs($2)) w l t "" ,\
	"./153_L06C5_01" u 1:(abs($2)) w l t "" ,\
	"./153_L07C1_01" u 1:(abs($2)) w l t "" ,\
	"./153_L07C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L08C0_01" u 1:(abs($2)) w l t "" ,\
	"./153_L08C2_01" u 1:(abs($2)) w l t "" ,\
	"./153_L08C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L08C4_01" u 1:(abs($2)) w l t "" ,\
	"./153_L08C5_01" u 1:(abs($2)) w l t "" ,\
	"./153_L09C1_01" u 1:(abs($2)) w l t "" ,\
	"./153_L09C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L09C4_01" u 1:(abs($2)) w l t "" ,\
	"./153_L09C5_01" u 1:(abs($2)) w l t "" ,\
	"./153_L10C3_01" u 1:(abs($2)) w l t "" ,\
	"./153_L13C1_01" u 1:(abs($2)) w l t "" ,\
	"./153_L13C2_01" u 1:(abs($2)) w l t "" ,\
	"./153_L13C3_01" u 1:(abs($2)) w l t "" 
