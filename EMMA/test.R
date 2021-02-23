#library("session")
library("emma")
# GET TIMESTEP
t<-as.integer(readline(prompt="Which time step? "))
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

###########################################################
if (t==0){
	t0 <- emmat0(in.name, nlev, lower, upper, out.name, nd)
	print("experiments saved to t0")
	save<- readline(prompt="would you like to save the session?[yes/no] ")
	t<-1
	if (save == "y" | save == "yes"){
		t<-1
		save(list = ls(all.names = TRUE), file =".t0", envir = .GlobalEnv)
		print("session saved to .t0")
	}
} else {
	file<- paste(".t",as.character(t-1),sep="")
	load(file, envir = parent.frame(), verbose = FALSE)
	print(paste("restored time step ",as.character(t-1)," from file '.t",as.character(t-1),"'",sep=""))
	print("Please enter the responses")
	response<-c()
	if (t==1){
		tested<-t0$tested
	}else{
		tested<-tail(tn$tested,na)
	}
	for(i in tested){
		cat(paste("\n",i,"\n"))
		response<-append(response,scan(n=1,))
	}
	if (!t==0){
		response<-rbind(tn$ypop,data.frame(conductivity=response))
		print(tn$ypop)
	}else{
		response<-data.frame(conductivity=response)
	}
	print(response)
#	if(readline(prompt="should data be added to time frame 0?[y/n] ") == "y"){
		print("added")
		if (t==1){
			t0$ypop<-response
		}else{
			tn$ypop<-response
		}
		tn<-emmatn(as.integer(t),t0,graph=graph,opt=opt,weight=weight,na=na,pr.mut=pr.mut)
		print("experiments saved to tn")
		save<- readline(prompt="would you like to save the session?[yes/no] ")
		if (save == "y" | save == "yes"){
#			print(t)
			t<-t+1
#			print(t)
			#save.session(file=paste(".t",as.character(t-1),sep=""))
			file<-paste(".t",as.character(t-1),sep="")
			save(list = ls(all.names = TRUE), file =file, envir = .GlobalEnv)
			print(paste("session saved to .t",as.character(t-1),sep=""))
		}
}
	
