rm(list = ls())
set.seed(1)
load("parameters.Rdata")

####################################
#Train and test data
####################################
Xt = (0:(nt-1))/(nt-1) #test input points
f = function(x) {  #density function with sum 1 on test data
  (2+sin(1/(1.1-x))) / mean((2+sin(1/(1.1-Xt))))
}

#sampling the training data from the (equispaced) test points,
#with weight proportional to unknown density f
X = sample(x=Xt,size=n,replace=TRUE,prob=f(Xt)/nt) 

pdf("data.pdf")  #plotting the unknwon density
plot(Xt,f(Xt),type="l",ylim=c(0,1.5))
dev.off()

pdf("data_hist.pdf")   #plotting the histogram of the training data
hist(X,breaks=10)
dev.off()




####################################
#Basis functions
####################################
phi = function(x,m) { 
  #From a vector x of size N, provides a N times m matrix
  #which rows are the vectors of the m hat basis function
  #values at the components of x
  res = matrix(nrow=length(x),ncol=m)
  for (j in 0:(m-1)) {
    res[,j+1] = ( (j-1)/(m-1) <= x )* ( x < j/(m-1) ) * (x - (j-1)/(m-1) )
    res[,j+1] = res[,j+1] + (  j/(m-1) <= x ) * ( x <= (j+1)/(m-1) )* ((j+1)/(m-1) - x )
  }
  res*(m-1)
}
Mt = phi(Xt,m)  #the hat basis function values at test input points
Mn = phi(X,m)  #and at train input points
Xm = (0:(m-1))/(m-1) #The vector of m location of the hats 

pdf("phi.pdf")  #plotting hat basis functions for sanity check
plot(Xt , Mt[,1] , col=1)
for (j in 2:m) {
  points(Xt , Mt[,j] , col=j)
}
dev.off()





save(f,X,Xt,phi,Mn,Mt,Xm,file="data.Rdata")






