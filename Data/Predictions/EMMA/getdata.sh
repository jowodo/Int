#!/bin/bash

all=9000
conclvl=4; conck=2
layrlvl=5; layrk=3
vdoclvl=6; vdock=4
tdoclvl=5; tdock=5
vcallvl=5; vcalk=6
tcallvl=3; tcalk=7

filename=allspace.dat
lines=$(wc -l $filename | awk '{print $1}')

ffpp=/tmp/fifopipe
touch $ffpp-1
touch $ffpp-2
touch $ffpp-3
touch $ffpp-4
touch $ffpp-5
touch $ffpp-6
touch $ffpp-7
touch $ffpp-8
touch $ffpp-9
touch $ffpp-0

part=$all
head -n1 $filename 

tail -n $(($lines-1)) $filename > $ffpp-1 & \
	sort -hk $layrk $ffpp-1 > $ffpp-2 && part=$(($part/$layrlvl)) && head -n $(($part*1)) $ffpp-2 | tail -n $part > $ffpp-3 && \
	sort -hk $vdock $ffpp-3 > $ffpp-4 && part=$(($part/$vdoclvl)) && head -n $(($part*1)) $ffpp-4 | tail -n $part > $ffpp-5 && \
	sort -hk $tdock $ffpp-5 > $ffpp-6 && part=$(($part/$tdoclvl)) && head -n $(($part*2)) $ffpp-6 | tail -n $part > $ffpp-7 && \
	sort -hk $vcalk $ffpp-7 > $ffpp-8 && part=$(($part/$vcallvl)) && head -n $(($part*1)) $ffpp-8 | tail -n $part > $ffpp-9 && \
	sort -hk $tcalk $ffpp-9 > $ffpp-0 && part=$(($part/$tcallvl)) && head -n $(($part*1)) $ffpp-0

rm $ffpp-1
rm $ffpp-2
rm $ffpp-3
rm $ffpp-4
rm $ffpp-5
rm $ffpp-6
rm $ffpp-7
rm $ffpp-8
rm $ffpp-9
rm $ffpp-0
exit 

