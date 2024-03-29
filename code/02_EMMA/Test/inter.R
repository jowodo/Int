### todo: row names
###		- get f1$ypop


library("emma")
### META PARAMETERS
in.name <- c("conc", "layr", "vDOC", "TDOC", "vCal", "TCal")
nlev <- c(5,7,4,5,4,3)
lower <- c(1,4,5,40,120,400)
upper <- c(5,10,20,80,480,500)
out.name <- c("conductivity")
opt <- c("mn")
nd <- 8# initial experiments
na <- 4		# exps per time step
weight <- c(1)	
graph="no"
C<-10
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
	response<-c()
	if (t==0){
		new.tested<-tn$tested
	}else{
		new.tested<-tail(tn$tested,na)
	}
	for(i in new.tested){
#		cat(paste("\n",i,"\n"))
		cat(paste(i, " "))
		response<-append(response,scan(n=1,))
	}
	### APPEND NEW TO OLD RESPONSES
	df.new.response<-data.frame(conductivity=response,row.names=new.tested)
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

get.next<-function(tn){
	t<-tn$time+1
	tn<-emmatn(t,tn,graph=graph,opt=opt,weight=weight,na=na,pr.mut=pr.mut)
	return(tn)
}
save_all<-function(filename){
	save(list = ls(all.names = TRUE), file =filename, envir = .GlobalEnv)
}
load_all<-function(filename){
	load(file=filename, envir = parent.frame(), verbose = FALSE)
}
