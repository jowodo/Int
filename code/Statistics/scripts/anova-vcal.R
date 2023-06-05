#!/usr/bin/env Rscript
#
# USAGE: ./anova-vCal.R [--all] | grep -A1 -e "F value" --no-group-separator
suppressMessages(suppressWarnings(library("dplyr")))
only_emma<-1
args = commandArgs(trailingOnly=TRUE)
if ( length(args)==1 && (args[1]=="--all") ){only_emma<-0}
n="numeric"
f="factor"
dat=read.delim("../db_final.tsv", colClasses=c(n,n,n,n,n,n,f,f,f,f,n,f))
d.all = dat %>% select (! avg1.G.:avg2.G.)
d.emma = d.all %>% filter ( enr != 0 )
if (only_emma==1)
{
    vCal.TCal.emma.aov<-aov(vCal ~ TCal, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ TCal")
    print(summary(vCal.TCal.emma.aov))
#
    suppressWarnings(vCal.vCal.emma.aov<-aov(vCal ~ vCal, data = d.emma))
    print("ANOVA with EMMA samples: vCal ~ vCal")
    print(summary(vCal.vCal.emma.aov))
#
    vCal.TvCal.emma.aov<-aov(vCal ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ TCal:vCal")
    print(summary(vCal.TvCal.emma.aov))
#
    vCal.layr.emma.aov<-aov(vCal ~ layr, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ layr")
    print(summary(vCal.layr.emma.aov))
#
    vCal.conc.emma.aov<-aov(vCal ~ conc, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ conc")
    print(summary(vCal.conc.emma.aov))
#
    vCal.lc.emma.aov<-aov(vCal ~ layr:conc, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ layr:conc")
    print(summary(vCal.lc.emma.aov))
#
    vCal.TDOC.emma.aov<-aov(vCal ~ TDOC, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ TDOC")
    print(summary(vCal.TDOC.emma.aov))
#
    vCal.vDOC.emma.aov<-aov(vCal ~ vDOC, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ vDOC")
    print(summary(vCal.vDOC.emma.aov))
#
    vCal.TvDOC.emma.aov<-aov(vCal ~ TDOC:vDOC, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ TDOC:vDOC")
    print(summary(vCal.TvDOC.emma.aov))
}else{
    vCal.TCal.all.aov<-aov(vCal ~ TCal, data = d.all)
    print("ANOVA with ALL samples: vCal ~ TCal")
    print(summary(vCal.TCal.all.aov))
#
    suppressWarnings(vCal.vCal.all.aov<-aov(vCal ~ vCal, data = d.all))
    print("ANOVA with ALL samples: vCal ~ vCal")
    print(summary(vCal.vCal.all.aov))
#
    vCal.TvCal.all.aov<-aov(vCal ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: vCal ~ TCal:vCal")
    print(summary(vCal.TvCal.all.aov))
#
    vCal.layr.all.aov<-aov(vCal ~ layr, data = d.all)
    print("ANOVA with ALL samples: vCal ~ layr")
    print(summary(vCal.layr.all.aov))
#
    vCal.conc.all.aov<-aov(vCal ~ conc, data = d.all)
    print("ANOVA with ALL samples: vCal ~ conc")
    print(summary(vCal.conc.all.aov))
#
    vCal.lc.all.aov<-aov(vCal ~ layr:conc, data = d.all)
    print("ANOVA with ALL samples: vCal ~ layr:conc")
    print(summary(vCal.lc.all.aov))
#
    vCal.TDOC.all.aov<-aov(vCal ~ TDOC, data = d.all)
    print("ANOVA with ALL samples: vCal ~ TDOC")
    print(summary(vCal.TDOC.all.aov))
#
    vCal.vDOC.all.aov<-aov(vCal ~ vDOC, data = d.all)
    print("ANOVA with ALL samples: vCal ~ vDOC")
    print(summary(vCal.vDOC.all.aov))
#
    vCal.TvDOC.all.aov<-aov(vCal ~ TDOC:vDOC, data = d.all)
    print("ANOVA with ALL samples: vCal ~ TDOC:vDOC")
    print(summary(vCal.TvDOC.all.aov))
#
}



