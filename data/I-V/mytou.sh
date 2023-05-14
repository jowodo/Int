#!/bin/zsh

for dir in I-V*;  do
#for dir in I-V_201*;  do
    pushd $dir
    for file in  *L*; do 
#    for file in  *L1C1_04; do 
        sed "s/µ/u/" <<< $( iconv -f ISO-8859-1 -t UTF-8 $file)  > $file
    done
    popd
done

