#!/usr/bin/env Rscript
#
# USAGE: ./anova-layr.R [--all] | grep -A1 -e "F value" --no-group-separator
suppressMessages(suppressWarnings(library("dplyr")))
only_emma<-1
args = commandArgs(trailingOnly=TRUE)
if ( length(args)==1 && (args[1]=="--all") ){only_emma<-0}
n="numeric"
f="factor"
dat=read.delim("../db_final.tsv", colClasses=c(n,n,n,n,n,n,f,n,f,f,f,f))
d.all = dat %>% select (! avg1.G.:avg2.G.)
d.emma = d.all %>% filter ( enr != 0 )
if (only_emma==1)
{
    layr.TCal.emma.aov<-aov(layr ~ TCal, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ TCal")
    print(summary(layr.TCal.emma.aov))
#
    layr.vCal.emma.aov<-aov(layr ~ vCal, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ vCal")
    print(summary(layr.vCal.emma.aov))
#
    layr.TvCal.emma.aov<-aov(layr ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ TCal:vCal")
    print(summary(layr.TvCal.emma.aov))
#
    suppressWarnings(layr.layr.emma.aov<-aov(layr ~ layr, data = d.emma))
    print("ANOVA with EMMA samples: layr ~ layr")
    print(summary(layr.layr.emma.aov))
#
    layr.conc.emma.aov<-aov(layr ~ conc, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ conc")
    print(summary(layr.conc.emma.aov))
#
    layr.lc.emma.aov<-aov(layr ~ layr:conc, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ layr:conc")
    print(summary(layr.lc.emma.aov))
#
    layr.TDOC.emma.aov<-aov(layr ~ TDOC, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ TDOC")
    print(summary(layr.TDOC.emma.aov))
#
    layr.vDOC.emma.aov<-aov(layr ~ vDOC, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ vDOC")
    print(summary(layr.vDOC.emma.aov))
#
    layr.TvDOC.emma.aov<-aov(layr ~ TDOC:vDOC, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ TDOC:vDOC")
    print(summary(layr.TvDOC.emma.aov))
}else{
    layr.TCal.all.aov<-aov(layr ~ TCal, data = d.all)
    print("ANOVA with ALL samples: layr ~ TCal")
    print(summary(layr.TCal.all.aov))
#
    layr.vCal.all.aov<-aov(layr ~ vCal, data = d.all)
    print("ANOVA with ALL samples: layr ~ vCal")
    print(summary(layr.vCal.all.aov))
#
    layr.TvCal.all.aov<-aov(layr ~ TCal:vCal, data = d.emma)
    print("ANOVA with EMMA samples: layr ~ TCal:vCal")
    print(summary(layr.TvCal.all.aov))
#
    suppressWarnings(layr.layr.all.aov<-aov(layr ~ layr, data = d.all))
    print("ANOVA with ALL samples: layr ~ layr")
    print(summary(layr.layr.all.aov))
#
    layr.conc.all.aov<-aov(layr ~ conc, data = d.all)
    print("ANOVA with ALL samples: layr ~ conc")
    print(summary(layr.conc.all.aov))
#
    layr.lc.all.aov<-aov(layr ~ layr:conc, data = d.all)
    print("ANOVA with ALL samples: layr ~ layr:conc")
    print(summary(layr.lc.all.aov))
#
    layr.TDOC.all.aov<-aov(layr ~ TDOC, data = d.all)
    print("ANOVA with ALL samples: layr ~ TDOC")
    print(summary(layr.TDOC.all.aov))
#
    layr.vDOC.all.aov<-aov(layr ~ vDOC, data = d.all)
    print("ANOVA with ALL samples: layr ~ vDOC")
    print(summary(layr.vDOC.all.aov))
#
    layr.TvDOC.all.aov<-aov(layr ~ TDOC:vDOC, data = d.all)
    print("ANOVA with ALL samples: layr ~ TDOC:vDOC")
    print(summary(layr.TvDOC.all.aov))
#
}



