#!/usr/bin/env Rscript
#
# USAGE: execute script from within the folder

library("dplyr")
library("earth")

dat<-read.delim("../db_final.tsv") 
d.all <- dat %>% select ( ! avg1.G.:avg2.G.) 
x.all <- d.all %>% select(conc:TCal)
y.all <- d.all %>% select( G:phd)
mars.all <- earth ( x.all, y.all)
print("MARS model for all samples") 
format(mars.all)

d.emma <- d.all %>% filter ( enr != 0 ) 
x.emma <- d.emma %>% select(conc:TCal)
y.emma <- d.emma %>% select( G:phd)
mars.emma <- earth ( x.emma, y.emma)
print("MARS model for EMMA samples")
format(mars.emma)

d.hot <- d.all %>% filter ( TCal != 300 ) 
x.hot <- d.hot %>% select(conc:TCal)
y.hot <- d.hot %>% select( G:phd)
mars.hot <- earth ( x.hot, y.hot)
print("MARS model for all samles with TCal>300")
format(mars.hot)

