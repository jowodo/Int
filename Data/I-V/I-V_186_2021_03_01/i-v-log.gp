set xrange [-0.5:0.5]
set logscale y
set term pngcairo
set out "log-i-v.png"
plot "./186_L02C1_01" u 1:(abs($2)) w l t "" ,\
	"./186_L02C2_01" u 1:(abs($2)) w l t "" ,\
	"./186_L02C3_01" u 1:(abs($2)) w l t "" ,\
	"./186_L03C1_01" u 1:(abs($2)) w l t "" ,\
	"./186_L03C2_01" u 1:(abs($2)) w l t "" ,\
	"./186_L03C3_01" u 1:(abs($2)) w l t "" ,\
	"./186_L03C4_01" u 1:(abs($2)) w l t "" ,\
	"./186_L04C1_01" u 1:(abs($2)) w l t "" ,\
	"./186_L04C2_01" u 1:(abs($2)) w l t "" ,\
	"./186_L04C3_01" u 1:(abs($2)) w l t "" ,\
	"./186_L04C4_01" u 1:(abs($2)) w l t "" ,\
	"./186_L05C1_01" u 1:(abs($2)) w l t "" ,\
	"./186_L05C2_01" u 1:(abs($2)) w l t "" ,\
	"./186_L05C3_01" u 1:(abs($2)) w l t "" ,\
	"./186_L05C4_01" u 1:(abs($2)) w l t "" ,\
	"./186_L05C5_01_not_on_dot" u 1:(abs($2)) w l t "" ,\
	"./186_L13C1_01_scratch" u 1:(abs($2)) w l t "" ,\
	"./186_L13C2_01" u 1:(abs($2)) w l t "" ,\
	"./186_L13C4_01" u 1:(abs($2)) w l t "" ,\
	"./186_L14C2_01" u 1:(abs($2)) w l t "" ,\
	"./186_L14C3_01" u 1:(abs($2)) w l t "" ,\
	"./186_L14C4_01" u 1:(abs($2)) w l t "" ,\
	"./186_L14C4_02" u 1:(abs($2)) w l t "" 
