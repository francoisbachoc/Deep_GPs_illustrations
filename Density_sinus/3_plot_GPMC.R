rm(list = ls())
set.seed(1)
load("parameters.Rdata")
load("data.Rdata")

load(name)
pdf(nameFig) 
par(mar = c(6, 6, 6, 6))
plot(Xt,f(Xt),type="l",col="black",ylim=c(0,1.5),
     cex.axis=2.5,cex.lab=2.5,cex=2.5,lwd=3,
     xlab="x",ylab="f")
points(Xt,mytGP,type="l",col="blue",cex=1.5,lwd=3)
points(Xt,qitGP,type="l",col="green",
       cex=1.5,lwd=3)
points(Xt,qstGP,type="l",col="green",
       cex=1.5,lwd=3)
dev.off()
