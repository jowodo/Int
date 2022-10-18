#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder

library("dplyr") 

n="numeric"
f="factor"
dat<-read.delim("../db_final.tsv", colClasses=c(n,n,n,n,n,n,f,f,f,f,f,f))
d.all <- dat %>% select (! avg1.G.:avg2.G.)
d.emma <- d.all %>% filter ( enr != 0 ) 

G.TCal.all.aov<-aov(G ~ TCal, data = d.all)
print("ANOVA with all samples")
summary(G.TCal.all.aov)

G.TCal.emma.aov<-aov(G ~ TCal, data = d.emma)
print("ANOVA with EMMA samples")
summary(G.TCal.emma.aov)



