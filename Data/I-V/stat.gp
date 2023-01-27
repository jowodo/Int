#set xlabel "-log_{10}({/Symbol g})"
set xlabel "-log_{10}(G)"
set ylabel "occurence [%]"
set xtics 1
set xrange [0:13]
set yrange [0:100]
#set term pngcairo
set term pngcairo size 1200, 900 font ",30"
set out "stat.png"
p "stat.dat" u 1:2 w boxes fs solid 0.5 t "" ,\
	'< echo "5 120"' w impulse notitle lc rgb "black"
