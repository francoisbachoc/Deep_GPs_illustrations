rm(list = ls())
set.seed(1)
load("parameters.Rdata")
load("data.Rdata")

load(name)
pdf(nameFig) 
plot(Xt,f(Xt),type="l",col="black",ylim=c(0,1.5),
     cex.axis=1.5,cex.lab=1.5,cex=1.5,
     xlab="x",ylab="f")
points(Xt,mytGP,type="l",col="blue",cex=1.5)
points(Xt,qitGP,type="l",col="green",
       cex=1.5)
points(Xt,qstGP,type="l",col="green",
       cex=1.5)
dev.off()
