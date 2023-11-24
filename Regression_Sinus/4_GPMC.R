rm(list = ls())
set.seed(1)
library(emdbook)
library(mcmc)
load("parameters.Rdata")
load("data.Rdata")

#m times m covariance matrix of GP values at knots
R1 = sigmapar^2*exp(- outer(Xm,Xm,"-")^2 / lc^2) + 10^(-8)*diag(m)

#Gaussian log posterior likelihood of the m times 1 vector alpha
#of GP values at the knots
lpostGP = function(alpha) {
  res = dmvnorm(x=alpha,mu=rep(0,m),Sigma=R1,log=TRUE)
  res = res + dmvnorm(x=y,mu=as.vector(phi(X,m)%*%alpha),
                      Sigma=sdn^2*diag(n),log=TRUE)
  res
}

scale = t(chol(R1))*0.05  #scale of the proposal for HM
#run of the HM procedure: 
#For nbatch = 30 000: a few minutes
outGP<-metrop(lpostGP,rep(0,m),nbatch,scale=scale) 
samplesAlpha = outGP$batch #The sampled vectors of knot
                          #GP values of size m
#We keep only the second half to represent the posterior:
indKeep = seq(from=nbatch/2,length=nbatch/2,by=1)
#Matrix of samples of values of f obtained by phi at
#the test inputs:
samplesf = matrix(nrow=length(indKeep),ncol=nt)
for (i in 1:length(indKeep)) {
  samplesf[i,] = phi(Xt,m)%*%samplesAlpha[indKeep[i],]
}
#mean, lower and upper quantile at each test inputs:
mytGP = colMeans(samplesf)
qitGP = apply(samplesf,2,quantile,probs = 0.025)
qstGP = apply(samplesf,2,quantile,probs = 0.975)

save(lpostGP,nbatch,scale,outGP,samplesAlpha,indKeep,
     samplesf,mytGP,qitGP,qstGP,file=name)








