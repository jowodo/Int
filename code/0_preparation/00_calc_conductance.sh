#!/bin/bash 
#

OUTDIR=$PWD/conductance 
IVDIR=../../data/I-V

mkdir -p $OUTDIR
for SAMPLE in $(ls -1 $IVDIR | grep "I-V" | head )
do
    for MEASUREMENT in $(ls $IVDIR/$SAMPLE | grep -E ".*L.*C*") 
    do
        python3 01_calc_conductance.py $IVDIR/$SAMPLE/$MEASUREMENT >> $OUTDIR/$SAMPLE
    done
done


