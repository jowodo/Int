#!/usr/bin/env python3

import numpy as np 
from sklearn.svm import SVR # Epsilon-support Vector Regression
import sklearn
import pandas as pd
import dfply
from dfply import mask
import argparse
#
# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Grid Search for hyper parameters')
parser.add_argument('-y', '--yindex', dest ='y_index',action ='store', choices={'2','3','7','10'}, default='2', help ='y to fit: 2=G; 3=phd; 7=layers; 10=vCal [default=2]')
#parser.add_argument('-c', '--clean', dest ='clean',action ='store_true', default=False, help ='Only use test data which is in space spanned by train data') 
parser.add_argument('-m', '--maxiter', dest ='maxiter',action ='store', default='10000', help ='Hard limit on itermations within solver, default: 10000, use -1 for unlimited') 
parser.add_argument('-p', '--predall', dest ='predall', action ='store_true', default=False, help ='Predict all data')
parser.add_argument('-s', '--show', dest ='show', action ='store_true', default=False, help ='Show prediction')
parser.add_argument('-t', '--stat', dest ='stat', action ='store_true', default=False, help ='Show statistics')
parser.add_argument('-x', '--scale', dest ='scale', action ='store_true', default=False, help='Scale input before fitting')
#
parser.add_argument('-k', '--kernel', dest ='kernel', action ='store', default='poly', help ='Choose kernel', choices={'poly', 'rbf', 'sigmoid'})
parser.add_argument('-d', '--degree', dest ='degree', action ='store', default='3', help ='Degree of polynomial')
parser.add_argument('-g', '--gamma', dest ='gamma', action ='store', default='0.1', help ='Scaling factor gamma')
parser.add_argument('-e', '--epsilon', dest ='epsilon', action ='store', default='3.0', help ='Tube size without penalty epsilon')
parser.add_argument('-C', dest ='C', action ='store', default='0.5', help ='Regularisation term; the smaller the more regularized')
#
args = parser.parse_args()
#
# DEFINE MEAN SQUARED ERROR FUNCTION
def MSE(predicted,measured):
    pred=np.array(predicted)
    real=np.array(measured)
    mse=np.average(np.square(pred-real))
    return mse
# DEFINE MEAN ABSOLUTE ERROR FUNCTION
def MAE(predicted,measured):
    pred=np.array(predicted)
    real=np.array(measured)
    mae=np.average(np.absolute(pred-real))
    return mae
#
# DATA PRE-PROCESSING 
def get_sets(df,names,y_index):
    data=np.array(df)
    X=data[:,6:]
    # MUTLIply by 60 bcs C/h instead of C/min
    X[:,4]=X[:,4]*60
    X_names=names[6:]
    Y=data[:,int(y_index)].reshape(-1)
    return X,Y
#
def get_MAE(y,ypred):
    return (np.average(np.absolute(y-ypred))/len(y))
#
#LOAD DATA FROM FILE 
infile="../../Statistics/db_final.tsv"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
#         0     1       2               3           4          5          6       7        8        9       10      11 
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
# ONLY USE DATA WHICH CAN BE INTERPOLATED FROM EMMA DATA SET
df_inter = df >> mask(dfply.X.enr == 0) \
    >> mask(dfply.X.conc > 1) \
    >> mask(dfply.X.layers >= 4) \
    >> mask(dfply.X.vDOC >= 10) \
    >> mask(dfply.X.TDOC >= 40) \
    >> mask(dfply.X.vCal >= 2) 
