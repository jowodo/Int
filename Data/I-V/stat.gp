set xlabel "pondus G"
set ylabel "count"
set xtics 1
set yrange [0:100]
set term pngcairo
set out "stat.png"
p "stat.dat" u 1:2 w boxes fs solid 0.5 t ""
