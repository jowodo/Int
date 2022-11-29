#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder
# this script does the same as mars.R but with stored data from EMMA 
# 
# emmacheck(t4,graph="yes",nresp={1,2,3,4})
# wget https://cran.r-project.org/src/contrib/Archive/emma/emma_0.1-0.tar.gz
# tar xf emma_0.1-0.tar.gz 
# vim emma/R/emmacheck.R 

suppressMessages(suppressWarnings(library("dplyr")))
load("../../EMMA/t5") 
source("../../EMMA/inter.R") 

# LOAD DATA FROM LAST TIME STEP OF EMMA 
x<-t4
# COMBINE INPUT AND OUTPUT INTO ONE DATA FRAME 
input <- cbind(x$xpop,x$ypop)
# MAKE FORMULAR: G,phd,layers,vCal ~ conc + layers + vDOC + TDOC + vCal + TCal 
fmla <- as.formula(paste(paste("data.matrix(input[,",ncol(x$xpop)+1,":",ncol(x$xpop)+ncol(x$ypop),"])"),"~", paste(colnames(x$xpop),collapse= "+")))
# MAKE MARS MODEL AS IS EMMA
mars.mod <- earth(fmla,degree=2,trace=0,minspan=1,data=input,keepxy=TRUE)
# PRINT TIME STEP FROM WHICH DATA WAS TAKEN
sprintf("t%i",x$time)
format(mars.mod)



