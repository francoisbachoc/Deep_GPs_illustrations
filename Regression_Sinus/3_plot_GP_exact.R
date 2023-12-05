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
points(Xt,myt,type="l",col="blue",cex=2.5)
points(Xt,myt+1.96*sqrt(diag(Cyt)),type="l",col="green",
       cex=2.5,lwd=3)
points(Xt,myt-1.96*sqrt(diag(Cyt)),type="l",col="green",
       cex=2.5,lwd=3)
dev.off()