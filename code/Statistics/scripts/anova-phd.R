#!/usr/bin/env Rscript
#
# USAGE: ./anova-phd.R [--all] | grep -A1 -e "F value" --no-group-separator
suppressMessages(suppressWarnings(library("dplyr")))
only_emma<-1
args = commandArgs(trailingOnly=TRUE)
if ( length(args)==1 && (args[1]=="--all") ){only_emma<-0}
n="numeric"
f="factor"
dat=read.delim("../db_final.tsv", colClasses=c(n,n,n,n,n,n,f,f,f,f,f,f))
d.all = dat %>% select (! avg1.G.:avg2.G.)
d.emma = d.all %>% filter ( enr != 0 )
if (only_emma==1)
{
    phd.TCal.emma.aov<-aov(phd ~ TCal, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ TCal")
    print(summary(phd.TCal.emma.aov))
#
    phd.vCal.emma.aov<-aov(phd ~ vCal, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ vCal")
    print(summary(phd.vCal.emma.aov))
#
    phd.TvCal.emma.aov<-aov(phd ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ TCal:vCal")
    print(summary(phd.TvCal.emma.aov))
#
    phd.layr.emma.aov<-aov(phd ~ layr, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ layr")
    print(summary(phd.layr.emma.aov))
#
    phd.conc.emma.aov<-aov(phd ~ conc, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ conc")
    print(summary(phd.conc.emma.aov))
#
    phd.lc.emma.aov<-aov(phd ~ layr:conc, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ layr:conc")
    print(summary(phd.lc.emma.aov))
#
    phd.TDOC.emma.aov<-aov(phd ~ TDOC, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ TDOC")
    print(summary(phd.TDOC.emma.aov))
#
    phd.vDOC.emma.aov<-aov(phd ~ vDOC, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ vDOC")
    print(summary(phd.vDOC.emma.aov))
#
    phd.TvDOC.emma.aov<-aov(phd ~ TDOC:vDOC, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ TDOC:vDOC")
    print(summary(phd.TvDOC.emma.aov))
}else{
    phd.TCal.all.aov<-aov(phd ~ TCal, data = d.all)
    print("ANOVA with ALL samples: phd ~ TCal")
    print(summary(phd.TCal.all.aov))
#
    phd.vCal.all.aov<-aov(phd ~ vCal, data = d.all)
    print("ANOVA with ALL samples: phd ~ vCal")
    print(summary(phd.vCal.all.aov))
#
    phd.TvCal.all.aov<-aov(phd ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: phd ~ TCal:vCal")
    print(summary(phd.TvCal.all.aov))
#
    phd.layr.all.aov<-aov(phd ~ layr, data = d.all)
    print("ANOVA with ALL samples: phd ~ layr")
    print(summary(phd.layr.all.aov))
#
    phd.conc.all.aov<-aov(phd ~ conc, data = d.all)
    print("ANOVA with ALL samples: phd ~ conc")
    print(summary(phd.conc.all.aov))
#
    phd.lc.all.aov<-aov(phd ~ layr:conc, data = d.all)
    print("ANOVA with ALL samples: phd ~ layr:conc")
    print(summary(phd.lc.all.aov))
#
    phd.TDOC.all.aov<-aov(phd ~ TDOC, data = d.all)
    print("ANOVA with ALL samples: phd ~ TDOC")
    print(summary(phd.TDOC.all.aov))
#
    phd.vDOC.all.aov<-aov(phd ~ vDOC, data = d.all)
    print("ANOVA with ALL samples: phd ~ vDOC")
    print(summary(phd.vDOC.all.aov))
#
    phd.TvDOC.all.aov<-aov(phd ~ TDOC:vDOC, data = d.all)
    print("ANOVA with ALL samples: phd ~ TDOC:vDOC")
    print(summary(phd.TvDOC.all.aov))
#
}



