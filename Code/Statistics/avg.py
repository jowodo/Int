import numpy as np
G_gen0=[
        10.95940, 29.16378, 24.32170, 12.38955, 15.64646
        , 
        70.64908, 45.50493, 79.39680, 32.86985, 51.09902
        ]
G_gen1=[39.68027, 108.47050, 71.25290, 46.44359, 49.18166]
G_gen2=[38.79620, 47.17184, 76.44246, 42.66628, 47.64474]
G_gen3=[28.56022, 61.73920, 52.13835, 52.18121, 47.53164]
G_gen4=[36.17699, 36.54716, 43.19611, 36.16643, 47.75640]
G=[G_gen0, G_gen1, G_gen2, G_gen3, G_gen4]

phd_gen0=[
        0.00000, 0.02083, 0.00000, 0.00000, 0.03846
        ,
        0.78431, 0.02778, 0.86842, 0.00000, 0.03030
        ]
phd_gen1=[0.12500, 1.00000, 0.95652, 0.03030, 0.00000]
phd_gen2=[0.05882, 0.33333, 1.00000, 0.00000, 0.00000]
phd_gen3=[0.00000, 0.38710, 0.03571, 0.09091, 0.00000]
phd_gen4=[0.06061, 0.04167, 0.00000, 0.04348, 0.00000]
phd=[phd_gen0, phd_gen1, phd_gen2, phd_gen3, phd_gen4]

a=5
for i in range(5):
#    print(G[i], G[i][5:9])
#    print(i, np.average(G[i]), np.average(phd[i]), np.average(G[i][0:5]), np.average(phd[i][0:5])) 
    print(f"{i:d}\t{np.average(G[i]):.4f}\t{np.average(phd[i]):.4f}\t{np.average(G[i][0:5]):.4f}\t{np.average(phd[i][0:5]):.4f}") 

