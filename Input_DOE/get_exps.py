import numpy as np
np.set_printoptions(suppress=True)
def get_exp(H,param):
    n_exps=len(H)    # number of experiments
    n_fact=len(H[0]) # number of factors
    H_new=np.zeros((n_exps,n_fact))
    for i_exps in range(n_exps):
        for i_fact in range(n_fact):
            if H[i_exps][i_fact] == 1:
                H_new[i_exps][i_fact] = param["max"][i_fact]
            else:
                H_new[i_exps][i_fact] = param["min"][i_fact]
    return H_new

#def print_exp(H,param):
def sort_exp(H,fact=0):
    H_sorted = H[H[:,fact].argsort()]
    return H_sorted

