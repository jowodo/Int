set xrange [-0.5:0.5]
set logscale y
set term pngcairo
set out "log-i-v.png"
plot "./158_L05C0_01" u 1:(abs($2)) w l t "" ,\
	"./158_L05C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L05C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L05C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L06C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L06C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L07C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L07C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L08C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L08C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L08C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L08C3_02" u 1:(abs($2)) w l t "" ,\
	"./158_L09C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L09C4_01" u 1:(abs($2)) w l t "" ,\
	"./158_L10C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L10C1_02" u 1:(abs($2)) w l t "" ,\
	"./158_L10C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L10C2_02" u 1:(abs($2)) w l t "" ,\
	"./158_L10C2_03" u 1:(abs($2)) w l t "" ,\
	"./158_L10C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L11C0_01" u 1:(abs($2)) w l t "" ,\
	"./158_L11C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L11C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L11C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L11C4_01" u 1:(abs($2)) w l t "" ,\
	"./158_L11C4_02" u 1:(abs($2)) w l t "" ,\
	"./158_L11C4_03" u 1:(abs($2)) w l t "" ,\
	"./158_L11C4_04" u 1:(abs($2)) w l t "" ,\
	"./158_L11C4_05" u 1:(abs($2)) w l t "" ,\
	"./158_L11C4_06" u 1:(abs($2)) w l t "" ,\
	"./158_L11C5_01" u 1:(abs($2)) w l t "" ,\
	"./158_L12C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L12C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L12C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L12C4_01" u 1:(abs($2)) w l t "" ,\
	"./158_L12C5_01" u 1:(abs($2)) w l t "" ,\
	"./158_L12C6_01" u 1:(abs($2)) w l t "" ,\
	"./158_L12C7_01" u 1:(abs($2)) w l t "" ,\
	"./158_L13C0_01" u 1:(abs($2)) w l t "" ,\
	"./158_L13C1_01" u 1:(abs($2)) w l t "" ,\
	"./158_L13C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L13C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L13C4_01" u 1:(abs($2)) w l t "" ,\
	"./158_L14C2_01" u 1:(abs($2)) w l t "" ,\
	"./158_L14C2_02" u 1:(abs($2)) w l t "" ,\
	"./158_L14C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L14C4_01" u 1:(abs($2)) w l t "" ,\
	"./158_L15C3_01" u 1:(abs($2)) w l t "" ,\
	"./158_L15C3_02" u 1:(abs($2)) w l t "" 
