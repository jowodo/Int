#!/usr/bin/python2
import pyDOE as p
import get_exps as get
import numpy as np
#""" define parameters and lower and upper limits"""
head=["conc","nlay","Tcal","Tvel","vDOC","TDOC"]
min=[1,4,400,60,0.1,20]
max=[5,10,500,480,5,80]
param={"head":head,"min":min,"max":max}
factors=len(head)
min2=[2,6,430,120,0.5,40]
max2=[4,8,470,240,1,60]
param2={"head":head,"min":min2,"max":max2}

#""" choose disign pattern """
#
# 2-level full factorial
#h=p.ff2n(factors)
#
# Plackett-Burman
h=p.pbdesign(factors)
#
# 2-Level Fractional-Factorial
#gen= "a +a b c d -d"
#h=p.fracfact(gen)
#print(h)
#
# real parameters
h_new=get.get_exp(h,param)
h_new2=get.get_exp(h,param2)
h_all=np.concatenate((h_new,h_new2))
#
# print output
#print(h_new)
print(param["head"])
print(get.sort_exp(h_new,-1))
#print(get.sort_exp(h_new2,-1))
print(get.sort_exp(h_all,-0))
print(param["head"])
