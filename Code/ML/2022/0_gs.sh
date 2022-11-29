#!/bin/bash 
OUTFILE=gs_best.out
source ../../../../pyvenv/bin/activate
./gs_krr.py -e -y2 2>/dev/null > gs_krr.g.emma # grid search with only EMMA samples as data set
./gs_krr.py -e -y3 2>/dev/null > gs_krr.p.emma # grid search with only EMMA samples as data set
./gs_krr.py    -y2 2>/dev/null > gs_krr.g.all # grid search with all samples as data set
./gs_krr.py    -y3 2>/dev/null > gs_krr.p.all # grid search with all samples as data set
./gs_svm.py -e -y2 2>/dev/null > gs_svm.g.emma 
./gs_svm.py -e -y3 2>/dev/null > gs_svm.p.emma 
./gs_svm.py    -y2 2>/dev/null > gs_svm.g.all
./gs_svm.py    -y3 2>/dev/null > gs_svm.p.all
echo -n "KRR EMMA G   " | tee $OUTFILE
sort -h gs_krr.g.emma | head -n2 | tail -n1 | tee -a $OUTFILE
echo -n "KRR EMMA phd " | tee -a $OUTFILE
sort -h gs_krr.p.emma | head -n2 | tail -n1 | tee -a $OUTFILE
echo -n "KRR ALLE G   " | tee -a $OUTFILE
sort -h gs_krr.g.all  | head -n2 | tail -n1 | tee -a $OUTFILE
echo -n "KRR ALLE phd " | tee -a $OUTFILE
sort -h gs_krr.p.all  | head -n2 | tail -n1 | tee -a $OUTFILE
echo -n "SVM EMMA G   " | tee -a $OUTFILE
sort -h gs_svm.g.emma | head -n2 | tail -n1 | tee -a $OUTFILE
echo -n "SVM EMMA phd " | tee -a $OUTFILE
sort -h gs_svm.p.emma | head -n2 | tail -n1 | tee -a $OUTFILE
echo -n "SVM ALLE G   " | tee -a $OUTFILE
sort -h gs_svm.g.all  | head -n2 | tail -n1 | tee -a $OUTFILE
echo -n "SVM ALLE phd " | tee -a $OUTFILE
sort -h gs_svm.p.all  | head -n2 | tail -n1 | tee -a $OUTFILE


