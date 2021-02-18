#!/usr/bin/python2
import pyDOE as p
import get_exps as get
import numpy as np
#""" define parameters and lower and upper limits"""
head=[  "conc", "nlay", "Tcal", "Tvel", "vDOC", "TDOC"]
min=[   1,      5,      400,    120,    1,      20]
max=[   5,      10,     500,    480,    5,      80]
param={"head":head,"min":min,"max":max}
factors=len(head)
min2=[  2,      6,      430,    240,    0.5,    40]
max2=[  4,      8,      470,    360,    2,      60]
param2={"head":head,"min":min2,"max":max2}

#SHIFT
s=1
def shift(dict_arr,shift=1):
    dict={}
    for i in range(shift):
        for arr in dict_arr.keys():
            dict_arr[arr].append(dict_arr[arr].pop(0))
    return dict_arr
#param= shift(param,s)
param2=shift(param2,s)

# Plackett-Burman
h=p.pbdesign(factors)
#
# insert real parameters
h_new=get.get_exp(h,param)
h_new2=get.get_exp(h,param2)
h_all=np.concatenate((h_new,h_new2))
#
print(param["head"])
print(get.sort_exp(h_new2,-2))
print(param["head"])
