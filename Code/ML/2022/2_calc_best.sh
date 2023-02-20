#!/bin/bash
CONFIG_FILE=calc_best_cmds.sh # this file is created by executing 1

# COMMAND LINE ARGUMENTS
HELPTEXT="This program executes grid seach on hyper parameters
\nUSAGE: $0 [-hlrx] 
\n\t-h\t print this help message and exit 
\n\t-g\t grep output
\n\t-t\t tail output
\n\t-l\t format output as latex tabular"
help(){ echo -e $HELPTEXT && exit 2 ;}
tail="FALSE"
grep="FALSE"
latex="FALSE"
grep_opt=""

SHORT=g:,t,l,h
OPTS=$(getopt -a --options $SHORT -- "$@")
eval set -- "$OPTS"
while : 
do
    case "$1" in 
        -g) 
            grep="TRUE" 
            grep_opt="$2" 
            shift 2
            ;;
        -l) 
            latex="TRUE"
            shift;
            ;;
        -t) 
            tail="TRUE"
            shift;
            ;;
        -h) 
            help
            shift; 
            ;;
        --) 
            shift;
            break
            ;;
        *)
            echo "Unexpected option $1"
            help 
            ;;
    esac
done 




#ITERATE OVER EACH LINE 
while read line; 
do 
if [ $tail == "TRUE" ] ; then 
    eval "${line}" | tail -1 ; 
elif [ $grep == "TRUE" ] ; then 
    echo $@
    eval "$line" | grep $grep_opt
elif [ $latex == "TRUE" ] ; then 
    eval $line > tmp
    FIRSTWORD=$(head -n1 tmp | awk '{print $1}')
#    echo $FIRSTWORD
    if [[ $FIRSTWORD == "krr" ]] || [[ $FIRSTWORD == "svm" ]] ; then 
        echo -n $(cat tmp)
        echo -en "\t&"
    else
        cat tmp | tail -n9 | head -n8  | awk '{print $2}'| tr "\n" "\t" | sed "s/\t$/\\\\\\\\ \n/" | sed "s/\t/ \&/g"
    fi
else 
    eval "$line" 
fi 
done < "${CONFIG_FILE}"
rm tmp
