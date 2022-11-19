#!/usr/bin/env python3
#
import numpy as np 
import pandas as pd
import dfply
from sklearn.linear_model import LinearRegression
import argparse
#
# DEFINE MEAN SQUARED ERROR FUNCTION
def MSE(predicted,measured):
    pred=np.array(predicted)
    real=np.array(measured)
    mse=np.square(pred-real).mean()
    return mse
#
# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Search some files')
parser.add_argument('-i', '--influence',dest ='print_influence',action ='store_true', help ='print influence')
parser.add_argument('-e', '--emma', dest ='only_emma',action ='store_true', help ='only use emma data')
parser.add_argument('-y', '--yindex', dest ='y_index',action ='store', choices={'0','2','3','7','10'}, default='0', help ='y to fit: 0=all; 2=G; 3=phd; 7=layers; 10=vCal [default=0]')
args = parser.parse_args()
#
#LOAD DATA FROM FILE 
infile="../db_final.tsv"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, names = names, delimiter="\t")
#
# CHECK IF ONLY USE EMMA DATA
if args.only_emma:
    df = df >>dfply.mask(df.enr !=0)
#
# DATA PREPROCESSING
data=np.array(df)
X=data[:,6:]
# MUTLIply by 60 bcs C/h instead of C/min
X[4]=X[4]*60
X_names=names[6:]
if (int(args.y_index) == 0):
    y=data[:,[2,3,7,10]].reshape(len(data[:,[2,3,7,10]]),4)
else:           
    y=data[:,int(args.y_index)].reshape(len(data[:,int(args.y_index)]),1)
#
# DO LINEAR REGRESSION
reg = LinearRegression().fit(X,y)
y_pred = reg.predict(X)
#
# PRINT OUTPUT
if args.y_index == 0: 
    y_name = "all"
else: 
    y_name = names[int(args.y_index)]
if args.only_emma:
    print("Lin regression for", y_name, "\tOnly EMMA data used:", args.only_emma)
else:
    print("Lin regression for", y_name)
#    
print("Reg score", reg.score(X,y))
#print("Reg coef", X_names)
#print("Reg coef", reg.coef_)
#print("Reg intercept: ", reg.intercept_)
print("MSE: ",MSE(y_pred,y))
#
# PRINT NICELY FORMATTED: 
if (int(args.y_index) == 0):
    j=0
    for i in [2,3,7,10]:
        print(names[i],"= ", sep="",end="")
        for i in range(6):
            print("%.2g*" % reg.coef_[j,i], sep="", end="")
            print("%s + " % X_names[i], sep="", end="") 
        print("%.2g" % reg.intercept_[j])
        j+=1 
else:
    print(y_name,"= ", sep="",end="")
    for i in range(6):
        print("%.2g*" % reg.coef_[0,i], sep="", end="")
        print("%s + " % X_names[i], sep="", end="") 
    print("%.2g" % reg.intercept_)
#
# PRINT INFLUCENCE
if args.print_influence:
    print("INFLUCENCE = reg.coeff * max(x_i) / max(y_i)")
    for i in range(6): 
        print( 
              names[6+i], 
              "coef:",
              reg.coef_[0,i], 
              "influence:",
              reg.coef_[0,i]*max(X[:,i])/max(y[:,0]), 
              sep="\t") 
#
exit()
