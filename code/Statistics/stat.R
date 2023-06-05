dat<-read.delim("./db_final.tsv") 
summary(dat)
hist(dat$G)
str(dat)
boxplot(dat$G)
boxplot(dat$G ~ dat$TCal )
boxplot(dat$G ~ dat$TCal, xlab="Calcination Temp [C]", ylab="Resistance") 
#library("vioplot") 
#library("ggplot2")
mod<-lm(dat$G ~ dat$TCal)
plot(dat$G ~ dat$TCal)

# https://www.rdocumentation.org/packages/dplyr/versions/1.0.10
d.all <- dat %>% select ( ! avg1.G.:avg2.G.) 
x.all <- d.all %>% select(conc:TCal)
y.all <- d.all %>% select( G:phd)
mars.all <- earth ( x.all, y.all)
format(mars.all)

d.emma <- d.all %>% filter ( enr != 0 ) 
x.emma <- d.emma %>% select(conc:TCal)
y.emma <- d.emma %>% select( G:phd)
mars.emma <- earth ( x.emma, y.emma)
format(mars.emma)

d.hot <- d.all %>% filter ( TCal != 300 ) 
x.hot <- d.hot %>% select(conc:TCal)
y.hot <- d.hot %>% select( G:phd)
mars.hot <- earth ( x.hot, y.hot)
format(mars.hot)

# TODO 
# plot earth fit
# plot a curve
# curve((x-1)/(x^2),from=0, to=20,ylab="y")
