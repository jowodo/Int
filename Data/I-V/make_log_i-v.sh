#!/bin/bash
pth=$1
lines=($(echo $(ls -1 $pth/*L*C* ) | tr ";" "\n"))
no_lines=${#lines[@]}
i=0
png=1

#### SETTINGS HEAD
echo "set xrange [-0.5:0.5]"
echo "set logscale y"
if [ $png -eq 1 ]; then 
	echo "set term pngcairo"
	echo "set out \"log-i-v.png\""
fi


using='u 1:(abs($2))'
style="w l t \"\""
for line in ${lines[@]}; do 
	((i+=1))
#	echo $1
	if [ $i -eq 1 ]; then 
		echo "plot \"$line\" $using $style ,\\"
	elif [ $i -eq $no_lines  ]; then 
		echo -e "\t\"$line\" $using $style "
	else
		echo -e "\t\"$line\" $using $style ,\\"
	fi
done

if [ ! $png -eq 1 ]; then 
	echo pause -1
fi
exit 0

