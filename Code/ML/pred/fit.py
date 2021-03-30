import math
import numpy as np 
#import sklearn.svm  as skl
from sklearn.svm import SVR
import pandas as pd

infile="../stat.dat"
xspace="xspace.dat"
names = ["nr", "conc", "layr", "vDOC", "TDOC", "vCal", "TCal", "nr2", "conductivity" , "phdensity", "layers", "Cal_vel"] 
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
namesx = ["nr","conc","layr","vDOC","TDOC","vCal","TCal"]
df2=pd.read_csv(xspace, skiprows=1, delim_whitespace=True, names = namesx)
def get_MAE(y,ypred):
    return (np.average(np.absolute(y-ypred)))
def get_sets(df,nr):
    names = ["nr", "conc", "layr", "vDOC", "TDOC", "vCal", "TCal", "nr2", "conductivity" , "phdensity", "layers", "Cal_vel"] 
    conc = df.conc
    layr = df.layr
    vDoc = df.vDOC
    TDoc = df.TDOC
    vCal = df.vCal
    TCal = df.TCal
    G = df.conductivity
    phd = df.phdensity
    layers = df.layers
    Cal_vel = df.Cal_vel
    
    tmin=0                      # train minimum index
    tmax=30

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

    trainx = np.transpose( np.array([trainx1, trainx2 , trainx3, trainx4, trainx5, trainx6]) )
    y_col=7+nr
    trainy = df.get(names[y_col])[tmin:tmax].to_numpy()
    return trainx,trainy
def get_x(df):
    namesx = ["nr","conc","layr","vDOC","TDOC","vCal","TCal"]
    testx1 = df.conc.to_numpy()
    testx2 = df.layr.to_numpy()
    testx3 = df.vDOC.to_numpy()
    testx4 = df.TDOC.to_numpy()
    testx5 = df.vCal.to_numpy()
    testx6 = df.TCal.to_numpy()
    testx  = np.transpose( np.array([testx1, testx2, testx3, testx4, testx5, testx6]) )
    return testx

nr=1
k="poly"
c=0.1
d=3
e=2
trainx,trainy=get_sets(df,nr)
testx=get_x(df2)
ML = SVR(kernel=k, C=c, degree=d, epsilon=e)
ML.fit(trainx,trainy)
pred = ML.predict(testx)
print(names[nr+7])
for p in pred: 
    print (f"{p:.5f}")
