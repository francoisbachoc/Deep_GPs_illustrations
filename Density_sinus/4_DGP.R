rm(list = ls())
set.seed(1)
library(emdbook)
library(mcmc)
load("parameters.Rdata")
load("data.Rdata")

#covariance matrix of inner GP values at the m knots
Rint = sigmaint^2*exp(- outer(Xm,Xm,"-")^2 / lcint^2) + 10^(-8)*diag(m)
#covariance matrix of outer GP values at the m knots
Rext = sigmaext^2*exp(- outer(Xm,Xm,"-")^2 / lcext^2) + 10^(-8)*diag(m)

#Gaussian log prior of inner GP values at the m knots
lpriorGPint = function(alpha) {
  alpha = as.vector(alpha)
  if (max(abs(alpha-0.5)) <0.5) { #The inner GP output should not
    #leave [0,1] where the outer GP is defined
    res = dmvnorm(x=alpha,mu=muint,Sigma=Rint,log=TRUE)
  }
  else {
    res = - Inf
  }
  res
}

#Gaussian log prior of outer GP values at the m knots:
lpriorGPext = function(alpha) {
  alpha = as.vector(alpha)
  dmvnorm(x=alpha,mu=rep(0,m),Sigma=Rext,log=TRUE)
}

#Compute the DGP output density at inputs x defined by phi matrix
#mphix, from values alphaint at the inner knots
#and alphaext at the outer knots
#The normalization provides mean one at the test points represented
#by the phi matrix mphit
densDGP = function(mphix,mphit,alphaint,alphaext) {
  alphaint = matrix(nrow=m,ncol=1,data=alphaint)
  alphaext = matrix(nrow=m,ncol=1,data=alphaext)
  scorex = as.vector(phi(mphix%*%alphaint,m)%*%alphaext)
  scoret = as.vector(phi(mphit%*%alphaint,m)%*%alphaext)
  exp(scorex) / mean(exp(scoret))
}

#log likelihood function of the intputs given 
#alphaint and alphaext as above
llik = function(alphaint,alphaext) {
  sum(log(densDGP(Mn,Mt,alphaint,alphaext))) 
}

#log posterior density from vector alpha which first half
#corresponds to alphaint above and which second
#half corresponds to alphaext above
lpostDGP = function(alpha) {
  alphaint = alpha[1:m]
  alphaext = alpha[(m+1):(2*m)]
  lpriorGPint(alphaint) + lpriorGPext(alphaext) + llik(alphaint,alphaext)
}

scale = diag(2*m)  #scale matrix for HM proposal distribution
scale[(1:m),(1:m)] = t(chol(Rint))*0.05 #for inner GP
#for outer GP:
scale[((m+1):(2*m)),((m+1):(2*m))] = t(chol(Rext))*0.05
alphainitint = muint #initialization of HM for inner GP
alphainitext = rep(0,m)   #and for outer GP
alphainit = c(alphainitint,alphainitext)

#run of the HM procedure: 
#For nbatch = 30 000: a few minutes
outDGP<-metrop(lpostDGP,alphainit,nbatch,scale=scale)

samplesAlphaDGP = outDGP$batch #the alphas sampled by HM
#We keep the second half of them to represent the posterior:
indKeepDGP = seq(from=nbatch/2,length=nbatch/2,by=1)
#The corresponding regression function values at the
#test points:
samplesfDGP = matrix(nrow=length(indKeepDGP),ncol=nt)
for (i in 1:length(indKeepDGP)) {
  alphaint = samplesAlphaDGP[indKeepDGP[i],(1:m)]
  alphaext = samplesAlphaDGP[indKeepDGP[i],((m+1):(2*m))]
  samplesfDGP[i,] = densDGP(Mt,Mt,alphaint,alphaext)
}
#mean, lower and upper quantile at each test inputs:
mytDGP = colMeans(samplesfDGP)
qitDGP = apply(samplesfDGP,2,quantile,probs = 0.025)
qstDGP = apply(samplesfDGP,2,quantile,probs = 0.975)

save(lpostDGP,nbatch,scale,outDGP,samplesAlphaDGP,indKeepDGP,
     samplesfDGP,mytDGP,densDGP,qitDGP,qstDGP,file=name)









