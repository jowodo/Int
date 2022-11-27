#!/bin/bash 
source ../../../../pyvenv/bin/activate
./gs_krr.py -e -y2 2>/dev/null > gs_krr.g.emma # grid search with only EMMA samples as data set
./gs_krr.py -e -y3 2>/dev/null > gs_krr.p.emma # grid search with only EMMA samples as data set
./gs_krr.py    -y2 2>/dev/null > gs_krr.g.all # grid search with all samples as data set
./gs_krr.py    -y3 2>/dev/null > gs_krr.p.all # grid search with all samples as data set
./gs_svm.py -e -y2 2>/dev/null > gs_svm.g.emma 
./gs_svm.py -e -y3 2>/dev/null > gs_svm.p.emma 
./gs_svm.py    -y2 2>/dev/null > gs_svm.g.all
./gs_svm.py    -y3 2>/dev/null > gs_svm.p.all
#echo "========= KRR EMMA G   ========="
echo -n "KRR EMMA G   "
sort -h -k2 gs_krr.g.emma | head -n2 | tail -n1
#echo "========= KRR EMMA phd ========="
echo -n "KRR EMMA phd "
sort -h -k2 gs_krr.p.emma | head -n2 | tail -n1
#echo "========= KRR ALLE G   ========="
echo -n "KRR ALLE G   "
sort -h -k2 gs_krr.g.all  | head -n2 | tail -n1
#echo "========= KRR ALLE phd ========="
echo -n "KRR ALLE phd "
sort -h -k2 gs_krr.p.all  | head -n2 | tail -n1
#echo "========= SVM EMMA G   ========="
echo -n "SVM EMMA G   "
sort -h -k2 gs_svm.g.emma | head -n2 | tail -n1
#echo "========= SVM EMMA phd ========="
echo -n "SVM EMMA phd "
sort -h -k2 gs_svm.p.emma | head -n2 | tail -n1
#echo "========= SVM ALLE G   ========="
echo -n "SVM ALLE G   "
sort -h -k2 gs_svm.g.all  | head -n2 | tail -n1
#echo "========= SVM ALLE phd ========="
echo -n "SVM ALLE phd "
sort -h -k2 gs_svm.p.all  | head -n2 | tail -n1


