import math
import numpy as np 
#import sklearn.svm  as skl
from sklearn.svm import SVR
from sklearn.kernel_ridge import KernelRidge as KRR
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline
from sklearn.utils import shuffle
import pandas as pd

infile="stat2.dat"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
df= shuffle(df)
def get_MAE(y,ypred):
    return (np.average(np.absolute(y-ypred)))
def get_sets(df,nr):
    names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
    df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
    conc = df.conc
    layr = df.layers
    vDoc = df.vDOC
    TDoc = df.TDOC
    vCal = df.vCal
    TCal = df.TCal
    G = df.conductivity
    phd = df.phdensity
    layers = df.layers
    Cal_vel = df.vCal
    
    ndatapoints=len(conc)
    tmin=0                      # train minimum index
    tmax=int(ndatapoints*4/5)
    ttmin = tmax                   # test  minimum index
    ttmax=ndatapoints
    

    trainx1 = conc[tmin:tmax].to_numpy()
    trainx2 = layr[tmin:tmax].to_numpy()
    trainx3 = vDoc[tmin:tmax].to_numpy()
    trainx4 = TDoc[tmin:tmax].to_numpy()
    trainx5 = vCal[tmin:tmax].to_numpy()*60
    trainx6 = TCal[tmin:tmax].to_numpy()
    trainy1 = G[tmin:tmax].to_numpy()
    trainy2 = phd[tmin:tmax].to_numpy()
    trainy3 = layr[tmin:tmax].to_numpy()
    trainy4 = vCal[tmin:tmax].to_numpy()

    testx1 = conc[ttmin:ttmax].to_numpy()
    testx2 = layr[ttmin:ttmax].to_numpy()
    testx3 = vDoc[ttmin:ttmax].to_numpy()
    testx4 = TDoc[ttmin:ttmax].to_numpy()
    testx5 = vCal[ttmin:ttmax].to_numpy()*60
    testx6 = TCal[ttmin:ttmax].to_numpy()
    testy1 = G[ttmin:ttmax].to_numpy()
    testy2 = phd[ttmin:ttmax].to_numpy()
    testy3 = layr[ttmin:ttmax].to_numpy()
    testy4 = vCal[ttmin:ttmax].to_numpy()

    trainx = np.transpose( np.array([trainx1, trainx2 , trainx3, trainx4, trainx5, trainx6]) )
    testx = np.transpose( np.array([testx1, testx2, testx3, testx4, testx5, testx6 ]) )
    y_col=7+nr
    trainy = df.get(names[y_col])[tmin:tmax].to_numpy()
    testy  = df.get(names[y_col])[ttmin:ttmax].to_numpy()
    return trainx,testx,trainy,testy

n=4
line=""
hline=""

kernel=["poly","rbf"]#,"sigmoid"]
C= np.array(range(1,20))*0.005
degree=range(1,6)
epsilon= np.array(range(1,20))*0.2
gamma=[0.0,0.1,1.0,10.0]
#kernel=["poly"]; C=[0.01]; degree=[3]; epsilon=[1]; gamma=[0.1]

for nr in range(1,n+1):
    hline=hline+ names[nr+7]+"MAE\t"+ names[nr+7]+"MAE/AVG\t"
print(hline)
for g in gamma:
    for k in kernel:
        for c in C:
            for d in degree:
                for e in epsilon:
                    line=""
                    for nr in range(1,n+1):
                        varia=str(d)
                        trainx,testx,trainy,testy = get_sets(df,nr)
                        pipe = make_pipeline(StandardScaler(), SVR(kernel=k, C=c, degree=d, epsilon=e))
                        #ML = SVR(kernel=k, C=c, degree=d, epsilon=e)
                        #ML.fit(trainx,trainy)
                        pipe.fit(trainx,trainy)
                        pred_testy = pipe.predict(testx)
                        line=line+ f"{get_MAE(testy,pred_testy):.6f}"+"\t"+ f"{get_MAE(testy,pred_testy)/np.average(testy):.6f}"+"\t"
#                        line = line + str(pipe.score(testx,testy))
                        hline=hline+ names[nr+7]+"MAE\t"+ names[nr+7]+"MAE/AVG\t"
                print(line+ k+ ",C="+f"{c:.1f}"+ ",deg="+str(d)+ ",e="+f"{e:.1f}" +",g="+f"{g:.1}")


#print(hline)
print(line)
