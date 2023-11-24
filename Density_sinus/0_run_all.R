##########
#Common parameters to all simulations
##########
n=2000 #number train data
m=30  #number of basis functions
nt=1000  #number test data
nbatch=100000 #number of MCMC samples
#
save(n,m,nt,nbatch,file="parameters.Rdata")
source("1_genData.R")


##########
#A simulation and its plot
##########
sigmapar = 1 #GP standard deviation
lc = 0.2 #GP correlation length
##############w
name=paste("Densite_GPMC_sigma",sigmapar,"_lc",
           lc,".Rdata",sep="")
nameFig=paste("Densite_GPMC_sigma",sigmapar,"_lc",
              lc,".pdf",sep="")
save(n,m,nt,sigmapar,lc,name,nameFig,nbatch,
     file="parameters.Rdata")
source("2_GPMC.R")
source("3_plot_GPMC.R")

##########
#A simulation and its plot
##########
sigmaint = 0.3 #inner GP standard deviation
lcint = 0.3 #inner GP correlation length
muint = seq(from=0.25,to=0.75,length=m) #inner GP mean vector
             #at the m knots
sigmaext = 1 #outer GP standard deviation
lcext =  0.1 #outer GP correlation length
##############
name="Densite_DGP.Rdata"
nameFig1="Densite_DGP.pdf"
nameFig2="Densite_DGP_latent.pdf"
save(n,m,nt,sigmaint,lcint,muint,
     sigmaext,lcext,name,nameFig1,nameFig2,nbatch,
     file="parameters.Rdata")
source("4_DGP.R")
source("5_plot_DGP.R")
