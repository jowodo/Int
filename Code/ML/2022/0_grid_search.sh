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
OUTFILE=gs_best$scalename.out

if [ $recalculate == "TRUE" ] 
then
    source ../../../../int.venv/bin/activate
    echo "start KRR emma data set"
    ./gs_krr.py --emma -y2 $scaleflag 2>/dev/null > gs_krr.g$scalename.emma # grid search with only EMMA samples as data set
    ./gs_krr.py --emma -y3 $scaleflag 2>/dev/null > gs_krr.p$scalename.emma # grid search with only EMMA samples as data set
    echo "start KRR complete data set"
    ./gs_krr.py        -y2 $scaleflag 2>/dev/null > gs_krr.g$scalename.all # grid search with all samples as data set
    ./gs_krr.py        -y3 $scaleflag 2>/dev/null > gs_krr.p$scalename.all # grid search with all samples as data set
    echo "start SVM emma data set"
    ./gs_svm.py --emma -y2 $scaleflag 2>/dev/null > gs_svm.g$scalename.emma 
    ./gs_svm.py --emma -y3 $scaleflag 2>/dev/null > gs_svm.p$scalename.emma 
    echo "start SVM complete data set"
    ./gs_svm.py        -y2 $scaleflag 2>/dev/null > gs_svm.g$scalename.all
    ./gs_svm.py        -y3 $scaleflag 2>/dev/null > gs_svm.p$scalename.all
fi

rm $OUTFILE
echo $OUTFILE
echo -e "FILE\t\t MAE\t\t MSE\t\t sigma\t\t sigma_pred"
for file in $(ls gs*${scalename}.emma) 
do 
    [[ $scale == "FALSE" && $file == *scale* ]] && continue 
    for kernel in "deg=1" "deg=2" "deg=3" "rbf" "sigmoid"
    do 
        echo -ne "$file\t" | tee -a $OUTFILE
        grep -e $kernel $file | sort -hr -k1 | tail -1 | tee -a $OUTFILE
    done
    echo "-"
done
