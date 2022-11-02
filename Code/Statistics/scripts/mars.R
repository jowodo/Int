#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder
# GET MARS fuctions from db_final.emma.tsv

suppressMessages(suppressWarnings(library("dplyr")))
suppressMessages(suppressWarnings(library("earth")))
only_emma=1

dat<-read.delim("../db_final.tsv") 
d.all <- dat %>% select ( ! avg1.G.:avg2.G.) 
if (! only_emma){
x.all <- d.all %>% mutate(vC6=vCal*60) %>% select(conc:layr,vDOC,TDOC,vC6,TCal)
y.all <- d.all %>% select(G,phd,layr,vCal)
mars.all <- earth ( x.all, y.all, degree=2)
print("MARS model for all samples") 
format(mars.all)
}

d.emma <- d.all %>% filter ( enr != 0 ) 
x.emma <- d.emma %>% mutate(vC6=vCal*60) %>% select(conc:layr,vDOC,TDOC,vC6,TCal)
y.emma <- d.emma %>% select(G,phd,layr,vCal)
input <- cbind(x.emma,y.emma)
fmla <- as.formula(paste(paste("data.matrix(input[,",ncol(x.emma)+1,":",ncol(x.emma)+ncol(y.emma),"])"),"~", paste(colnames(x.emma),collapse= "+")))
mars.emma <- earth(fmla,degree=2,trace=0,minspan=1,data=input,keepxy=TRUE)
print("MARS model for EMMA samples")
format(mars.emma)

if (! only_emma){
d.hot <- d.all %>% filter ( TCal != 300 ) 
x.hot <- d.hot %>% select(conc:TCal)
y.hot <- d.hot %>% mutate(vC6=vCal*60) %>% select(G,phd,layr,vC6)
mars.hot <- earth ( x.hot, y.hot, degree=2)
print("MARS model for all samles with TCal>300")
format(mars.hot)
}
