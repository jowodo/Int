for dir in $(ls -1 | grep -e "I-V*"); do 
#	echo $dir
	cd $dir
#	pwd
#	ls ..
	bash ../make_log_i-v.sh . > i-v-log.gp
	gnuplot i-v-log.gp
	cd .. 
done
