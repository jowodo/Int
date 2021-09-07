#!/bin/bash

for dir in I-V*;  do
    pushd $dir
    for file in  *L*C*; do 
        sed -i "s/µ/u/" $file
    done
    popd
done

