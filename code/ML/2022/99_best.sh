#!/bin/bash 
echo "PRINT BEST G/phd FOR EACH ML method "

# KKR best G unscaled
./krr_pred.py         -k sigmoid -a 0.01 -g 0.01 -t | head -1
./krr_pred.py         -k sigmoid -a 0.01 -g 0.01 -t | tail -1
# KKR best G scaled
./krr_pred.py      -x -d 1       -a 0.01 -g 0.01 -t | head -1 
./krr_pred.py      -x -d 1       -a 0.01 -g 0.01 -t | tail -1
# KKR best phd unscaled
./krr_pred.py -y 3    -k rbf     -a 0.01 -g 0.01 -t | head -1
./krr_pred.py -y 3    -k rbf     -a 0.01 -g 0.01 -t | tail -1
# KKR best phd scaled
./krr_pred.py -y 3 -x -k rbf     -a 0.01 -g 0.01 -t | head -1
./krr_pred.py -y 3    -k rbf     -a 0.01 -g 0.01 -t | tail -1

# SVM best G unscaled
./svm_pred.py         -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | head -1
./svm_pred.py         -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | tail -1
# SVM best G scaled
./svm_pred.py      -x -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | head -1
./svm_pred.py      -x -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | tail -1
# SVM best phd unscaled
./svm_pred.py -y 3    -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | head -1
./svm_pred.py -y 3    -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | tail -1
# SVM best phd scaled
./svm_pred.py -y 3 -x -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | head -1
./svm_pred.py -y 3 -x -k sigmoid -C 0.1 -e 0.2 -g 0.01 -t | tail -1
./svm_pred.py -y 3 -x -d 3       -C 0.1 -e 0.6 -g 0.01 -t | head -1
./svm_pred.py -y 3 -x -d 3       -C 0.1 -e 0.6 -g 0.01 -t | tail -1
