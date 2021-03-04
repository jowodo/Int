import pandas as pd
import numpy as np
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
        else:
#            break
            i=0         #first 
            j=len(df)-1    #last
            while i < j:
                dv= (df["V"].iloc[j]-df["V"].iloc[i])
                di= (df["I"].iloc[j]-df["I"].iloc[i])
#                print(di/dv)
                i=i+1
                j=j-1
            R = dv/di
            G = di/dv
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
    return sorted(list(measurements))
def get_measurement():
    return 
def make_stat(G):
#    print(G)
    mini=1
    maxi=13
    stat=np.repeat(0,maxi)#-mini)
    stat_rel=np.repeat(0,maxi)#-mini)
    n = len(G)
    for i in range(mini,maxi):
        #stat[i]=(np.absolute(np.around(np.log10(G))) == i).sum()
        stat[i]=(np.absolute((np.log10(G)).astype(int)) == i).sum()
        stat_rel[i]=(np.absolute((np.log10(G)).astype(int)) == i).sum()/n*100
        print(i,stat_rel[i],stat[i],sep="\t")
    return stat

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
    print(get_Gheader())
    make_stat(Gs)
    #print(Gs)

    #print(get_sample_name())
    #print("G ",G)

if __name__ == "__main__":
    main()
