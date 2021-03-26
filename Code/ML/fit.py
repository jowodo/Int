import math
import numpy as np 
import sklearn  as skl
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
print(df)
#print(phd)
#print(df.conc)
#print(df["nr"])
#print(df["conc"])
