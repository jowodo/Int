#!/usr/bin/env python3
#
import numpy as np 
import pandas as pd
import dfply
from dfply import mask
from sklearn.linear_model import LinearRegression
import argparse
#
# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Linear regression with EMMA data and test with EMMA, pre-EMMA, pre-EMMA-intra and complete datasets')
parser.add_argument('-a', '--all',dest ='print_all',action ='store_true', help ='print alls statistics')
parser.add_argument('-i', '--influence',dest ='print_influence',action ='store_true', help ='print influence')
parser.add_argument('-m', '--mse',dest ='print_mse',action ='store_true', help ='print MSE and MAE')
#parser.add_argument('-p', '--predict',dest ='predict',action ='store_true', help ='predict Y values')
parser.add_argument('--pa',dest ='pred_all',action ='store_true', help ='predict Y values with complete dataset')
parser.add_argument('--pe',dest ='pred_emma',action ='store_true', help ='predict Y values with EMMA dataset')
parser.add_argument('--pi',dest ='pred_intra',action ='store_true', help ='predict Y values with pre-EMMA-intra dataset')
parser.add_argument('--pp',dest ='pred_pre',action ='store_true', help ='predict Y values with pre-EMMA dataset')
parser.add_argument('--fe',dest ='fit_emma',action='store_true', help='fit with EMMA dataset [default]')
parser.add_argument('--fa',dest ='fit_all',action='store_true', help='fit with complete dataset')
parser.add_argument('-r', '--regresssion',dest ='print_reg',action ='store_true', help ='print regression functions')
parser.add_argument('-y', '--yindex', dest ='y_index',action ='store', choices={'0','2','3','7','10'}, default='0', help ='y to fit: 0=all; 2=G; 3=phd; 7=layers; 10=vCal [default=0]')
args = parser.parse_args()
if args.print_all: 
    args.print_influence=True
    args.print_mse=True
    args.print_reg=True
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
# GET Y FROM DATA
def get_y(data, y_index):
    if (int(args.y_index) == 0):
        y=data[:,[2,3,7,10]].reshape(len(data[:,[2,3,7,10]]),4)
    else:           
        y=data[:,int(args.y_index)].reshape(len(data[:,int(args.y_index)]),1)
    return y
def get_x(data):
    X=data[:,6:]
    # MUTLIply by 60 bcs C/h instead of C/min
    X[:,4]=X[:,4]*60
    return X
#
#LOAD DATA FROM FILE 
infile="../db_final.tsv"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, names = names, delimiter="\t")
#
# DATA PREPROCESSING
X_names=names[6:]
data=np.array(df)
X_all=get_x(data)
Y_all=get_y(data,args.y_index)
# EMMA DATASET
data_emma=np.array(df >> mask(df.enr != 0))
X_emma=get_x(data_emma)
Y_emma=get_y(data_emma,args.y_index)
# PRE-EMMA DATASET
data_pre=np.array(df >> mask(df.enr == 0))
X_pre=get_x(data_pre)
Y_pre=get_y(data_pre,args.y_index)
# PRE-EMMA DATASET WITHIN EMMA BOUNDARIES
data_intra=np.array( df>> mask(dfply.X.enr == 0) \
        >> mask(dfply.X.conc >1) \
        >> mask(dfply.X.layers >=4) \
        >> mask(dfply.X.vDOC >=10)\
        >> mask(dfply.X.TDOC >=40)\
        >> mask(dfply.X.vCal >=2) ) 
X_intra=get_x(data_intra)
Y_intra=get_y(data_intra,args.y_index)
#
# DO LINEAR REGRESSION
if args.fit_all : 
    reg = LinearRegression().fit(X_all,Y_all)
    train_dataset="complete dataset"
else:
    reg = LinearRegression().fit(X_emma,Y_emma)
    train_dataset="EMMA dataset"
Y_emma_pred = reg.predict(X_emma)
Y_pre_pred = reg.predict(X_pre)
Y_intra_pred = reg.predict(X_intra)
Y_all_pred = reg.predict(X_all)
#
# PRINT OUTPUT
if args.y_index == "0": 
    y_name = "all"
else: 
    y_name = names[int(args.y_index)]
#print("Lin regression for", y_name)
print("Lin regression trained with", train_dataset)
print("Reg score", reg.score(X_emma,Y_emma))
if args.print_mse: 
    print("MAE(emma): ",MAE(Y_emma_pred,Y_emma))
    print("MSE(emma): ",MSE(Y_emma_pred,Y_emma))
    print("MAE(pre): ",MAE(Y_pre_pred,Y_pre))
    print("MSE(pre): ",MSE(Y_pre_pred,Y_pre))
    print("MAE(intra): ",MAE(Y_intra_pred,Y_intra))
    print("MSE(intra): ",MSE(Y_intra_pred,Y_intra))
    print("MAE(all): ",MAE(Y_all_pred,Y_all))
    print("MSE(all): ",MSE(Y_all_pred,Y_all))
#
# PRINT NICELY FORMATTED REGRESSION FUNCTION: 
if args.print_reg:
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
              reg.coef_[0,i]*max(X_emma[:,i])/max(Y_emma[:,0]), 
              sep="\t") 
#
## MEASURED VS PREDICTED
#if args.predict: 
#    if args.y_index != "0":
#        print("MEASURED \tPREDICTED")
#        for i in range(len(Y_emma)): 
#            print ("%f\t%f" %(Y_emma[i], Y_emma_pred[i]))
if args.pred_emma or args.pred_all or args.pred_intra or args.pred_pre:
    if args.y_index != "0":
        if args.pred_emma: X,Y,Yp= X_emma, Y_emma, Y_emma_pred
        if args.pred_all: X,Y,Yp= X_all, Y_all, Y_all_pred
        if args.pred_intra: X,Y,Yp= X_intra, Y_intra, Y_intra_pred
        if args.pred_pre: X,Y,Yp= X_pre, Y_pre, Y_pre_pred
        print("\t\t\t\tMEASURED \tPREDICTED")
        for i in range(len(Y)): 
            print (X[i], end="\t")
            print ("%f\t%f" %(Y[i], Yp[i]))

exit()
