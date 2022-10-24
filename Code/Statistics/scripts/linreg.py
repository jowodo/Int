#!/usr/bin/env python3

import numpy as np 
import pandas as pd
import dfply
from sklearn.linear_model import LinearRegression

print_influence=1
only_emma=1
y_index=3 # 2=G; 3=phd; 7=layers; 10=vCal 
infile="../db_final.tsv"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, names = names,delimiter="\t")
if only_emma:
    df = df >>dfply.mask(df.enr !=0)
data=np.array(df)
X=data[:,6:]
X_names=names[6:]
if (y_index == 10) : 
    y=data[:,y_index].reshape(len(data[:,y_index]),1)*60
else:           
    y=data[:,y_index].reshape(len(data[:,y_index]),1)
reg = LinearRegression().fit(X,y)
y_pred = reg.predict(X)
y_name = names[y_index]
print("Lin regression for", y_name, "\tOnly EMMA data used:", only_emma)
print("Reg score", reg.score(X,y))
print("Reg coef", X_names)
print("Reg coef", reg.coef_)
print("Reg intercept: ", reg.intercept_)

if print_influence:
    for i in range(6): 
        #print( "influence:",names[6+i], reg.coef_[6+i]*max(X[:,6+i]) ) 
        #print( "influence:",names[6+i], reg.coef_[0,i], reg.coef_[0,i]*max(X[:,i]) , sep="\t") 
        print( 
              names[6+i], 
              "coef:",
              reg.coef_[0,i], 
              "influence:",
              reg.coef_[0,i]*max(X[:,i]), 
              sep="\t") 

exit()

