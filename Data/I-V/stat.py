import pandas as pd
import numpy as np
from math import ceil
import os
def get_sample_name():
    path=os.getcwd()
    dirname=path.split("/")[-1]
    name=dirname.split("_")[1]
    return name
def get_conductance(filename):
    n_comments=40
#    print(filename)
    for r in range(n_comments):
        try:
            df=pd.read_csv(filename,"\t",header=r,names=("V","I","i","J","j"))
        except:
            pass
            #print("could not read",filename)
        else:
#            break
            i=0         #first 
            j=len(df)-1    #last
#            print(j)
            #TODO find pos at which V=0
            zero=np.where( df["V"] == 0)
            zero=ceil(j/2)
#            print(df["V"][zero+1])
#            print(zero )
            # find prev 5-10 i and v and make avg 
            # find past 5-10 i and v and make avg 
            vdown=0
            vup=0
            idown=0
            iup=0
            d=2 #distance from zero
            s=5 # how many for avg 
#            while i < j:
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
#            print(G)
            return np.absolute(G)
    return 1    # if error with file reading
def get_header():
    return "exp\tconductance [S]"
def get_Gheader():
    return "exp\t%\tcount"
def get_files(sample_name):
    all_files = os.listdir()
#    print(all_files)
    measurements = filter(lambda measurment: sample_name in measurment, all_files)   # only return files with sample number in name
    measurements = filter(lambda measurment: "Ag" not    in measurment, measurements)   # don't include Ag files
    #TODO: only highest 
    return sorted(list(measurements))
def get_measurement():
    return 
def make_stat(G):
    mini=1
    maxi=13
    stat=np.repeat(0,maxi)#-mini)
    stat_rel=np.repeat(0,maxi)#-mini)
    n = len(G)
    for i in range(mini,maxi):
        #stat[i]=(np.absolute(np.around(np.log10(G))) == i).sum()
        stat[i]=(np.absolute((np.log10(G)).astype(int)) == i).sum()
        stat_rel[i]=(np.absolute((np.log10(G)).astype(int)) == i).sum()/n*100
        ### old visualization stat
        # print(i,stat_rel[i],stat[i],sep="\t")
    #return stat
    ########################################################
    msd=0   #mean square distance
    g0=13
    holes=0
    for g in G:
        lgg = np.log10(g)
        if lgg < 5:
            holes = holes + 1
        sd=(g0-lgg)
        msd=msd+sd
    msd=msd/n
    return msd,holes
    

#######################
def main():
    sample_name = get_sample_name()
    files=get_files(sample_name)
#    print(files)
    Gs=[]
    for filename in files:
#        print(filename)
        G=get_conductance(filename)
        Gs.append(G)
    #    print(filename,get_conductance(filename),sep="\t")
#    print(get_Gheader())
    msd,holes=make_stat(Gs)
    print(sample_name,msd, holes, sep="\t")
    #print(Gs)

    #print(get_sample_name())
    #print("G ",G)

if __name__ == "__main__":
    main()
