import math
import numpy as np 
import sklearn.svm  as skl
import pandas as pd

infile="stat.dat"
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = ["nr", "conc", "layr", "vDOC", "TDOC", "vCal" , "TCal", "nr2", "conductivity" , "phdensity", "layers", "Cal_vel"] )
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
#tmin=5 ; tmax = 30 ; ttmin = 0 ; ttmax = tmin
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

#trainx = np.array([trainx1, trainx2 ]).reshape(20,2)
trainx = np.transpose( np.array([trainx1, trainx2 , trainx3, trainx4, trainx5, trainx6]) )
testx = np.transpose( np.array([testx1, testx2, testx3, testx4, testx5, testx6 ]) )
trainy = trainy4    #.reshape(20,1)
testy  =  testy4    #.reshape(20,1)
#trainx1 =trainx1.to_numpy()
#print(trainx1)
#trainx1.reshape(np.array(trainx1),1)
#print(type(trainx1))
#print(trainx.shape)
#print(trainy.shape)

#ML1 = skl.LinearSVR()
ML1 = skl.SVR(kernel='poly')
ML1.fit(trainx,trainy)
pred_testy = ML1.predict(testx)
print(np.array([ testy, pred_testy ] ) ) 

#print(df)
#print(phd)
#print(df.conc)
#print(df["nr"])
#print(df["conc"])
