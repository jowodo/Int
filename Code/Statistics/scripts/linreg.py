#!/usr/bin/env python3
#
import numpy as np 
import pandas as pd
import dfply
from dfply import mask
from sklearn.linear_model import LinearRegression
import argparse
#
# DEFINE MEAN SQUARED ERROR FUNCTION
def MSE(predicted,measured):
    pred=np.array(predicted)
    real=np.array(measured)
    mse=sum(np.square(pred-real))/len(pred)
    return mse
# DEFINE MEAN ABSOLUTE ERROR FUNCTION
def MAE(predicted,measured):
    pred=np.array(predicted)
    real=np.array(measured)
    mae=sum(np.absolute(pred-real))/len(pred)
    return mae
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
    df_all = df 
    df = df >> mask(df.enr !=0)
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
# PRE-EMMA DATASET
data_pre=np.array(df_all >> mask(df_all.enr == 0))
X_pre=data_pre[:,6:]
Y_pre=data_pre[:,[2,3,7,10]].reshape(len(data_pre[:,[2,3,7,10]]),4)
# PRE-EMMA DATASET WITHIN EMMA BOUNDARIES
data_inter=np.array( df_all>> mask(dfply.X.enr == 0) \
        >> mask(dfply.X.conc >1) \
        >> mask(dfply.X.layers >=4) \
        >> mask(dfply.X.vDOC >=10)\
        >> mask(dfply.X.TDOC >=40)\
        >> mask(dfply.X.vCal >=2) ) 
X_inter=data_inter[:,6:]
Y_inter=data_inter[:,[2,3,7,10]].reshape(len(data_inter[:,[2,3,7,10]]),4)
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
print("MAE: ",MAE(y_pred,y))
print("MSE: ",MSE(y_pred,y))
print("MAE(pre): ",MAE(reg.predict(X_pre),Y_pre))
print("MSE(pre): ",MSE(reg.predict(X_pre),Y_pre))
print("MAE(inter): ",MAE(reg.predict(X_inter),Y_inter))
print("MSE(inter): ",MSE(reg.predict(X_inter),Y_inter))
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
