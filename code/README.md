The Code of this project can be split into four major categories: 
0. data-preparation
1. pre-optimisation 
2. optimisation 
3. post-optimisation 

Data-Preparation
-----------------
This step takes in raw experimental data, does some statistical summary and outputs machine readable data. That statistical summary boils down to calculating the gradient for each IV-measurement. For each sample a logarithmic weighted average (conducticity) and the percentage of a threshold exceeding measurements (pin hole density) was calculated from the gradients. 

Pre-Optimisation 
-----------------
Pre-optimisation uses design of experiment (DOE) techniques like Plackett-Burman in order to create a small set of initial experiments and explore the boundaries for the optimisation problem. 

Optimisation
-------------
During the the Optimisation the EMMA R package is used to guide an ensemble of experiments towards an optimum, which is in this case an maximum electrical insulation of the applied zirconium ceramic layer. 

Post-Optimisation
------------------
During this section of the experiment the data which has been collected until this point is statistically examined to be compared with the results of the Optimisation step.
Statistical methods include kernel ridge regression (KRR), support vector regression (SVR), analysis of variance (ANOVA) and principal component analysis (PCA).
