import math
import numpy as np 
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA

infile="db_final.dat"
names = ["nr", "enr", "conductivity", "phdensity", "avg1(G)", "avg2(G)", "conc", "layers", "vDOC", "TDOC", "vCal", "TCal"]
df=pd.read_csv(infile, skiprows=1, names = names)
#df= shuffle(df)
#print(df.head(2))
#print(df.shape)

x = StandardScaler().fit_transform(df) # normalizing 
x = x[:,2:]
#print(x.shape)
#print(np.mean(x),np.std(x))
#print(names)
#print(x[0])
pca_obj= PCA()
pca_fit = pca_obj.fit_transform(x)
#pca_df = pd.DataFrame(data = pca_fit, columns = ['pc1', 'pc2', 'pc3', 'pc4', 'pc5'])
pca_df = pd.DataFrame(data = pca_fit)
#print(pca_df.tail())
pca_ratios = pca_obj.explained_variance_ratio_
print('Explained variation per PC: {}'.format(pca_ratios))
print(sum(pca_ratios))
print(names[2:])
print(pca_obj.components_[:5])
exit
