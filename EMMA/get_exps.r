"Hello world"
library("emma")
library("session")

in.name <- c("conc", "layr", "vDOC", "TDOC", "vCal", "TCal")
nlev <- c(5,rep(4,4),3)
lower <- c(1,4,5,20,120,400)
upper <- c(5,10,20,80,480,500)
out.name <- c("resistance")
opt <- c("mx")
nd <- 10	# initial experiments
na <- 5		# exps per time step
weight <- c(1)	
C <- 10		# max iterations
pr.mut <- c(0.1, 0.07, 0.04, rep(0.01, C-3))
w1 <- 0.7
w2 <- 0.4
c1i <- 2.5
c1f <- 0.5
c2i <- 0.5
c2f <- 2.5
b <- 5
graph <- "no"
fn1 <- NULL
fn2 <- NULL
fn3 <- NULL
fn4 <- NULL
nresp <- 1

#emma(in.name, nlev, lower, upper, out.name, opt, nd, na, weight, C, w1, w2, c1i, c1f, c2i, c2f, b, pr.mut, graph)
var <- emmat0(in.name, nlev, lower, upper, out.name, nd)

save.session(file=".RSession")
