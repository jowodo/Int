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
nd <- 2	# initial experiments
na <- 1		# exps per time step
weight <- c(1)	
graph="no"
C<-10
pr.mut <- c(0.1, 0.07, 0.04, rep(0.01, C-3))

f0<-function(){
	t0 <- emmat0(in.name, nlev, lower, upper, out.name, nd)
	return(t0)
}
get_ypop<-function(tn){
	t<-tn$time
	### GET NEW RESPONSES
	response<-c()
	if (t==0){
		tested<-tn$tested
	}else{
		tested<-tail(tn$tested,na)
	}
	for(i in tested){
		cat(paste("\n",i,"\n"))
		response<-append(response,scan(n=1,))
	}
	### APPEND NEW TO OLD RESPONSES
	if (!t==0){
		response<-rbind(tn$ypop,data.frame(conductivity=response))
		print(tn$ypop)
	}else{
		response<-data.frame(conductivity=response)
	}
	print(response)
	return(response)
}

get_exps<-function(tn){
	t<-tn$time+1
	tn<-emmatn(t,tn,graph=graph,opt=opt,weight=weight,na=na,pr.mut=pr.mut)
	return(tn)
}
