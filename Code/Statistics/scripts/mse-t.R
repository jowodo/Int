#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder
# measure the MSE of predictions for t=1,2,3,4

# 
# emmacheck(t4,graph="yes")
# wget https://cran.r-project.org/src/contrib/Archive/emma/emma_0.1-0.tar.gz
# tar xf emma_0.1-0.tar.gz 
# vim emma/R/estimateModel.R

suppressMessages(suppressWarnings(library("dplyr")))
load("../../EMMA/t5") 
source("../../EMMA/inter.R") 
source("../../../../emma.src/emma/R/estimateModel.R")

test.overfit<-function(x){
    dat<-read.delim("../db_final.sorted.tsv") 
    d.all <- dat  %>% dplyr::select ( ! avg1.G.:avg2.G.) 
    d.po <- d.all %>% filter ( enr != 0 ) 
    x.po <- d.po %>% mutate(v6C=vCal*60) %>% dplyr::select(conc,layr,vDOC,TDOC,v6C,TCal)
    x.po <- x.po %>% mutate(vCal=v6C*1) %>% dplyr::select(conc,layr,vDOC,TDOC,vCal,TCal)
    y.po <- d.po %>% dplyr::select(G,phd,layr,vCal)
    input <- cbind(x.po,y.po)
    input <- cbind(x$xpop,x$ypop)
    fmla <- as.formula(paste(paste("data.matrix(input[,",ncol(x$xpop)+1,":",ncol(x$xpop)+ncol(x$ypop),"])"),"~", paste(colnames(x$xpop),collapse= "+")))
    mars.po <- earth(fmla,degree=2,trace=0,minspan=1,data=input,keepxy=TRUE)
    forecast <- predict(mars.po,newdata=x.po)
    predicted <- data.frame(forecast)
    rownames(predicted) <- rownames(x.po)
    colnames(predicted) <- colnames(x$yspace)
    g3.pred<-predicted
    g3.measured <- y.po
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
##sprintf("MSE_t0: %f",mse(t0))
sprintf("MSE_t1: %i %f",length(t1$tested),mse(t1))
sprintf("MSE_t2: %i %f",length(t2$tested),mse(t2))
sprintf("MSE_t3: %i %f",length(t3$tested),mse(t3))
sprintf("MSE_t4: %i %f",length(t4$tested),mse(t4))
sprintf("MSE-PO_t1: %i %f",length(t1$tested),test.overfit(t1))
sprintf("MSE-PO_t2: %i %f",length(t2$tested),test.overfit(t2))
sprintf("MSE-PO_t3: %i %f",length(t3$tested),test.overfit(t3))
sprintf("MSE-PO_t4: %i %f",length(t4$tested),test.overfit(t4))


