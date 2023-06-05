V_zrs=[50,100,150,200,250]          # ul
rho=0.001044   # g/ul
beta=0.7    # %
rho_n=rho*beta
for V_zr in V_zrs:
    V_hacac=V_zr/4                  # ul
    V_buoh=5000-V_zr                # ul
    V_ipo=2000                      # ul
    V=V_zr+V_hacac+V_buoh+V_ipo     # ul
    m=rho*beta*V_zr                 # g/ul*ul=g
    c=m/V*1000*1000                 # g/L
    if V_zr == V_zrs[0]:
        const=c
    print(V_zr,V,c,c/const)
