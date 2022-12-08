#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder
# this script does the same as emma.R but with stored data from db_final.tsv

suppressMessages(suppressWarnings(library("dplyr")))
suppressMessages(suppressWarnings(library("earth")))
only_emma=1
test_all=(only_emma-1)*(only_emma-1)

get_MSE <- function (y,y.pred)
{
    MSE <- colMeans((y-y.pred)*(y-y.pred))
    return(MSE)
}
get_MAE <- function(y,y.pred)
{
    MAE <- colMeans(abs(y-y.pred))
    return(MAE)
}
# LOAD DATA FROM FILE 
dat<-read.delim("../db_final.tsv") 
d.all <- dat %>% select ( ! avg1.G.:avg2.G.) 
x.all <- d.all %>% mutate(vC6=vCal*60) %>% select(conc:layr,vDOC,TDOC,vC6,TCal)
y.all <- d.all %>% select(G,phd,layr,vCal)
# PRE-EMMA EXPERIMENTS
d.pre <- d.all %>% filter (enr == 0) 
x.pre <- d.pre %>% mutate(vC6=vCal*60) %>% select(conc:layr,vDOC,TDOC,vC6,TCal)
y.pre <- d.pre %>% select(G,phd,layr,vCal) # %>% select (vCal) 
# PRE-EMMA WITHIN BOUNDARIES OF EMMA 
d.inter <- d.pre %>% filter(conc>1) %>% filter(layr>=4) %>% filter(vDOC>=10) %>% filter(TDOC>=40) %>% filter(vCal>=2)
x.inter <- d.inter %>% mutate(vC6=vCal*60) %>% select(conc:layr,vDOC,TDOC,vC6,TCal)
y.inter <- d.inter %>% select(G,phd,layr,vCal) # %>% select (vCal) 

if (only_emma){
    d.emma <- d.all %>% filter ( enr != 0 ) 
    x.emma <- d.emma %>% mutate(vC6=vCal*60) %>% select(conc:layr,vDOC,TDOC,vC6,TCal)
    y.emma <- d.emma %>% select(G,phd,layr,vCal) # %>% select (vCal) 
    input <- cbind(x.emma,y.emma)
    fmla <- as.formula(paste(paste("data.matrix(input[,",ncol(x.emma)+1,":",ncol(x.emma)+ncol(y.emma),"])"),"~", paste(colnames(x.emma),collapse= "+")))
    mars.emma <- earth(fmla,degree=2,trace=0,minspan=1,data=input,keepxy=TRUE)
    y.pred <- predict(mars.emma, newdata=x.emma)
    # PRINT MAE AND MSE
    print("MAE(emma)")
    print(get_MAE(y.emma,y.pred))
    print("MSE(emma)")
    print(get_MSE(y.emma,y.pred))
    # PRINT MAE AND MSE FOR PRE-EMMA DATA
    y.pred <- predict(mars.emma, newdata=x.pre)
    print("MAE(pre)")
    print(get_MAE(y.pre,y.pred))
    print("MSE(pre)")
    print(get_MSE(y.pre,y.pred))
    # PRINT MAE AND MSE FOR PRE-EMMA DATA WITHIN EMMA BOUNDARIES
    y.pred <- predict(mars.emma, newdata=x.inter)
    print("MAE(inter)")
    print(get_MAE(y.inter,y.pred))
    print("MSE(inter)")
    print(get_MSE(y.inter,y.pred))
    # PRINT MAE AND MSE FOR ALL DATA 
    y.pred <- predict(mars.emma, newdata=x.all)
    print("MAE(all)")
    print(get_MAE(y.all,y.pred))
    print("MSE(all)")
    print(get_MSE(y.all,y.pred))
    # PRINT REGRESSION FORMULA 
    print("MARS model for EMMA samples")
    format(mars.emma)
}

if (test_all){
    # CONVERT C/min to C/h
    mars.all <- earth ( x.all, y.all, degree=2)
    print("MARS model for all samples") 
    format(mars.all)
}

if (test_all){
    d.hot <- d.all %>% filter ( TCal != 300 ) 
    x.hot <- d.hot %>% select(conc:TCal)
    y.hot <- d.hot %>% mutate(vC6=vCal*60) %>% select(G,phd,layr,vC6)
    mars.hot <- earth ( x.hot, y.hot, degree=2)
    print("MARS model for all samles with TCal>300")
    format(mars.hot)
}
