#!/usr/bin/env python3

import numpy as np 
import pandas as pd
import dfply
import argparse

# MAKE COMMAND LINE ARGUMENTS
parser = argparse.ArgumentParser(description ='Calculate conductance from a single IV measurement file')
parser.add_argument('filename', help ='input file')
args = parser.parse_args()
#
def get_sample_name(filepath):
    filename=filepath.split("/")[-1]
    sampleno=filename.split("_")[0]
    position=filename.split("_")[1]
    repeat=filename.split("_")[2]
    return sampleno,position,repeat
#
def get_conductance(filename):
    n_comments=40
    #print(filename)
    for r in range(n_comments):
        #print(r)
        try:
            df=pd.read_csv(filename,sep="\t",header=r,names=("V","I","i","J","j"))
        except:
            #print("could not read",filename)
            pass
        else:
            i=0             #first 
            j=len(df)-1     #last
            #find pos at which V=0
            zero=np.where( df["V"] == 0)
            zero=np.ceil(j/2)
            #print(zero)
            # find prev 5-10 i and v and make avg 
            # find past 5-10 i and v and make avg 
            vdown=0
            vup=0
            idown=0
            iup=0
            d=2 #distance from zero
            s=5 # how many for avg 
            for i in range(1,j):
                if i+d+s < zero and i+s < zero:
                    vdown=vdown + float(df["V"][i])
                    idown=idown + float(df["I"][i])
                if i-d-s < zero and i-s < zero:
                    vup=vup + float(df["V"][i])
                    iup=iup + float(df["I"][i])
                dv= vup-vdown
                di= iup-idown
#                dv= (df["V"].iloc[j]-df["V"].iloc[i])
#                di= (df["I"].iloc[j]-df["I"].iloc[i])
                i=i+1
                j=j-1
            R = dv/di
            G = di/dv
            return np.absolute(G)
    return -1    # if error with file reading

#######################
def main():
    sample_no,position,repeat = get_sample_name(args.filename)
    G=get_conductance(args.filename)
#    print(f"{sample_name:s}\t{G:.5f}")
    print(f"{position:s}\t{repeat:s}\t{G:.10f}")
#    print(f"{sample_name:s}\t{no:s}\t{msd:.5f}\t{holes:.5f}\t{avg:.5f}\t{lavg:.5f}")

if __name__ == "__main__":
    main()
