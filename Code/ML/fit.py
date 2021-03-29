import math
import numpy as np 
#import sklearn.svm  as skl
from sklearn.svm import SVR
from sklearn.kernel_ridge import KernelRidge as KRR
import pandas as pd

infile="stat.dat"
names = ["nr", "conc", "layr", "vDOC", "TDOC", "vCal", "TCal", "nr2", "conductivity" , "phdensity", "layers", "Cal_vel"] 
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
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
    tmax=25
    ttmin = tmax                   # test  minimum index
    ttmax=30

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

    trainx = np.transpose( np.array([trainx1, trainx2 , trainx3, trainx4, trainx5, trainx6]) )
    testx = np.transpose( np.array([testx1, testx2, testx3, testx4, testx5, testx6 ]) )
    y_col=7+nr
    trainy = df.get(names[y_col])[tmin:tmax].to_numpy()
    testy  = df.get(names[y_col])[ttmin:ttmax].to_numpy()
    return trainx,testx,trainy,testy

n=4
line=""
hline=""
for nr in range(1,4+1):
    trainx,testx,trainy,testy = get_sets(df,nr)
    #ML = skl.LinearSVR()
    ML = SVR(kernel='poly', C=1, degree=3, epsilon=4.4)
    ML.fit(trainx,trainy)
    pred_testy = ML.predict(testx)
#    print(np.array([ testy, pred_testy ] ) ) 
#    line=line+ str(get_MAE(testy,pred_testy))+"\t"+ str(get_MAE(testy,pred_testy)/np.average(testy))+"\t"
    line=line+ f"{get_MAE(testy,pred_testy):.6f}"+"\t"+ f"{get_MAE(testy,pred_testy)/np.average(testy):.6f}"+"\t"
    hline=hline+ names[nr+7]+"MAE\t"+ names[nr+7]+"MAE/AVG\t"
#    print( names[nr+7], get_MAE(testy,pred_testy), get_MAE(testy,pred_testy)/np.average(testy), sep="\t")
#    print( names[nr+7], ML.support_vectors_, sep="\t")


#print(hline)
print(line)
