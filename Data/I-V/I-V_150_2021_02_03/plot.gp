set xrange [-0.5:0.5]
#set yrange [-0.0001:0.0001]
set logscale y
plot "150_Ag_Ag_01" u 1:(abs($2)) w l ,\
	"150_Ag_Ag_02" w l ,\
	"150_Ag_Ag_03" w l ,\
	"150_Ag_Ag_04" w l ,\
	"150_Ag_Ag_05" w l ,\
	"150_L0C0_01" w l ,\
	"150_L1C1_01" w l ,\
	"150_L1C2_01" w l ,\
	"150_L1C2_02" w l ,\
	"150_L1C2_03" w l ,\
	"150_L1C3_01" w l ,\
	"150_L1C3_02" w l ,\
	"150_L1C4_01" w l ,\
	"150_L1C4_02" w l ,\
	"150_L1C5_01" w l ,\
	"150_L1C5_02" w l ,\
	"150_L2C1_01" w l ,\
	"150_L2C4_01" w l ,\
	"150_L2C5_01" w l ,\
	"150_L2C5_02" w l ,\
	"150_L2C6_01" w l ,\
	"150_L2C6_02" w l ,\
	"150_L2C7_01" w l ,\
	"150_L3C&_01" w l ,\
	"150_L3C1_01" w l ,\
	"150_L3C2_01" w l ,\
	"150_L3C4_01" w l ,\
	"150_L3C5_01" w l ,\
	"150_L3C5_02" w l ,\
	"150_L3C6_01" w l ,\
	"150_L3C7_01" w l ,\
	"150_L3C7_02" w l ,\
	"150_L4C1_01" w l ,\
	"150_L4C7_01" w l ,\
	"150_L4C8_01" w l ,\
	"150_L4C8_02" w l ,\
	"150_L5C3_01" w l ,\
	"150_L6C0_01" w l 
pause -1