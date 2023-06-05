#!/usr/bin/env python3

import numpy as np 
import pandas as pd
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression

# DATA PREPARATION
y_index=2 # 2=G; 3=phd; 7=layers; 10=vCal 
infile="../db_final.tsv"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, names = names,delimiter="\t")
data=np.array(df)
X=data[:,6:]
X_names=names[6:]
if (y_index == 10) : 
    y=data[:,y_index].reshape(len(data[:,y_index]),1)*60
else:           
    y=data[:,y_index].reshape(len(data[:,y_index]),1)

#REGRESSION 
poly_reg=PolynomialFeatures(interaction_only=True)
X_poly=poly_reg.fit_transform(X)
reg = LinearRegression().fit(X_poly,y)
poly_reg.fit(X_poly,y)
y_pred = reg.predict(X_poly)
y_name = names[y_index]

print("Lin regression for", y_name)
print("Reg score", reg.score(X_poly,y))
print("Reg coef", X_names)
print("Reg coef", reg.coef_)
print("Reg intercept: ", reg.intercept_)
exit()

