#!/usr/bin/env python3

import numpy as np 
from sklearn.svm import SVR # Epsilon-support Vector Regression
#from sklearn.kernel_ridge import KernelRidge as KRR
import sklearn
import pandas as pd
import dfply
import argparse
#
# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Grid Search for hyper parameters')
parser.add_argument('-e', '--emma', dest ='only_emma',action ='store_true', help ='only use emma data')
parser.add_argument('-y', '--yindex', dest ='y_index',action ='store', choices={'2','3','7','10'}, default='2', help ='y to fit: 2=G; 3=phd; 7=layers; 10=vCal [default=2]')
args = parser.parse_args()
#
# DATA PRE-PROCESSING WITH 5-fold script 
def get_sets(df,names,args):
    data=np.array(df)
    X=data[:,6:]
    # MUTLIply by 60 bcs C/h instead of C/min
    X[4]=X[4]*60
    X_names=names[6:]
    Y=data[:,int(args.y_index)].reshape(-1)
    return X,Y
#
# DO CROSS FOLD VALIDATION SPLIT 
def cross_fold(X,Y,k,shuffle=True):
    train_min=0             # train minimum index
    train_max=int(len(df)/k*(k-1))
    test_min = train_max    # test  minimum index
    test_max=len(df)
    #
    # shuffle before cross validation
    if shuffle:
        X, Y = sklearn.utils.shuffle(X, Y, random_state=0)
    #
    X_train=X[train_min:train_max]
    X_test=X[test_min:test_max]
    Y_train=Y[train_min:train_max]
    Y_test=Y[test_min:test_max]
    return X_train,X_test,Y_train,Y_test
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
def get_MAE(y,ypred):
    return (np.average(np.absolute(y-ypred)))
#
#
# CHECK IF ONLY USE EMMA DATA
if args.only_emma:
    df = df >>dfply.mask(df.enr !=0)
#
#PREPROCESSING DATA 
X,Y=get_sets(df,names,args)
X_train,X_test,Y_train,Y_test=cross_fold(X,Y,5)
#
# NUMBER OF PARAMETERS: 1=G; 2=G+phd; 3=G+phd+vCal; 4=G+phd+vCal+layr
n=4
#
# KERNEL FOR KRR
kernel=["poly","rbf"]#,"sigmoid"]
# regularization parameter
C= np.array(range(1,20))*0.05
# DEGREE OF POLYNOMIAL; ignored by rest
degree=range(1,6)
# epsilon-tube size for no penalty; rather large 
epsilon= np.array(range(1,20))*0.2
# some kind of scaling factor; can be set to auto/scale, include into list? 
gamma=[0.0,0.1,1.0,10.0,"auto","scale"]
#param = {"kernel":kernel, "C":C, "degree":degree, "epsilon":epsilon, "gamma":gamma }
# temp short test
C=[1,0.1]; degree=[3]; epsilon=[1,2]; gamma=["scale"] # ,"auto"]

# HEADER LINE TO BE FILLED
#hline=""
#for nr in range(1,n+1):
#    hline=hline+ names[nr+7]+"MAE\t\t"+ names[nr+7]+"MAE/AVG\t"
print("%s MAE \tMAE/AVG" % names[int(args.y_index)])

#print(hline)
for k in kernel:
    for c in C:
        for d in degree:
            for e in epsilon:
                for g in gamma:
                    print("K:"+k+" C:"+str(c)+" d:"+str(d)+" e:"+str(e)+" g:"+str(g) ) 
                    line=""
                    varia=str(d)
                    ML = SVR(kernel='poly', C=0.1, degree=3, epsilon=0.1)
                    ML = SVR(kernel=k, C=c, degree=d, epsilon=e, gamma=g)
                    ML.fit(X_train,Y_train)
                    Y_test_pred = ML.predict(X_test)
                    line=f"{get_MAE(Y_test,Y_test_pred):.6f}"+"\t"+ f"{get_MAE(Y_test,Y_test_pred)/np.average(Y_test):.6f}"+"\t"
#                print(line+ k+ ",C="+f"{c:.1f}"+ ",deg="+str(d)+ ",e="+f"{e:.1f}" +"g="+f"{g:.1}")
                    print(line+ k+ ",C="+f"{c:.1f}"+ ",deg="+str(d)+ ",e="+f"{e:.1f}" +"g="+g)
