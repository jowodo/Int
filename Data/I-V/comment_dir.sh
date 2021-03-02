path=$1
for file in $(ls $path -I *.png -I *.gp); do
	sed -i "1,36s/^/#/" $file
#	echo $file
done
