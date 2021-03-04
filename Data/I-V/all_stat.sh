for dir in $(ls -1 | grep -e "I-V*"); do 
	cd $dir
	pwd
	python3 ../stat.py > stat.dat
	gnuplot ../stat.gp
	cd .. 
done
