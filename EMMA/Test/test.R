#vec=c(13241,12341,31254,435,3245,32145)
#cat("\n","Enter all responses for",vec,"\n")
#{
#x<-scan()
#}
#print(paste("These are the responses"))
#print(x)

t<-as.integer(readline(prompt="Which time step? "))
f<-function(x)
{
	print(x)
}

switch(t,
	   "1" = f("first"),
	   "2" = f("second")
)

if (t == 1){
	f("first first")
} else if (t==2){
	f("second seco")
}
	
