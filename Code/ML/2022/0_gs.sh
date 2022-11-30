#!/bin/bash 
OUTFILE=gs_best.out
# IF THERE IS A COMMAND LINE ARGUMENT
if [ "x$1" != "x" ] 
then 
    # IF IT IS "-r", then recalculate
    if [ "$1" = "-r" ] 
    then
        source ../../../../pyvenv/bin/activate
        ./gs_krr.py -e -y2 2>/dev/null > gs_krr.g.emma # grid search with only EMMA samples as data set
        ./gs_krr.py -e -y3 2>/dev/null > gs_krr.p.emma # grid search with only EMMA samples as data set
        ./gs_krr.py    -y2 2>/dev/null > gs_krr.g.all # grid search with all samples as data set
        ./gs_krr.py    -y3 2>/dev/null > gs_krr.p.all # grid search with all samples as data set
        ./gs_svm.py -e -y2 2>/dev/null > gs_svm.g.emma 
        ./gs_svm.py -e -y3 2>/dev/null > gs_svm.p.emma 
        ./gs_svm.py    -y2 2>/dev/null > gs_svm.g.all
        ./gs_svm.py    -y3 2>/dev/null > gs_svm.p.all
    fi
fi 

rm $OUTFILE
for file in $(ls gs*emma) 
do 
    for kernel in "deg=1" "deg=2" "deg=3" "rbf" "sigmoid"
    do 
        echo -ne "$file\t" | tee -a $OUTFILE
        grep -e $kernel $file | sort -hr | tail -1 | tee -a $OUTFILE
    done
done
