#!/usr/bin/env python3

import numpy as np 
from simport SVR # Epsilon-support Vector Regression
from sklearn.kernel_ridge import KernelRidge as KRR
from sklearn.utils import shuffle
import pandas as pd
import dfply

# INPUT FILE
infile = "../db_final.tsv"
# HEADER
names = ["nr", "enr", "G", "phd", "avg1G", "avg2G", "conc", "layr", "vDOC", "TDOC", "vCal", "TCal" ]
names_short = ["nr", "enr", "G", "phd", "conc", "layr", "vDOC", "TDOC", "vCal", "TCal" ]
# LOAD FILE
dat = pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
# FILTER DATA FRAME
df = dat >> dfply.drop("avg1G", "avg2G") >> dfply.mask(df.enr > 300)

# GET MEAN AVERAGE ERROR 
def get_MAE(y,ypred):
    return (np.average(np.absolute(y-ypred)))
# K-FOLD CROSS VALIDATION
def get_sets(df,nr,kfold):
    # DEFINITIONS
    conc = df.conc
    layr = df.layr
    vDoc = df.vDOC
    TDoc = df.TDOC
    vCal = df.vCal
    TCal = df.TCal
    G = df.G
    phd = df.phd
    
    # NUMBER OF DATA POINTS
    ndatapoints=len(conc)
    tmin=0                      # train minimum index
    tmax=int(ndatapoints*(kfold-1)/kfold)
    ttmin = tmax                   # test  minimum index
    ttmax=ndatapoints

    # SPLIT DATA IN TRAINING AND TEST
    # DEFINE TRAINING SET
    trainx1 = conc[tmin:tmax].to_numpy()
    trainx2 = layr[tmin:tmax].to_numpy()
    trainx3 = vDoc[tmin:tmax].to_numpy()
    trainx4 = TDoc[tmin:tmax].to_numpy()
    trainx5 = vCal[tmin:tmax].to_numpy()
    trainx6 = TCal[tmin:tmax].to_numpy()
    trainy1 = G[tmin:tmax].to_numpy()
    trainy2 = phd[tmin:tmax].to_numpy()
    trainy3 = layr[tmin:tmax].to_numpy()
    trainy4 = vCal[tmin:tmax].to_numpy()/60

    # DEFINE VALIDATION SET
    testx1 = conc[ttmin:ttmax].to_numpy()
    testx2 = layr[ttmin:ttmax].to_numpy()
    testx3 = vDoc[ttmin:ttmax].to_numpy()
    testx4 = TDoc[ttmin:ttmax].to_numpy()
    testx5 = vCal[ttmin:ttmax].to_numpy()
    testx6 = TCal[ttmin:ttmax].to_numpy()
    testy1 = G[ttmin:ttmax].to_numpy()
    testy2 = phd[ttmin:ttmax].to_numpy()
    testy3 = layr[ttmin:ttmax].to_numpy()
    testy4 = vCal[ttmin:ttmax].to_numpy()/60

    # DEFINE TRAINING INPUTS
    trainx = np.transpose( np.array([trainx1, trainx2 , trainx3, trainx4, trainx5, trainx6]) )
    # DEFINE VALIDATION INPUTS
    testx = np.transpose( np.array([testx1, testx2, testx3, testx4, testx5, testx6 ]) )
#    y_col = 7+nr
#    trainy = df.get(names[y_col])[tmin:tmax].to_numpy()
#    testy  = df.get(names[y_col])[ttmin:ttmax].to_numpy()
    # DEFINE TRAINING OUTPUTS
    trainy = np.transpose( np.array([trainy1, trainy2 , trainy3, trainy4]) )
    # DEFINE VALIDATION OUTPUTS
    testy = np.transpose( np.array([testy1, testy2, testy3, testy4]) )
    return trainx,testx,trainy,testy

n = 4 
line=""
hline=""
kfold = 5 # splits for cross validation; i.e. n training and 1 validation

# INITAIALZE GRID SEARCH 
# DIFFERENT KERNELS 
kernel=["poly","rbf"]#,"sigmoid"]
# WAS IS C? 
C= np.array(range(1,20))*0.05
# DEGREE OF POLYNOMIAL
degree=range(1,6)
# WHAT IS EPSILON
epsilon= np.array(range(1,20))*0.2
# WHAT IS GAMMA 
gamma=[0.0,0.1,1.0,10.0]
#param = {"kernel":kernel, "C":C, "degree":degree, "epsilon":epsilon, "gamma":gamma }
C=[1,0.1]; degree=[3]; epsilon=[1,2]; gamma=['scale']

#for nr in range(1,n+1):
#    hline=hline+ names[nr+7]+"MAE\t"+ names[nr+7]+"MAE/AVG\t"
#print(hline)

# FOR EACH DEPENDENT VARIABLE 

for g in gamma:
    for k in kernel:
        for c in C:
            for d in degree:
                for e in epsilon:
                    line=""
                    # for earch dependent variable 
                    for nr in range(1,n+1):
                        varia=str(d)
                        trainx,testx,trainy,testy = get_sets(df,nr,kfold)
#                        ML = SVR(kernel='poly', C=0.1, degree=3, epsilon=0.1)
                        ML = SVR(kernel=k, C=c, degree=d, epsilon=e)
                        ML.fit(trainx,trainy)
                        pred_testy = ML.predict(testx)
                        line=line+ f"{get_MAE(testy,pred_testy):.6f}"+"\t"+ f"{get_MAE(testy,pred_testy)/np.average(testy):.6f}"+"\t"
                        hline=hline+ names[nr+7]+"MAE\t"+ names[nr+7]+"MAE/AVG\t"
                print(line+ k+ ",C="+f"{c:.1f}"+ ",deg="+str(d)+ ",e="+f"{e:.1f}" +"g="+f"{g:.1}")

