#!/usr/bin/env bash

[ -z "$1" ] && echo "Please call this script with an INSTALLATION DIR (e.g. bash $0 ~/Documents/mypyvenv)" && exit 1
PREFIX="$1"

python3 -m venv $PREFIX 
source $PREFXI/bin/activate 
pip install --update pip 
pip install wheel 
pip install numpy pandas sklearn dfply
