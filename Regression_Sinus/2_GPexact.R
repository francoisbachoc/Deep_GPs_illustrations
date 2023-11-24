rm(list = ls())
set.seed(1)
load("parameters.Rdata")
load("data.Rdata")

#m times m covariance matrix of GP values at knots
R1 = sigmapar*exp(- outer(Xm,Xm,"-")^2 / lc^2)
#Conditional mean of these values at knots
ma1 = R1%*%t(Mn)%*%solve(Mn%*%R1%*%t(Mn)+sdn^2*diag(n))%*%y
#and conditional covariance 
Ca1 = R1 - R1%*%t(Mn)%*%solve(Mn%*%R1%*%t(Mn)+sdn^2*diag(n))%*%Mn%*%R1
#using phi to obtain conditional mean at test inputs 
myt = phi(Xt,m)%*%ma1 
#and conditional covariance
Cyt = phi(Xt,m)%*%Ca1%*%t(phi(Xt,m))

save(R1,ma1,Ca1,myt,Cyt,file=name)











