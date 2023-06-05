import numpy as np
import pandas as pd

def get_goodness(g,phd, layers, vCal):
    w=weights=[0.4,0.5,0.05, 0.05]
    return w[0]*g+ w[1]*phd+ w[2]*layers+ w[3]*vCal

# predicted from EMMA t=4? 
infile="allspace.dat"
names = ["nr", "conc", "layr", "vDOC", "TDOC", "vCal", "TCal", "G", "phd", "layers", "Cal_vel"]
df=pd.read_csv(infile, skiprows=1, delim_whitespace=True, names = names)
#f = open(infile, 'r+')
#print(df)
bestvalues=0
best_measure = np.inf
for n in df.nr:
    i=n-1
#    print(n,i)
    v = values = [ df.G[i], df.phd[i], df.layers[i], df.Cal_vel[i] ] 
    measure = get_goodness(float(v[0]), float(v[1]), float(v[2]), float(v[3]) )
    if measure < best_measure:
        bestvalues=v #df.nr[i]
        best_measure = measure
        print(i,best_measure,bestvalues,measure)
#        print("yiss")

#for line in f.readlines():
#    values = line.split("\t")
#    v= values
##    try:
#    print(best_measure)
#    if fl != 1:
#        measure = get_goodness(float(v[0]), float(v[1]), float(v[2]), float(v[3]) )
#        if measure < best_measure:
#            bestvalues=v
#            best_measure = measure
#    else:
#        fl=0
#        pass
##    except:
##        print("pass")
##        pass
#
print(best_measure)
print(bestvalues)


