#!/bin/bash 
recalculate="FALSE"
scale="FALSE"

for flag in "$@"
do 
    case $flag in 
        -r) recalculate="TRUE";;
        -x) scale="TRUE";;
    esac
done 

if  [ $scale == "TRUE" ] 
then 
    scaleflag="--scale"
    scalename=".scale"
fi 
OUTFILE=cv_best$scalename.out

if [ $recalculate == "TRUE" ] 
then
    source ../../../../pyvenv/bin/activate
    ./cv_krr.py --emma -y2 $scaleflag 2>/dev/null > cv_krr.g$scalename.emma # grid search with only EMMA samples as data set
    ./cv_krr.py --emma -y3 $scaleflag 2>/dev/null > cv_krr.p$scalename.emma # grid search with only EMMA samples as data set
#    ./cv_krr.py        -y2 $scaleflag 2>/dev/null > cv_krr.g$scalename.all # grid search with all samples as data set
#    ./cv_krr.py        -y3 $scaleflag 2>/dev/null > cv_krr.p$scalename.all # grid search with all samples as data set
    ./cv_svm.py --emma -y2 $scaleflag 2>/dev/null > cv_svm.g$scalename.emma 
    ./cv_svm.py --emma -y3 $scaleflag 2>/dev/null > cv_svm.p$scalename.emma 
#    ./cv_svm.py        -y2 $scaleflag 2>/dev/null > cv_svm.g$scalename.all
#    ./cv_svm.py        -y3 $scaleflag 2>/dev/null > cv_svm.p$scalename.all
fi

rm $OUTFILE
echo $OUTFILE
echo -e "FILE\t\t MAE\t\t MSE\t\t sigma\t\t sigma_pred"
for file in $(ls cv*${scalename}.emma) 
do 
    [[ $scale == "FALSE" && $file == *scale* ]] && continue 
    for kernel in "deg=1" "deg=2" "deg=3" "rbf" "sigmoid"
    do 
        echo -ne "$file\t" | tee -a $OUTFILE
        grep -e $kernel $file | sort -hr | tail -1 | tee -a $OUTFILE
    done
    echo "-"
done
