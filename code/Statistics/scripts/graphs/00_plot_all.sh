#!/bin/bash

for GPSCRIPT in $(ls *gp)
do 
    gnuplot $GPSCRIPT
done
