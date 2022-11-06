#!/usr/bin/env python3

import numpy as np 
import pandas as pd
import dfply
from sklearn.linear_model import LinearRegression
import argparse

parser = argparse.ArgumentParser(description ='Search some files')
parser.add_argument('-i', '--influence',dest ='print_influence',action ='store_true', help ='print influence')
parser.add_argument('-e', '--emma', dest ='only_emma',action ='store_true', help ='only use emma data')
parser.add_argument('-y', '--yindex', dest ='y_index',action ='store', choices={'0','2','3','7','10'}, default='0', help ='y to fit: 0=all; 2=G; 3=phd; 7=layers; 10=vCal [default=0]')
args = parser.parse_args()

infile="../db_final.tsv"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
#
def MSE(predicted,measured):
    pred=np.array(predicted)
    real=np.array(measured)
    mse=np.square(pred-real).mean()
    return mse
#
df=pd.read_csv(infile, skiprows=1, names = names,delimiter="\t")
if args.only_emma:
    df = df >>dfply.mask(df.enr !=0)
data=np.array(df)
X=data[:,6:]
X[4]=X[4]*60
X_names=names[6:]
if (int(args.y_index) == 0):
    y=data[:,[2,3,7,10]].reshape(len(data[:,[2,3,7,10]]),4)
#elif (int(args.y_index) == 10) : 
#    y=data[:,int(args.y_index)].reshape(len(data[:,int(args.y_index)]),1)*60
else:           
    y=data[:,int(args.y_index)].reshape(len(data[:,int(args.y_index)]),1)
# try all Y
#print(y)
#exit()

reg = LinearRegression().fit(X,y)
y_pred = reg.predict(X)
if args.y_index == 0: 
    y_name = "all"
else: 
    y_name = names[int(args.y_index)]
#
if args.only_emma:
    print("Lin regression for", y_name, "\tOnly EMMA data used:", args.only_emma)
else:
    print("Lin regression for", y_name)
#    
print("Reg score", reg.score(X,y))
print("Reg coef", X_names)
print("Reg coef", reg.coef_)
print("Reg intercept: ", reg.intercept_)
print("MSE: ",MSE(y_pred,y))

if args.print_influence:
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

