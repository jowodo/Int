set term pngcairo
set out "hp1.png"
filename="hp1.csv"
width=2
set xlabel "Time [min]"
set ylabel "Temperature [°C]"
set xrange [0:550]
set yrange [0:550]

plot filename u 3:1 w l lw width t "HP1" ,\
	filename u 4:1 w l lw width t "NT1"	,\
	filename u 5:1 w l lw width t "NT2" ,\
	filename u 6:1 w l lw width t "NT3" ,\
	filename u 7:1 w l lw width t "NT4" ,\
	filename u 8:1 w l lw width t "NT5" ,\
	filename u 9:1 w l lw width t "NT6"

#pause -1
