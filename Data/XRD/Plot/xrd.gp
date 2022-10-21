base="226_0001_4x2F_v10T40_T300v2"
infile=base.".txt"
outfile=base.".png"
outfile="xrd.png"
set term pngcairo
set out outfile
set key autotitle columnhead
set yrange [0:6000]
set xrange [0:140]
set ylabel "Intensity [a.u.] "
set xlabel "2{/symbol q} [°]"

p [0:110]  "ref.txt" u 1:4 w i lw 2, \
    "ref.txt" u 1:($5*3) w i lw 2, \
    [0:110]  "231_0360_12x5F_v20T60_T300v2.txt" u 2:($3-3500) w l t "231" , \
    [0:110]  "steel.txt" u 2:($3 -5500) w l t "substrate(steel)" 

#p "207_6113_10x2F_v18T40_T500v2.txt" u 2:($3-0000) w l ,\
#"a-Fe_ZrO2.csv" u 2:($3-0000) w l ,\
#"steel.txt" u 2:($3-0000) w l ,\
#"zro2.ref" u 1:($2-0000) w l
 
#"211_6554_10x3F_v16T80_T500v2.txt" u 2:($3-0000) w l ,\
#"213_8318_12x3F_v12T80_T500v14.txt" u 2:($3-0000) w l ,\
#"217_7374_10x3F_v14T50_T500v10.txt" u 2:($3-0000) w l ,\
#"223_1462_4x3F_v12T60_T300v10.txt" u 2:($3-0000) w l ,\
#"224_2883_4x4F_v10T80_T300v18.txt" u 2:($3-0000) w l ,\
#"226_0001_4x2F_v10T40_T300v2.txt" u 2:($3-0000) w l ,\
#"229_2884_4x5F_v20T40_T300v18.txt" u 2:($3-0000) w l ,\
#"231_0360_12x5F_v20T60_T300v2.txt" u 2:($3-0000) w l ,\
#"242_3077_12x2F_v16T40_T400v2.txt" u 2:($3-0000) w l ,\

#pause 5

#p infile u 2:($3-5500) w l ,\
#	"steel.txt" u 2:($3-5500) w l 
# p pt 0
