#!/bin/bash 
#
#USAGE: ./anova.sh [--all] 

for dep in G phd layr vcal 
do 
    echo $dep
    ./anova-${dep}.R $1 | grep -A1 --no-group-separator -e "F val" | grep "*" 2> /dev/null
done 
