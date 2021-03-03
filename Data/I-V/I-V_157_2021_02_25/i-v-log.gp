set xrange [-0.5:0.5]
set logscale y
set term pngcairo
set out "log-i-v.png"
plot "./157_L13C1_01" u 1:(abs($2)) w l t "" ,\
	"./157_L13C2_01" u 1:(abs($2)) w l t "" ,\
	"./157_L14C1_01" u 1:(abs($2)) w l t "" ,\
	"./157_L14C2_01" u 1:(abs($2)) w l t "" ,\
	"./157_L14C3_01" u 1:(abs($2)) w l t "" ,\
	"./157_L14C4_01" u 1:(abs($2)) w l t "" ,\
	"./157_L14C5_01" u 1:(abs($2)) w l t "" 
