#!/usr/bin/env Rscript
#
# USAGE: ./anova-G.R [--all] | grep -A1 -e "F value" --no-group-separator
suppressMessages(suppressWarnings(library("dplyr")))
only_emma<-1
args = commandArgs(trailingOnly=TRUE)
if ( length(args)==1 && (args[1]=="--all") ){only_emma<-0}
n="numeric"
f="factor"
dat=read.delim("../db_final.tsv", colClasses=c(n,n,n,n,n,n,n,n,n,n,n,n))
d.all = dat %>% select (! avg1.G.:avg2.G.)
if (only_emma==1)
{
    d.all = d.all %>% filter ( enr != 0 )
}
X=d.all%>% select(conc,layr,vCal,TCal,vDOC,TDOC)

lin.mod<- lm (cbind(d.all$G,d.all$phd) ~ conc+layr+vCal+TCal+vDOC+TDOC, data=d.all)
summary(lin.mod)
exit 0
