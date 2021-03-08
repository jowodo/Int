### todo: row names
###		- get f1$ypop

### to use 
####### open R 
### $ R
####### source this file
### > source ("inter.R")
####### make initial timestep t0
### > t0<-t0()
####### save chages and all vars to file
### > save.image("filename")
####### quit without saving workspace
### > quit()
####### maker experiments and reopen R
### $ R
####### feed experimental data
### > t0<-get.ypop(t0,t0)
####### get next experiments
### > t1<-get.next(t0)
########### e.g. for timestep = 3
####### feed experimental data
### > t3<-get.ypop(t3,t2)
####### get next experiments
### > t4<-get.next(t3)

### dependecies
### gfortran
### earth 
### emma





library("emma")
### META PARAMETERS
in.name <- 	c("conc",	"layr",	"vDOC",	"TDOC",	"vCal",	"TCal")
nlev <- 	c(4,		5,		6,		5,		5,		3)
lower <- 	c(2,		4,		10,		40,		120,	300)
upper <- 	c(5,		12,		20,		80,		1080,	500)
####
#out.name <- c("conductivity","pinhole density","layers","Cal_vel")
#weight <- c(0.3,0.5,0.05,0.05)	
#opt <- c("mn","mn","mn","mx")
####
#out.name <- c("conductivity")
#weight <- c(1)
#opt <- c("mn")
####
out.name <- c("conductivity","pinhole density")
weight <- c(0.3,0.5)
opt <- c("mn","mn")
nd <- 03# initial experiments
na <- 2		# exps per time step
graph="yes"
C<-10		# total number of timesteps
pr.mut <- c(0.1, 0.07, 0.04, rep(0.01, C-3))

t0<-function(){
	t0 <- emmat0(in.name, nlev, lower, upper, out.name, nd)
	return(t0)
}
### GET YPOP FROM PRECEDING TIMESTEP
get.ypop<-function(tn,t0){
	### PRINT XPOP and YPOP
	print(t0$ypop)
	print(tn$xpop)
	t<-tn$time
	### GET NEW RESPONSES
#	response<-data.frame(a=c(),b=c(),d=c(),e=c())
	response<-data.frame(a=c(),b=c())
#	response<-c()
	if (t==0){
		new.tested<-tn$tested
	}else{
		new.tested<-tail(tn$tested,na)
	}
	print(out.name)
	for(i in new.tested){
#		cat(paste("\n",i,"\n"))
		cat(paste(i, " "))
		#response<-append(response,list(scan(n=length(out.name),)))
#		print(class(response))
#		print(response)
		response<-rbind(response,(scan(n=length(out.name),)))
	}
	### APPEND NEW TO OLD RESPONSES
	#df.new.response<-data.frame(conductivity=response,row.names=new.tested)
	df.new.response<-data.frame(conductivity=response,row.names=new.tested)
	colnames(df.new.response)<-out.name
#	print(response)
#	print(new.tested)
#	df.new.response<-data.frame(column.names=out.name,response,row.names=new.tested)
#	df.new.response<-data.frame(out.name[1] =response[1],row.names=new.tested)
	if (t==0){
		# there is no previous responses
#		df.all.response<-data.frame(conductivity=response,row.names=new.tested)
		df.all.response<-df.new.response
	}else{
		# join with previous responses
#		df.all.response<-rbind(t0$ypop,data.frame(conductivity=response,row.names=new.tested))
		df.all.response<-rbind(t0$ypop,df.new.response)
#		print(tn$ypop)
	}
	print(df.all.response)
	return(df.all.response)
}

get.next<-function(tm){
	t<-tm$time+1
	#debug(emmatn)
	tn<-emmatn(t,tm,graph=graph,opt=opt,weight=weight,na=na,pr.mut=pr.mut)
	return(tn)
}
save_all<-function(filename){
	save(list = ls(all.names = TRUE), file =filename, envir = .GlobalEnv)
}
load_all<-function(filename){
	load(file=filename, envir = parent.frame(), verbose = FALSE)
}
