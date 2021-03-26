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
tmax=20
ttmin =tmax                 # test minimum index
ttmax=25
trainx1 = conc[tmin:tmax].to_numpy()
trainx2 = layr[tmin:tmax].to_numpy()
trainy1 = G[tmin:tmax].to_numpy()
trainy2 = phd[tmin:tmax].to_numpy()
testx1 = conc[ttmin:ttmax].to_numpy()
testx2 = layr[ttmin:ttmax].to_numpy()
testy1 = G[ttmin:ttmax].to_numpy()
testy2 = phd[ttmin:ttmax].to_numpy()
#trainx = np.array([trainx1, trainx2 ]).reshape(20,2)
trainx = np.transpose( np.array([trainx1, trainx2 ]) )
testx = np.transpose( np.array([testx1, testx2 ]) )
trainy = trainy1    #.reshape(20,1)
testy = testy1    #.reshape(20,1)
#trainx1 =trainx1.to_numpy()
#print(trainx1)
#trainx1.reshape(np.array(trainx1),1)
#print(type(trainx1))
print(trainx.shape)
print(trainy.shape)

ML1 = skl.LinearSVR()
ML1.fit(trainx,trainy)
pred_testy = ML1.predict(testx)
print(np.array([ testy, pred_testy ] ) ) 

#print(df)
#print(phd)
#print(df.conc)
#print(df["nr"])
#print(df["conc"])
