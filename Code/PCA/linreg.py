import math
import numpy as np 
import pandas as pd
from sklearn.linear_model import LinearRegression

infile="db_final.dat"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, names = names)
data=np.array(df)
X=data[:,6:]
X_names=names[6:]
y=data[:,2].reshape(len(data[:,2]),1)
#y=data[:,3].reshape(len(data[:,3]),1)
newdata=np.concatenate((X,y),1)
reg = LinearRegression().fit(X,y)
y_pred = reg.predict(X)
print("Reg score", reg.score(X,y))
print("Reg coef", reg.coef_)
#print(X_names)
#print(y)
#print(y_pred)
#print(y-y_pred)
exit()


