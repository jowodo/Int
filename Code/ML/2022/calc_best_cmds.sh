#!/bin/bash
echo krr poly -d 1 a2.00 g0.01 
./krr_pred.py -y 3 -k poly -d 1 -a2.00 -g0.01  --stat 
echo krr poly -d 2 a2.00 g0.01 
./krr_pred.py -y 3 -k poly -d 2 -a2.00 -g0.01  --stat 
echo krr poly -d 3 a2.00 g0.01 
./krr_pred.py -y 3 -k poly -d 3 -a2.00 -g0.01  --stat 
echo krr rbf  a2.00 g0.01 
./krr_pred.py -y 3 -k rbf  -a2.00 -g0.01  --stat 
echo krr sigmoid  a2.00 g0.02 
./krr_pred.py -y 3 -k sigmoid  -a2.00 -g0.02  --stat 
echo krr poly -d 1 a10.00 g0.2 
./krr_pred.py -y 2 -k poly -d 1 -a10.00 -g0.2  --stat 
echo krr poly -d 2 a10.00 g0.2 
./krr_pred.py -y 2 -k poly -d 2 -a10.00 -g0.2  --stat 
echo krr poly -d 3 a10.00 g0.2 
./krr_pred.py -y 2 -k poly -d 3 -a10.00 -g0.2  --stat 
echo krr rbf  a10.00 g0.2 
./krr_pred.py -y 2 -k rbf  -a10.00 -g0.2  --stat 
echo krr sigmoid  a10.00 g0.2 
./krr_pred.py -y 2 -k sigmoid  -a10.00 -g0.2  --stat 
echo svm poly -d 1 C0.8 e0.9 -g0.2
./svm_pred.py -y 3 -k poly -d 1 -C0.8 -e0.9 -g0.2 --stat 
echo svm poly -d 2 C0.7 e1.0 -g0.5
./svm_pred.py -y 3 -k poly -d 2 -C0.7 -e1.0 -g0.5 --stat 
echo svm poly -d 3 C0.1 e0.1 -g0.5
./svm_pred.py -y 3 -k poly -d 3 -C0.1 -e0.1 -g0.5 --stat 
echo svm rbf  C1.0 e1.0 -gscale
./svm_pred.py -y 3 -k rbf  -C1.0 -e1.0 -gscale --stat 
echo svm sigmoid  C1.0 e1.0 -gscale
./svm_pred.py -y 3 -k sigmoid  -C1.0 -e1.0 -gscale --stat 
echo svm poly -d 1 C0.3 e0.1 -g0.01
./svm_pred.py -y 2 -k poly -d 1 -C0.3 -e0.1 -g0.01 --stat 
echo svm poly -d 2 C0.1 e0.1 -g0.01
./svm_pred.py -y 2 -k poly -d 2 -C0.1 -e0.1 -g0.01 --stat 
echo svm poly -d 3 C0.1 e0.1 -g0.01
./svm_pred.py -y 2 -k poly -d 3 -C0.1 -e0.1 -g0.01 --stat 
echo svm rbf  C1.0 e1.0 -gscale
./svm_pred.py -y 2 -k rbf  -C1.0 -e1.0 -gscale --stat 
echo svm sigmoid  C1.0 e1.0 -gscale
./svm_pred.py -y 2 -k sigmoid  -C1.0 -e1.0 -gscale --stat 
