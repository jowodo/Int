#!/usr/bin/env python3

import numpy as np 
from sklearn.svm import SVR # Epsilon-support Vector Regression
#from sklearn.kernel_ridge import KernelRidge as KRR
import sklearn
import pandas as pd
import dfply
import argparse
#
# KERNEL FOR SVM
kernel=["poly","rbf","sigmoid"]
# regularization parameter
C= np.array(range(1,20))*0.05
# DEGREE OF POLYNOMIAL; ignored by rest
degree=range(1,3)
# epsilon-tube size for no penalty; rather large 
epsilon= np.array(range(1,20))*0.2
# some kind of scaling factor; can be set to auto/scale, include into list? 
gamma=[0.01, 0.05, 0.1, 0.5, 1.0, 5, 10, "scale"]
#
# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Grid Search for hyper parameters')
parser.add_argument('-e', '--emma', dest ='only_emma',action ='store_true', help ='only use emma data')
parser.add_argument('-y', '--yindex', dest ='y_index',action ='store', choices={'2','3','7','10'}, default='2', help ='y to fit: 2=G; 3=phd; 7=layers; 10=vCal [default=2]')
parser.add_argument('-m', '--maxiter', dest ='maxiter',action ='store', default='10000', help ='Hard limit on itermations within solver, default: 10000, use -1 for unlimited') 
parser.add_argument('-t', '--test', dest ='test',action ='store_true', help ='Test: Only use subset of hyperparameters') 
args = parser.parse_args()
#
# DATA PRE-PROCESSING WITH 5-fold script 
def get_sets(df,names,args):
    data=np.array(df)
    X=data[:,6:]
    # MUTLIply by 60 bcs C/h instead of C/min
    X[:,4]=X[:,4]*60
    X_names=names[6:]
    Y=data[:,int(args.y_index)].reshape(-1)
    return X,Y
# DO CROSS FOLD VALIDATION SPLIT 
def cross_fold(X,Y,k,shuffle=True):
    train_min=0             # train minimum index
    train_max=int(len(df)/k*(k-1))
    test_min = train_max    # test  minimum index
    test_max=len(df)
    # shuffle before cross validation
    if shuffle:
        X, Y = sklearn.utils.shuffle(X, Y, random_state=0)
    X_train=X[train_min:train_max]
    X_test=X[test_min:test_max]
    Y_train=Y[train_min:train_max]
    Y_test=Y[test_min:test_max]
    return X_train,X_test,Y_train,Y_test
# MEAN AVERAGE ERROR
def get_MAE(y,ypred):
    return np.average(np.absolute(y-ypred))
# MEAN SQUARED ERROR 
def get_MSE(y,ypred):
    return np.average((y-ypred)*(y-ypred))
# VARIANCE sigma^2
def get_var(y):
    yavg=np.average(y)
    return sum((y-yavg)*(y-yavg))/(len(y)-1)
#
#LOAD DATA FROM FILE 
infile="../../Statistics/db_final.tsv"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
#         0     1       2               3           4          5          6       7        8        9       10      11 
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
# FILTER OUT NON EMMA SAMPLES
if args.only_emma:
    df = df >>dfply.mask(df.enr !=0)
#
#PREPROCESSING DATA 
X,Y=get_sets(df,names,args)
X_train,X_test,Y_train,Y_test=cross_fold(X,Y,5)
#
# temp short test
if args.test : 
    C=[0.5,0.1]; degree=[1,2]; epsilon=[1,2]; gamma=["scale",0.1] # ,"auto"]
n_exps=len(C)*(len(degree)+len(kernel)-1)*len(epsilon)*len(gamma)

# HEADER LINE 
print("%s MAE \tMSE \tVAR \tVAR_pred" % names[int(args.y_index)])
i=1
#print(hline)
for k in kernel:
    if k=="poly":
        for d in degree:
            for c in C:
                for e in epsilon:
                    for g in gamma:
                        line=""
                        ML = SVR(kernel=k, C=c, degree=d, epsilon=e, gamma=g, max_iter=int(args.maxiter))
                        ML.fit(X_train,Y_train)
                        Y_test_pred = ML.predict(X_test)
#                        line=f"{get_MAE(Y_test,Y_test_pred):.6f}"+"\t"+ f"{get_MAE(Y_test,Y_test_pred)/np.average(Y_test):.6f}"+"\t"
                        line=f"{get_MAE(Y_test,Y_test_pred):.2f}"+"\t"+ f"{get_MSE(Y_test,Y_test_pred):.2f}"+"\t"+f"{get_var(Y_test):.2f}"+"\t"+f"{get_var(Y_test_pred):.2f}"+"\t"
                        print(line+ k+ 
                              "\tdeg="+str(d)+ 
                              "\tC="+f"{c:.1f}"+ 
                              "\te="+f"{e:.1f}"+
                              "\tg="+str(g)+ 
                              "\t"+str(i)+"/"+str(n_exps), 
                              flush=True)
                        i+=1
    else:
        for c in C:
            for e in epsilon:
                for g in gamma:
                    line=""
                    ML = SVR(kernel=k, C=c, degree=d, epsilon=e, gamma=g, max_iter=int(args.maxiter))
                    ML.fit(X_train,Y_train)
                    Y_test_pred = ML.predict(X_test)
#                    line=f"{get_MAE(Y_test,Y_test_pred):.6f}"+"\t"+ f"{get_MAE(Y_test,Y_test_pred)/np.average(Y_test):.6f}"+"\t"
                    line=f"{get_MAE(Y_test,Y_test_pred):.2f}"+"\t"+ f"{get_MSE(Y_test,Y_test_pred):.2f}"+"\t"+f"{get_var(Y_test):.2f}"+"\t"+f"{get_var(Y_test_pred):.2f}"+"\t"
                    print(line+ k+ 
                          "\tdeg="+str(0)+ 
                          "\tC="+f"{c:.1f}"+ 
                          "\te="+f"{e:.1f}"+
                          "\tg="+str(g)+ 
                          "\t"+str(i)+"/"+str(n_exps), 
                          flush=True)
                    i+=1
