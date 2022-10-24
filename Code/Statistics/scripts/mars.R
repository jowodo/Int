#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder

suppressMessages(suppressWarnings(library("dplyr")))
suppressMessages(suppressWarnings(library("earth")))

dat<-read.delim("../db_final.tsv") 
d.all <- dat %>% select ( ! avg1.G.:avg2.G.) 
x.all <- d.all %>% select(conc:TCal)
#y.all <- d.all %>% select( G:phd)
#y.all <- d.all %>% mutate(vC6=vCal*60) %>% select(G,phd,layr,vC6)
y.all <- d.all %>% select(G,phd,layr,vCal)
mars.all <- earth ( x.all, y.all, degree=2)
print("MARS model for all samples") 
format(mars.all)

d.emma <- d.all %>% filter ( enr != 0 ) 
x.emma <- d.emma %>% select(conc:TCal)
y.emma <- d.emma %>% mutate(vC6=vCal*60) %>% select(G,phd,layr,vC6)
mars.emma <- earth ( x.emma, y.emma, degree=2)
print("MARS model for EMMA samples")
format(mars.emma)

d.hot <- d.all %>% filter ( TCal != 300 ) 
x.hot <- d.hot %>% select(conc:TCal)
y.hot <- d.hot %>% mutate(vC6=vCal*60) %>% select(G,phd,layr,vC6)
mars.hot <- earth ( x.hot, y.hot, degree=2)
print("MARS model for all samles with TCal>300")
format(mars.hot)

