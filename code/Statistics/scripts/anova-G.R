#!/usr/bin/env Rscript
#
# USAGE: ./anova-G.R [--all] | grep -A1 -e "F value" --no-group-separator
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
    G.TCal.emma.aov<-aov(G ~ TCal, data = d.emma)
    print("ANOVA with EMMA samples: G ~ TCal")
    print(summary(G.TCal.emma.aov))
#
    G.vCal.emma.aov<-aov(G ~ vCal, data = d.emma)
    print("ANOVA with EMMA samples: G ~ vCal")
    print(summary(G.vCal.emma.aov))
#
    G.TvCal.emma.aov<-aov(G ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: G ~ TCal:vCal")
    print(summary(G.TvCal.emma.aov))
#
    G.layr.emma.aov<-aov(G ~ layr, data = d.emma)
    print("ANOVA with EMMA samples: G ~ layr")
    print(summary(G.layr.emma.aov))
#
    G.conc.emma.aov<-aov(G ~ conc, data = d.emma)
    print("ANOVA with EMMA samples: G ~ conc")
    print(summary(G.conc.emma.aov))
#
    G.lc.emma.aov<-aov(G ~ layr:conc, data = d.emma)
    print("ANOVA with EMMA samples: G ~ layr:conc")
    print(summary(G.lc.emma.aov))
#
    G.TDOC.emma.aov<-aov(G ~ TDOC, data = d.emma)
    print("ANOVA with EMMA samples: G ~ TDOC")
    print(summary(G.TDOC.emma.aov))
#
    G.vDOC.emma.aov<-aov(G ~ vDOC, data = d.emma)
    print("ANOVA with EMMA samples: G ~ vDOC")
    print(summary(G.vDOC.emma.aov))
#
    G.TvDOC.emma.aov<-aov(G ~ TDOC:vDOC, data = d.emma)
    print("ANOVA with EMMA samples: G ~ TDOC:vDOC")
    print(summary(G.TvDOC.emma.aov))
}else{
    G.TCal.all.aov<-aov(G ~ TCal, data = d.all)
    print("ANOVA with ALL samples: G ~ TCal")
    print(summary(G.TCal.all.aov))
#
    G.vCal.all.aov<-aov(G ~ vCal, data = d.all)
    print("ANOVA with ALL samples: G ~ vCal")
    print(summary(G.vCal.all.aov))
#
    G.TvCal.all.aov<-aov(G ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: G ~ TCal:vCal")
    print(summary(G.TvCal.all.aov))
#
    G.layr.all.aov<-aov(G ~ layr, data = d.all)
    print("ANOVA with ALL samples: G ~ layr")
    print(summary(G.layr.all.aov))
#
    G.conc.all.aov<-aov(G ~ conc, data = d.all)
    print("ANOVA with ALL samples: G ~ conc")
    print(summary(G.conc.all.aov))
#
    G.lc.all.aov<-aov(G ~ layr:conc, data = d.all)
    print("ANOVA with ALL samples: G ~ layr:conc")
    print(summary(G.lc.all.aov))
#
    G.TDOC.all.aov<-aov(G ~ TDOC, data = d.all)
    print("ANOVA with ALL samples: G ~ TDOC")
    print(summary(G.TDOC.all.aov))
#
    G.vDOC.all.aov<-aov(G ~ vDOC, data = d.all)
    print("ANOVA with ALL samples: G ~ vDOC")
    print(summary(G.vDOC.all.aov))
#
    G.TvDOC.all.aov<-aov(G ~ TDOC:vDOC, data = d.all)
    print("ANOVA with ALL samples: G ~ TDOC:vDOC")
    print(summary(G.TvDOC.all.aov))
#
}



