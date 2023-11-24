rm(list = ls())
set.seed(1)
library(emdbook)
library(mcmc)
load("parameters.Rdata")
load("data.Rdata")


#m times m covariance matrix of GP values at knots
R1 = sigmapar^2*exp(- outer(Xm,Xm,"-")^2 / lc^2) + 10^(-8)*diag(m)

#compute the values of the density:normalized exp(GP) 
#the density is computed at x represented by the matrix mphix
#of basis function values
#The normalization is so that the mean is one if x=t
#where mphit is the matrix of hat basis function values at
#the test points
densGP = function(mphix,mphit,alpha) {
  scorex = as.vector(mphix%*%alpha)
  scoret = as.vector(mphit%*%alpha)
  exp(scorex) / mean(exp(scoret))
}

#The log posterior for a GP model of a density
#the log Gaussian prior +
#the sum of log density at the training points 
#that are represented by the matrix Mn of hat basis
#function values
lpostGP = function(alpha) {
  res = dmvnorm(x=alpha,mu=rep(0,m),Sigma=R1,log=TRUE)
  res = res + sum(log(densGP(Mn,Mt,alpha))) 
  res
}

scale = t(chol(R1))*0.1 #scale of the proposal for HM
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
  alpha = samplesAlpha[indKeep[i],]
  samplesf[i,] = densGP(Mt,Mt,alpha)
}
#mean, lower and upper quantile at each test inputs:
mytGP = colMeans(samplesf)
qitGP = apply(samplesf,2,quantile,probs = 0.025)
qstGP = apply(samplesf,2,quantile,probs = 0.975)

save(lpostGP,nbatch,scale,outGP,samplesAlpha,indKeep,
     samplesf,mytGP,qitGP,qstGP,densGP,R1,file=name)








