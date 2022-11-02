#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder

# 
# emmacheck(t4,graph="yes",nresp={1,2,3,4})
# wget https://cran.r-project.org/src/contrib/Archive/emma/emma_0.1-0.tar.gz
# tar xf emma_0.1-0.tar.gz 
# vim emma/R/emmacheck.R 

suppressMessages(suppressWarnings(library("dplyr")))
load("../../EMMA/t5") 
source("../../EMMA/inter.R") 
source("../../../../emma.src/emma/R/estimateModel.R")

mse<- function(x){
    g3.pred <- estimateModel(x,"no")[x$tested,]
    g3.measured <- x$ypop
    g3.diff <- g3.pred - g3.measured
    g3.se <- g3.diff * g3.diff
    g3.sum <- 0
    g3.n <- 0
    for (i in 1:ncol(g3.se)){
        for (j in 1:nrow(g3.se)){
            g3.sum <- g3.sum + g3.se[j,i]
            g3.n <- g3.n + 1 
        }
    }
    g3.mse<- g3.sum/g3.n
    return (g3.mse)
}
#sprintf("MSE_t0: %f",mse(t0))
sprintf("MSE_t1: %i %f",length(t1$tested),mse(t1))
sprintf("MSE_t2: %i %f",length(t2$tested),mse(t2))
sprintf("MSE_t3: %i %f",length(t3$tested),mse(t3))
sprintf("MSE_t4: %i %f",length(t4$tested),mse(t4))
