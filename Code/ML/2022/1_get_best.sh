#!/bin/bash 
#
# EXTRACT BEST HYPER PARAMETERS
TMP=tmp
OUT=calc_best_cmds.sh
echo "#!/bin/bash" > $OUT
#echo "set -x" >> $OUT
./0_cvgs.sh -x | awk '{print $1,$4,$5,$6,$7,$8,$9}' | grep -v -e "-" -e "FILE" -e "out" > $TMP

#ITERATE OVER EACH LINE 
while read line; 
do 
#    echo "${line}" ; 
    ALGO=$( echo $line | cut -d. -f1 | cut -d_ -f2)
    EXEC="./${ALGO}_pred.py"
    Y=$(echo $line | cut -d. -f2)
    if [ $Y == "g" ] ; then YN=3 ; elif [ $Y == "p" ] ; then YN=2 ; fi 
    KERNEL=$( echo $line | cut -d" " -f2 ) 
    if [ $KERNEL == "poly" ] ; then 
        DEGREE=$( echo $line | cut -d" " -f3 | cut -d= -f2) 
        DEGREE="-d $DEGREE"
    else 
        DEGREE=""
    fi 
    HP1=$( echo $line | cut -d" " -f4 | sed "s/=//" ) 
    HP2=$( echo $line | cut -d" " -f5 | sed "s/=//" ) 
    if [ $ALGO == "svm" ] ; then 
        HP3=$( echo $line | cut -d" " -f6 | sed "s/=//" ) 
        HP3="-$HP3"
    fi 
#    echo "$EXEC $Y $YN $KERNEL $DEGREE $HP1 $HP2 $HP3"
    echo "echo $ALGO $KERNEL $DEGREE $HP1 $HP2 $HP3" | tee -a $OUT
    echo "$EXEC -y $YN -k $KERNEL $DEGREE -$HP1 -$HP2 $HP3 --stat " >> $OUT
done < "${TMP}"

#chmod +x $PWD/$OUT
echo "created $PWD/$OUT"

rm $TMP