data_inter=np.array(df_inter)
X_inter=data_inter[:,6:]
Y_inter=data_inter[:,int(args.y_index)].reshape(len(data_inter[:,int(args.y_index)]),1)
# GET PRE-EMMA DATA
data_pre=np.array(df >> mask(dfply.X.enr == 0))
X_pre=data_pre[:,6:]
Y_pre=data_pre[:,int(args.y_index)].reshape(len(data_pre[:,int(args.y_index)]),1)
# GET EMMA DATA
data_emma = np.array(df >>mask(dfply.X.enr !=0)) 
X_emma=data_emma[:,6:]
Y_emma=data_emma[:,int(args.y_index)].reshape(len(data_emma[:,int(args.y_index)]),1)
# GET ALL DATA
data_all = np.array(df)
X_all=data_all[:,6:]
Y_all=data_all[:,int(args.y_index)].reshape(len(data_all[:,int(args.y_index)]),1)
#
#PREPROCESSING DATA 
X_train,Y_train = X_emma, Y_emma # get_sets(df_emma,names,args.y_index)
X_test,Y_test = X_pre, Y_pre # get_sets(df_pre,names,args.y_index)
if args.predall:
    X_test,Y_test = get_sets(df,names,args.y_index)
#
#################
k = args.kernel # ["poly","rbf","sigmoid"]
d = int(args.degree) # range(1,3)
g = float(args.gamma) # [0.01, 0.05, 0.1, 0.5, 1.0, 5, 10]
c = float(args.C) # [0.01, 0.05, 0.1, 0.5, 1, 5, 10, 50, 100]
e = float(args.epsilon) # [0.01, 0.05, 0.1, 0.5, 1, 5, 10, 50, 100]
#
# HEADER LINE 
#print("%s MAE \tMAE/AVG" % names[int(args.y_index)])
#print("%s real \t predicted" % names[int(args.y_index)])
ML = SVR(kernel=k, C=c, degree=d, epsilon=e, gamma=g, max_iter=int(args.maxiter))
ML.fit(X_train,np.squeeze(Y_train))
if args.scale : 
    ML.fit(sklearn.preprocessing.StandardScaler().fit_transform(X_train) ,np.squeeze(Y_train))
    print("./svm_pred.py -k %s -d %s -C %s -e %s -g %s -x" %(args.kernel, args.degree, args.C, args.epsilon, args.gamma))
else: 
    print("./svm_pred.py -k %s -d %s -C %s -e %s -g %s" %(args.kernel, args.degree, args.C, args.epsilon, args.gamma))
Y_emma_pred=ML.predict(X_emma)
if args.scale : Y_emma_pred=ML.predict(sklearn.preprocessing.StandardScaler().fit_transform(X_emma))
print("MAE(emma): ",MAE(Y_emma_pred,Y_emma))
print("MSE(emma): ",MSE(Y_emma_pred,Y_emma))
Y_pre_pred=ML.predict(X_pre)
if args.scale : Y_pre_pred=ML.predict(sklearn.preprocessing.StandardScaler().fit_transform(X_pre))
print("MAE(pre): ",MAE(Y_pre_pred,Y_pre))
print("MSE(pre): ",MSE(Y_pre_pred,Y_pre))
Y_inter_pred=ML.predict(X_inter)
if args.scale : Y_inter_pred=ML.predict(sklearn.preprocessing.StandardScaler().fit_transform(X_inter))
print("MAE(inter): ",MAE(Y_inter_pred,Y_inter))
print("MSE(inter): ",MSE(Y_inter_pred,Y_inter))
Y_all_pred=ML.predict(X_all)
if args.scale : Y_all_pred=ML.predict(sklearn.preprocessing.StandardScaler().fit_transform(X_all))
print("MAE(all): ",MAE(Y_all_pred,Y_all))
print("MSE(all): ",MSE(Y_all_pred,Y_all))
if args.predall: 
    X = X_all
    Y = Y_all
else:
    X = X_emma
    Y = Y_emma
Y_pred= ML.predict(X)
if args.scale: Y_pred= ML.predict(sklearn.preprocessing.StandardScaler().fit_transform(X))
if args.show: 
    print("%s real \t predicted" % names[int(args.y_index)])
    for i in range(len(Y)):
        print(X[i], Y[i], Y_pred[i])
if args.stat: print ("Mean(Y): %.3f \tstd(Y): %.3f \tmean(Ypred): %.3f \tstd(Ypred): %.3f" %(Y.mean(), Y.std(), Y_pred.mean(), Y_pred.std()))
