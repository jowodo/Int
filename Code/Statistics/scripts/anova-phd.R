#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder

library("dplyr") 

n="numeric"
f="factor"
dat<-read.delim("../db_final.tsv", colClasses=c(n,n,n,n,n,n,f,f,f,f,f,f))
d.all <- dat %>% select (! avg1.G.:avg2.G.)
d.emma <- d.all %>% filter ( enr != 0 ) 

phd.TCal.emma.aov<-aov(phd ~ TCal, data = d.emma)
print("ANOVA with EMMA samples: phd ~ TCal")
summary(phd.TCal.emma.aov)

phd.layr.emma.aov<-aov(phd ~ layr, data = d.emma)
print("ANOVA with EMMA samples: phd ~ layr")
summary(phd.layr.emma.aov)

phd.TDOC.emma.aov<-aov(phd ~ TDOC, data = d.emma)
print("ANOVA with EMMA samples: phd ~ TDOC")
summary(phd.TDOC.emma.aov)

phd.TvDOC.emma.aov<-aov(phd ~ TDOC:vDOC, data = d.emma)
print("ANOVA with EMMA samples: phd ~ TDOC:vDOC")
summary(phd.TvDOC.emma.aov)

phd.TCal.all.aov<-aov(phd ~ TCal, data = d.all)
print("ANOVA with all samples: phd ~ TCal")
summary(phd.TCal.all.aov)

phd.layr.all.aov<-aov(phd ~ layr, data = d.all)
print("ANOVA with all samples: phd ~ layr")
summary(phd.layr.all.aov)

phd.TDOC.all.aov<-aov(phd ~ TDOC, data = d.all)
print("ANOVA with all samples: phd ~ TDOC")
summary(phd.TDOC.all.aov)

phd.TvDOC.all.aov<-aov(phd ~ TDOC:vDOC, data = d.all)
print("ANOVA with all samples: phd ~ TDOC:vDOC")
summary(phd.TvDOC.all.aov)



