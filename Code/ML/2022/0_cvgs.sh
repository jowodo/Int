#!/bin/bash 
HELPTEXT="This program executes grid seach on hyper parameters
\nUSAGE: $0 [-hrx] 
\n\t-h\t print this help message and exit 
\n\t-r\t recalculate everthing
\n\t-x\t scale before fitting"
recalculate="FALSE"
scale="FALSE"
help_bool="FALSE"

for flag in "$@"
do 
    case $flag in 
        -r) recalculate="TRUE";;
        -x) scale="TRUE";;
        -h) help_bool="TRUE";;
    esac
done 

if [ $help_bool == "TRUE" ] 
then 
    echo -e $HELPTEXT
    exit 0 
fi 
if  [ $scale == "TRUE" ] 
then 
    scaleflag="--scale"
    scalename=".scale"
fi 
OUTFILE=cv_best$scalename.out

if [ $recalculate == "TRUE" ] 
then
    source ../../../../int.venv/bin/activate
    set -x 
    ./cv_krr.py --emma -y2 $scaleflag 2>/dev/null > cs_krr.g$scalename.emma # grid search with only EMMA samples as data set
    ./cv_krr.py --emma -y3 $scaleflag 2>/dev/null > cs_krr.p$scalename.emma # grid search with only EMMA samples as data set
    ./cv_krr.py        -y2 $scaleflag 2>/dev/null > cs_krr.g$scalename.all # grid search with all samples as data set
    ./cv_krr.py        -y3 $scaleflag 2>/dev/null > cs_krr.p$scalename.all # grid search with all samples as data set
    ./cv_svm.py --emma -y2 $scaleflag 2>/dev/null > cs_svm.g$scalename.emma 
    ./cv_svm.py --emma -y3 $scaleflag 2>/dev/null > cs_svm.p$scalename.emma 
    ./cv_svm.py        -y2 $scaleflag 2>/dev/null > cs_svm.g$scalename.all
    ./cv_svm.py        -y3 $scaleflag 2>/dev/null > cs_svm.p$scalename.all
    set +x
fi

rm $OUTFILE
echo $OUTFILE
#echo -e "FILE\t\t MAE\t\t MSE\t\t sigma\t\t sigma_pred"
if [ $scale == "TRUE" ] 
then 
    echo -e "FILE\t\t\t mean(SCORE)\tvar(SCORE)\tparams"
else 
    echo -e "FILE\t\t mean(SCORE)\tvar(SCORE)\tparams"
fi 
for file in $(ls cv*${scalename}.emma) 
do 
    [[ $scale == "FALSE" && $file == *scale* ]] && continue 
    for kernel in "deg=1" "deg=2" "deg=3" "rbf" "sigmoid"
    do 
        echo -ne "$file\t" | tee -a $OUTFILE
        grep -e $kernel $file | sort -hr -k1 | tail -1 | tee -a $OUTFILE
    done
    echo "-"
done
