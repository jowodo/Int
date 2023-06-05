#!/usr/bin/env python3

import argparse

# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Check influence of individual terms with EMMA data set and complete data set and output as LaTeX tabular')
parser.add_argument('--fe',dest ='fit_emma',action='store_true', help='fit with EMMA dataset [default]')
parser.add_argument('--fa',dest ='fit_all',action='store_true', help='fit with complete dataset')
args = parser.parse_args()

if args.fit_all:
    p_c_zr=0.017; p_l=0.22; p_v_db=0.013; p_t_db=0.0047; p_v_cal=0.00013; p_t_cal=0.0026    # complete data set
    g_c_zr=2.7; g_l=0.69; g_v_db=1.4; g_t_db=0.43; g_v_cal=0.012; g_t_cal=0.14 # complete data set
else:
    p_c_zr=0.022; p_l=0.22; p_v_db=0.0029; p_t_db=0.0058; p_v_cal=0.00085; p_t_cal=0.0026  # EMMA data set
    g_c_zr=3.2; g_l=0.97; g_v_db=1.2; g_t_db=0.2; g_v_cal=0.014; g_t_cal=0.13  # EMMA data set
p=[p_c_zr, p_l, p_v_db, p_t_db, p_v_cal, p_t_cal]

g=[g_c_zr, g_l, g_v_db, g_t_db, g_v_cal, g_t_cal]

c_zr=(2+5)/2
l=(4+12)/2
v_db=(10+20)/2
t_db=(40+80)/2
v_cal=(120+1080)/2
t_cal=(300+500)/2
m=[c_zr, l, v_db, t_db, v_cal, t_cal]
n=["c_zr", "l", "v_db", "t_db", "v_cal", "t_cal"]
n=["$c_{zr}$", "$\\lambda$", "$v_{DB}$", "$T_{DB}$", "$v_{cal}$", "$T_{cal}$"]


def get_influence(quantities,mean=m,names=n):
    sum=0
    for i in range(len(quantities)):
        sum+= quantities[i]*mean[i]
    for i in range(len(quantities)): 
        print("\t&%.2f" %(quantities[i]*mean[i]/sum*100),end="")
    print("\\\\")

for i in n:
    print("\t&",i,end="")
    
print("\\\\")
print("\\hline\\hline")
print("$\\hat\\rho$\t",end="")
get_influence(p)
print("$\\hat\\gamma$",end="")
get_influence(g)
print("\\hline\\hline")



