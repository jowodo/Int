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

x<-t4
input <- cbind(x$xpop,x$ypop)
fmla <- as.formula(paste(paste("data.matrix(input[,",ncol(x$xpop)+1,":",ncol(x$xpop)+ncol(x$ypop),"])"),"~", paste(colnames(x$xpop),collapse= "+")))
mars.mod <- earth(fmla,degree=2,trace=0,minspan=1,data=input,keepxy=TRUE)
sprintf("t%i",x$time)
format(mars.mod)



