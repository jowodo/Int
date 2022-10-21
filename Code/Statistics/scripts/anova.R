#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder

library("dplyr") 

n="numeric"
f="factor"
dat<-read.delim("../db_final.tsv", colClasses=c(n,n,n,n,n,n,f,f,f,f,f,f))
d.all <- dat %>% select (! avg1.G.:avg2.G.)
d.emma <- d.all %>% filter ( enr != 0 ) 

G.TCal.emma.aov<-aov(G ~ TCal, data = d.emma)
print("ANOVA with EMMA samples: G ~ TCal")
summary(G.TCal.emma.aov)

G.TCal.all.aov<-aov(G ~ TCal, data = d.all)
print("ANOVA with all samples: G ~ TCal")
summary(G.TCal.all.aov)

G.layr.emma.aov<-aov(G ~ layr, data = d.emma)
print("ANOVA with EMMA samples: G ~ layr")
summary(G.layr.emma.aov)

G.layr.all.aov<-aov(G ~ layr, data = d.all)
print("ANOVA with all samples: G ~ layr")
summary(G.layr.all.aov)

G.TDOC.emma.aov<-aov(G ~ TDOC, data = d.emma)
print("ANOVA with EMMA samples: G ~ TDOC")
summary(G.TDOC.emma.aov)

G.TDOC.all.aov<-aov(G ~ TDOC, data = d.all)
print("ANOVA with all samples: G ~ TDOC")
summary(G.TDOC.all.aov)

G.TvDOC.emma.aov<-aov(G ~ TDOC:vDOC, data = d.emma)
print("ANOVA with EMMA samples: G ~ TDOC:vDOC")
summary(G.TvDOC.emma.aov)

G.TvDOC.all.aov<-aov(G ~ TDOC:vDOC, data = d.all)
print("ANOVA with all samples: G ~ TDOC:vDOC")
summary(G.TvDOC.all.aov)



