#!/bin/bash 
#
OUTFILE=cv_best.scale.scores
./0_cvgs.sh -x | sort -n -k2 | grep "krr\.g" | tail -1 | tee $OUTFILE
./0_cvgs.sh -x | sort -n -k2 | grep "krr\.p" | tail -1 | tee -a $OUTFILE
./0_cvgs.sh -x | sort -n -k2 | grep "svm\.g" | tail -1 | tee -a $OUTFILE
./0_cvgs.sh -x | sort -n -k2 | grep "svm\.p" | tail -1 | tee -a $OUTFILE
echo "created $OUTFILE"

