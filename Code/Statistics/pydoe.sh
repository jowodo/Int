#!/usr/bin/env sh
[ -z "$1" ] && echo "USAGE: $0 <INTEGER>" && exit 
factors=$1
dirname=`mktemp -d`
#echo "This will take about 1 minutes"
python3 -m venv $dirname
source ${dirname}/bin/activate 
#set -x 
pip install --upgrade pip wheel > /dev/null
pip install pydoe > /dev/null
#set +x
python3 -c "import pyDOE as pd; print(pd.doe_plackett_burman.pbdesign($factors))"
deactivate
rm -rf $dirname
