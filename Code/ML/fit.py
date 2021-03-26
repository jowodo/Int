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
trainx2 = layr[tmin:tmax]
trainy1 = G[tmin:tmax]
trainy2 = phd[tmin:tmax]
testx1 = conc[ttmin:ttmax]
testx2 = layr[ttmin:ttmax]
testy1 = G[ttmin:ttmax]
testy2 = phd[ttmin:ttmax]
trainx = np.array([trainx1, trainx2 ])
#trainx1 =trainx1.to_numpy()
print(trainx1)
trainx1.reshape(np.array(trainx1),1)
print(trainx1.shape())

ML1 = skl.LinearSVR()
#ML1.fit(trainx,trainy1)

#print(df)
#print(phd)
#print(df.conc)
#print(df["nr"])
#print(df["conc"])
