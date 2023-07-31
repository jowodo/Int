IV (current-voltage) measurements
=================================
Abbreviations 

|:---:|:--------------------:|
| eno | experiment number    |
| pid | point identification |
| phd | pin hole density     |
| G   | pondus conducti      |
| g   | conductance          | 


- summarize single sample 
    - calculate conductance g for each measurements
        - `for eno; for pid; calc_g.py -i $eno_$pid.iv >> eno_pid_g.tsv`
    - graph single measurements
    - `for eno; for pid; echo eno_pid_g.tsv | plot`
    - calculate G and phd per sample
        - `for eno; grep eno | calc_G_phd >> eno_G_phd.tsv`
    - graph summarized sample > eno.png 
