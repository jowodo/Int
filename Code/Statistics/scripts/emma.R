#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder

suppressMessages(suppressWarnings(library("dplyr")))
load("../../EMMA/t5") 
source("../../EMMA/inter.R") 
#for (i in 1:4){
#    emmacheck(t4,graph=1,eresp=i)
#}
#print("Global Best")
#t5$Gb.arch
#print("Personal Best")
##matrix(t5$Pb.arch,nrow=5)
##t5$xpop[:2] 

x<-t4
input <- cbind(x$xpop,x$ypop)
fmla <- as.formula(paste(paste("data.matrix(input[,",ncol(x$xpop)+1,":",ncol(x$xpop)+ncol(x$ypop),"])"),"~", paste(colnames(x$xpop),collapse= "+")))
mars.mod <- earth(fmla,degree=2,trace=0,minspan=1,data=input,keepxy=TRUE)
head(x$ypop,1)
format(mars.mod)



