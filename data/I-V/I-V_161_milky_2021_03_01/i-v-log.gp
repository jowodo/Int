set xrange [-0.5:0.5]
set logscale y
set term pngcairo
set out "log-i-v.png"
plot "./161_L07C3_01" u 1:(abs($2)) w l t "" ,\
	"./161_L07C3_02" u 1:(abs($2)) w l t "" 
