import pandas as pd
import numpy as np
from math import ceil
import os
def get_sample_name():
    path=os.getcwd()
    dirname=path.split("/")[-1]
    name=dirname.split("_")[1]
    no=dirname.split("_")[2]
    return name,no
def get_conductance(filename):
    n_comments=40
#    print(filename)
    for r in range(n_comments):
#        print(r)
        try:
            df=pd.read_csv(filename,sep="\t",header=r,names=("V","I","i","J","j"))
            #df=pd.read_csv(filename,sep="\t",header=0,names=("V","I","absI","J","jcm"))
            #df=pd.read_csv(filename,sep="\t",names=("V","I","absI","J","jcm"))
        except:
            pass
#            print("could not read",filename)
        else:
#            print(df)
            i=0             #first 
            j=len(df)-1     #last
            #TODO find pos at which V=0
            zero=np.where( df["V"] == 0)
            zero=ceil(j/2)
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
                i=i+1
                j=j-1
#            print(dv,di)
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
    ########################################################
    msd=0   #mean square distance
    g0=13
    holes=0
    avg=0
    lavg=0
    for g in G:
        lgg = np.log10(g)
        if -lgg < 5:
            holes = holes + 1
        sd=(lgg+g0)**2
        msd=msd+sd
        avg=avg+g
        lavg=lavg+lgg
    msd=msd/n
    holes=holes/n
    #avg=np.log10(avg/n)
    avg=avg/n
    lavg=lavg/n
    return msd,holes,avg,lavg

def get_last_iteration(filenames):
    subset=[]
    position_list=[]
    count_list=[]
    for filename in filenames: 
        try:
            position,count=filename.split("_0")
        except:
            continue
        if (position in position_list):
            #position_index = [i for i,pos in enumerate(position_list) if pos = position]
            index = position_list.index(position)
            if ( count_list[index] < count): 
                subset[index] = filename
                count_list[index] = count
        else:
            subset.append(filename)
            position_list.append(position)
            count_list.append(count)
        
    return subset
#    return [subset[0]]


    

#######################
def main():
    sample_name,no = get_sample_name()
    files=get_files(sample_name)
    files=get_last_iteration(files)
#    print(files)
    Gs=[]
    for filename in files:
        G=get_conductance(filename)
    #    print(G)
        Gs.append(G)
    msd,holes,avg,lavg=make_stat(Gs)
    #print(msd,holes,avg,lavg)
    print(f"{sample_name:s}\t{no:s}\t{msd:.5f}\t{holes:.5f}\t{avg:.5e}\t{lavg:.5f}")

if __name__ == "__main__":
    main()
