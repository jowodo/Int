#!/bin/bash
for dir in $(ls | grep -e "2021"); do
	echo $dir
	cp $dir/log-i-v.png pictures/$dir.png
	echo $dir.png
done
