#!/usr/bin/env python3

import numpy as np 
from sklearn.kernel_ridge import KernelRidge as KRR
import sklearn
import pandas as pd
import dfply
import argparse
#
#################
# KERNEL FOR KRR
kernel=["poly","rbf","sigmoid"] # HPGS
# DEGREE OF POLYNOMIAL; ignored by rest
degree=range(1,4) # HPGS
# alpha: bigger alpha, bigger regularisation 
alpha=[0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10] #, 10, 50, 100] # HPGS
# some kind of scaling factor; can be set to auto/scale, include into list? 
gamma=[0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10] #, 10, 50, 100] # HPGS
#
# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Grid Search for hyper parameters')
parser.add_argument('-e', '--emma', dest ='only_emma',action ='store_true', help ='only use emma data')
parser.add_argument('-k', '--kfold', dest ='kfold',action ='store', default='5', help ='Split into k set for k-fold cross validation. Use 0 for Leave-One-Out') 
parser.add_argument('-m', '--maxiter', dest ='maxiter',action ='store', default='10000', help ='Hard limit on itermations within solver, default: 10000, use -1 for unlimited') 
parser.add_argument('-t', '--test', dest ='test',action ='store_true', help ='Test: Only use subset of hyperparameters') 
parser.add_argument('-x', '--scale', dest ='scale', action ='store_true', default=False, help='Scale input before fitting')
parser.add_argument('-y', '--yindex', dest ='y_index',action ='store', choices={'2','3','7','10'}, default='2', help ='y to fit: 2=G; 3=phd; 7=layers; 10=vCal [default=2]')
args = parser.parse_args()
#
# GET INPUT AND OUTPUT DATA
def get_sets(df,names,args):
    data=np.array(df)
    X=data[:,6:]
    # MUTLIply by 60 bcs C/h instead of C/min
    X[:,4]=X[:,4]*60
    X_names=names[6:]
    Y=data[:,int(args.y_index)].reshape(-1)
    return X,Y
#
#LOAD DATA FROM FILE 
infile="../../Statistics/db_final.tsv"
#         0     1       2               3           4          5          6       7        8        9       10      11 
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
#
# FILTER OUT NON EMMA SAMPLES
if args.only_emma:
    df = df >>dfply.mask(df.enr !=0)
#
# K-FOLD 
if args.kfold == 0: 
    # set k to number of samples
    args.kfold=df.shape[0]
#
#PREPROCESSING DATA 
X,Y=get_sets(df,names,args)
if args.scale : X=sklearn.preprocessing.StandardScaler().fit_transform(X)
#
# DUMMY RUN
if args.test : 
    degree=[1,2]; gamma=[0.01,0.1,1]; alpha=[0.5,0.1,1]; 
#
# CALCULATE NUMBER OF EXPERIMENTS
n_exps=(len(degree)+len(kernel)-1)*len(gamma)*len(alpha)
#
# PRINT HEADER LINE 
#print(f"%s accuracy with standard deviation", names[int(args.y_index)])
print("mean(SCORE)\tvar(SCORE)\tparams")
i=1
#
# PRINT SCORES
for k in kernel:
    if k=="poly":
        for d in degree:
            for a in alpha:
                for g in gamma:
                    line=""
                    ML = KRR(kernel=k, alpha=a, degree=d, gamma=g)
                    score=sklearn.model_selection.cross_val_score(ML,X,Y,cv=int(args.kfold))
                    line=f"{score.mean():.6f}"+"\t"+ f"{score.std():.6f}"+"\t"
                    print(line+ k+ 
                            "\tdeg="+str(d)+ 
                            "\ta="+f"{a:.2f}"+ 
                            "\tg="+str(g)+ 
                            "\t"+str(i)+"/"+str(n_exps), 
                            flush=True)
                    i+=1
    else:
        for a in alpha:
            for g in gamma:
                line=""
                ML = KRR(kernel=k, alpha=a, degree=d, gamma=g)
                score=sklearn.model_selection.cross_val_score(ML,X,Y,cv=int(args.kfold))
                line=f"{score.mean():.6f}"+"\t"+ f"{score.std():.6f}"+"\t"
                print(line+ k+ 
                        "\tdeg="+str(0)+ 
                        "\ta="+f"{a:.2f}"+ 
                        "\tg="+str(g)+ 
                        "\t"+str(i)+"/"+str(n_exps), 
                        flush=True)
                i+=1
