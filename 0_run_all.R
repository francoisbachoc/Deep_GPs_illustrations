##########
#Common parameters to all simulations
##########
n=100 #number train data
m=30  #number of basis functions
nt=1000  #number test data
sdn=0.1  #standard deviation of observation noise
nbatch=100000 #number of MCMC samples
#
save(n,m,nt,sdn,nbatch,file="parameters.Rdata")
source("1_genData.R")

##########
#A simulation and its plot
##########
sigmapar = 1 #GP standard deviation
lc = 0.2 #GP correlation length
##############
name=paste("Regression_GPexact_sigma",sigmapar,"_lc",
           lc,".Rdata",sep="")
nameFig=paste("Regression_GPexact_sigma",sigmapar,"_lc",
              lc,".pdf",sep="")
save(n,m,nt,sdn,sigmapar,lc,name,nameFig,nbatch,
     file="parameters.Rdata")
source("2_GPexact.R")
source("3_plot_GP_exact.R")

##########
#A simulation and its plot
##########
sigmapar = 10 #GP standard deviation
lc = 0.2 #GP correlation length
##############
name=paste("Regression_GPexact_sigma",sigmapar,"_lc",
           lc,".Rdata",sep="")
nameFig=paste("Regression_GPexact_sigma",sigmapar,"_lc",
              lc,".pdf",sep="")
save(n,m,nt,sdn,sigmapar,lc,name,nameFig,nbatch,
     file="parameters.Rdata")
source("2_GPexact.R")
source("3_plot_GP_exact.R")


##########
#A simulation and its plot
##########
sigmapar = 1 #GP standard deviation
lc = 0.05 #GP correlation length
##############
name=paste("Regression_GPexact_sigma",sigmapar,"_lc",
           lc,".Rdata",sep="")
nameFig=paste("Regression_GPexact_sigma",sigmapar,"_lc",
              lc,".pdf",sep="")
save(n,m,nt,sdn,sigmapar,lc,name,nameFig,nbatch,
     file="parameters.Rdata")
source("2_GPexact.R")
source("3_plot_GP_exact.R")

##########
#A simulation and its plot
##########
sigmapar = 1 #GP standard deviation
lc = 0.2 #GP correlation length
##############w
name=paste("Regression_GPMC_sigma",sigmapar,"_lc",
           lc,".Rdata",sep="")
nameFig=paste("Regression_GPMC_sigma",sigmapar,"_lc",
              lc,".pdf",sep="")
save(n,m,nt,sdn,sigmapar,lc,name,nameFig,nbatch,
     file="parameters.Rdata")
source("4_GPMC.R")
source("5_plot_GPMC.R")

##########
#A simulation and its plot
##########
sigmaint = 0.3 #inner GP standard deviation
lcint = 0.3 #inner GP correlation length
muint = seq(from=0.25,to=0.75,length=m) #inner GP mean vector
             #at the m knots
sigmaext = 1 #outer GP standard deviation
lcext =  0.1 #outer GP correlation length
##############w
name="Regression_DGP.Rdata"
nameFig1="Regression_DGP.pdf"
nameFig2="Regression_DGP_latent.pdf"
save(n,m,nt,sdn,sigmaint,lcint,muint,
     sigmaext,lcext,name,nameFig1,nameFig2,nbatch,
     file="parameters.Rdata")
source("6_DGP.R")
source("7_plot_DGP.R")
