#!/bin/bash
echo krr g poly -d 1 a10.00 g0.01 
./krr_pred.py -x -y 2 -k poly -d 1 -a10.00 -g0.01  --stat 
echo krr p rbf  a2.00 g0.01 
./krr_pred.py -x -y 3 -k rbf  -a2.00 -g0.01  --stat 
echo svm g poly -d 1 C0.7 e0.1 -g0.01
./svm_pred.py -x -y 2 -k poly -d 1 -C0.7 -e0.1 -g0.01 --stat 
echo svm p poly -d 1 C0.1 e0.1 -gscale
./svm_pred.py -x -y 3 -k poly -d 1 -C0.1 -e0.1 -gscale --stat 
