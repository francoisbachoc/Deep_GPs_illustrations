rm(list = ls())
set.seed(1)
load("parameters.Rdata")
load("data.Rdata")

load(name)
pdf(nameFig1) 
plot(Xt,f(Xt),type="l",col="black",ylim=c(0,1.5),
     cex.axis=1.5,cex.lab=1.5,cex=1.5,
     xlab="x",ylab="f")
points(Xt,mytDGP,type="l",col="blue",cex=1.5)
points(Xt,qitDGP,type="l",col="green",
       cex=1.5)
points(Xt,qstDGP,type="l",col="green",
       cex=1.5)
dev.off()

pdf(nameFig2) 
plot(Xt,phi(Xt,m)%*%samplesAlphaDGP[indKeepDGP[sample(x=nbatch/2,size=1)],1:m],
     type="l",ylim=c(0,1),cex.axis=1.5,cex.lab=1.5,
     cex=1.5,xlab="x",ylab="Z1")
points(Xt,phi(Xt,m)%*%samplesAlphaDGP[indKeepDGP[sample(x=nbatch/2,size=1)],1:m],
       type="l",col="blue")
points(Xt,phi(Xt,m)%*%samplesAlphaDGP[indKeepDGP[sample(x=nbatch/2,size=1)],1:m],
       type="l",col="red")
dev.off()