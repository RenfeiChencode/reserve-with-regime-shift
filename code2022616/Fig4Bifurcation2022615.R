library(latticeExtra)#×öË«yÖá×ø±êÍ¼
DefaultPars <- c(Rho1 = 0.5, Rho2 = 0.5, Delta = 1.0, 
                 Eta1 =1.0, Eta2 = 0.8, Eta3 = 0.8, ETSJ = 1.5, ETSA = 1.5, 
                 WS    = 0.3222490842, Q    = 1.0, Beta = 2000.0, SR   =0.5)
init=c(0.5, 0.0810950558,	0.4987234255,	0.4863055000, 1)
init=c(9.98005691E-02, 9.70334420E-02, 4.34178277E-01, 3.48225303E-01, 9.65440657E+00)
pars <- DefaultPars
#effect of reserve size
NoEvo <- PSPMequi(modelname = "HarvestWithReserve", biftype = "EQ", startpoint = init, 
                        stepsize = 0.01, parbnds = c(11, 0.1,0.99), parameters = pars, clean=TRUE, options = c("popEVO", "0"))

init=c(0.3222490842,0.3707040272,	0.3262511316,	0.5000000000,1)
init=c(9.96369739E-03, 9.93600473E-01, 3.91276685E-01, 5.00000000E-01, 6.45537188E-01)
pars["SR"] <- 0.0
Reserve00Evo <- PSPMequi(modelname = "HarvestWithReserve", biftype = "EQ", startpoint = init, 
                         stepsize = 0.01, parbnds = c(8, 0.01, 0.5), parameters = pars, clean=TRUE, options = c("popEVO", "0"))

init=c(0.2893971727,0.1896004747,	0.3250205450,	0.1979444573,1)
init=c(9.00147287E-01, 1.53747501E-01, 4.96583907E-01, 4.90302949E-01, 5.51999142E+00)
pars["SR"] <- 0.1
Reserve01Evo <- PSPMequi(modelname = "HarvestWithReserve", biftype = "EQ", startpoint = init, 
                         stepsize = -0.01, parbnds = c(8, 0.01, 0.9), parameters = pars, clean=TRUE, options = c("popEVO", "0"))

init=c(0.1873779649,0.6016668768,	0.2826150666,	0.1479625376,1)
init=c(9.00231943E-01, 1.38592412E-01, 4.97964739E-01, 4.94192932E-01, 6.22480264E+00)
pars["SR"] <- 0.5
Reserve05Evo <- PSPMequi(modelname = "HarvestWithReserve", biftype = "EQ", startpoint = init, 
                          stepsize = -0.01, parbnds = c(8, 0.1, 0.9), parameters = pars, clean=TRUE, options = c("popEVO", "0"))



##drawing
pdf("Bifurcation analyses2022614.pdf",width = 20, height = 15,pointsize=20)

#############################################################
par(mfrow = c(3, 4))
par(mfg=c(1,1))
##par(mar = c(4, 4.5, 2, 2))
#Juveniles in nursery (habitat 1)
plot(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,9],col="black"
     ,xlim = c(0.1, 1.0),ylim = c(0,1.3),type="l",xlab = "",ylab = "Biomass in habitat 1",main = "No evolution",cex.lab=1.5,cex.main=1.5) 
par(mfg=c(2,1))
#Juveniles outside reserve
plot(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,10],col="orange",type="l",lty=2,xlab="",ylab = "Biomass in habitat 2",cex.lab=1.5)
#Juveniles inside reserve
lines(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,11],col="orange")
#Adults outside reserve
lines(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,12],col="blue",lty=2)
#Adults inside reserve
lines(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,13],col="blue")
#############################################################

par(mfg=c(1,2))
##par(mar = c(4, 4.5, 2, 2))
#Juveniles in nursery (habitat 1)
plot(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,9],col="black"
     ,xlim = c(0.0, 0.5),ylim = c(0,1.3),type="l",xlab = "",ylab = "",main = "Reserve size, c=0.0",cex.lab=1.5,cex.main=1.5) 
legend("topleft", c( "Juveniles outside reserve", "Juveniles inside reserve", "Adults outside reserve","Adults inside reserve"), 
       col = c("orange","orange","blue", "blue"),
       lty = c(2,1, 2,1), lwd = c(1, 1))#,bty="n"
par(mfg=c(2,2))
#Juveniles outside reserve
plot(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,10],xlab="",ylab = "",col="orange",type="l",lty=2,ylim = c(0,0.25))
#Juveniles inside reserve
lines(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,11],col="orange")
#Adults outside reserve
lines(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,12],col="blue",lty=2)
#Adults inside reserve
lines(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,13],col="blue")



par(mfg=c(1,3))
##par(mar = c(4, 4.5, 2, 2))
#Juveniles in nursery (habitat 1)
plot(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,9],col="black"
     ,xlim = c(0.0, 0.5),ylim = c(0,1.3),type="l",xlab = "",ylab = "",main = "Reserve size, c=0.1",cex.lab=1.5,cex.main=1.5) 
par(mfg=c(2,3))
#Juveniles outside reserve
plot(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,10],xlab="",ylab = "",col="orange",type="l",lty=2,xlim = c(0.0, 0.5))
#Juveniles inside reserve
lines(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,11],col="orange")
#Adults outside reserve
lines(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,12],col="blue",lty=2)
#Adults inside reserve
lines(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,13],col="blue")
#############################################################

par(mfg=c(1,4))
##par(mar = c(4, 4.5, 2, 2))
#Juveniles in nursery (habitat 1)
plot(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,9],col="black"
     ,xlim = c(0.1, 0.3),ylim = c(0,1.3),type="l",xlab = "",ylab = "",main = "Reserve size, c=0.5",cex.lab=1.5,cex.main=1.5) 
abline(v=Reserve05Evo$bifpoints[1,1],lty=2)
abline(v=Reserve05Evo$bifpoints[3,1],lty=2)
par(mfg=c(2,4))
#Juveniles outside reserve
plot(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,10],xlab="",ylab = "",col="orange",type="l",lty=2,xlim = c(0.1, 0.3),ylim = c(0,0.5))
#Juveniles inside reserve
lines(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,11],col="orange")
#Adults outside reserve
lines(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,12],col="blue",lty=2)
#Adults inside reserve
lines(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,13],col="blue")
abline(v=Reserve05Evo$bifpoints[1,1],lty=2)
abline(v=Reserve05Evo$bifpoints[3,1],lty=2)
#############################################################



par(mfg=c(3,1))
#Juveniles outside reserve
plot(NoEvo$curvepoints[,1],   NoEvo$curvepoints[,10]/(1-NoEvo$curvepoints[,1]),ylim=c(0,0.07),col="orange",type="l",lty=2,xlab="Marine reserve size, c",ylab = "Biomass in habitat 2 per unit volume",cex.lab=1.5)
#Juveniles inside reserve
lines(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,11]/NoEvo$curvepoints[,1],col="orange")
#Adults outside reserve
lines(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,12]/(1-NoEvo$curvepoints[,1]),col="blue",lty=2)
#Adults inside reserve
lines(NoEvo$curvepoints[,1],  NoEvo$curvepoints[,13]/NoEvo$curvepoints[,1],col="blue")
#############################################################

par(mfg=c(3,2))
#Juveniles outside reserve
plot(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,10],xlab="Body size at shift, ws",ylab = "",col="orange",type="l",lty=2,ylim = c(0,0.25),cex.lab=1.5)
#Juveniles inside reserve
lines(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,11],col="orange")
#Adults outside reserve
lines(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,12],col="blue",lty=2)
#Adults inside reserve
lines(Reserve00Evo$curvepoints[,1],  Reserve00Evo$curvepoints[,13],col="blue")

par(mfg=c(3,3))
#Juveniles outside reserve
plot(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,10]/0.9,ylim=c(0,0.9),xlab="Body size at shift, ws",ylab = "",col="orange",type="l",lty=2,xlim = c(0.0, 0.5),cex.lab=1.5)
#Juveniles inside reserve
lines(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,11]/0.1,col="orange")
#Adults outside reserve
lines(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,12]/0.9,col="blue",lty=2)
#Adults inside reserve
lines(Reserve01Evo$curvepoints[,1],  Reserve01Evo$curvepoints[,13]/0.1,col="blue")
#############################################################

par(mfg=c(3,4))
#Juveniles outside reserve
plot(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,10]/0.5,xlab="Body size at shift, ws",ylab = "",col="orange",type="l",lty=2,xlim = c(0.1, 0.3),ylim = c(0,1),cex.lab=1.5)
#Juveniles inside reserve
lines(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,11]/0.5,col="orange")
#Adults outside reserve
lines(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,12]/0.5,col="blue",lty=2)
#Adults inside reserve
lines(Reserve05Evo$curvepoints[,1],  Reserve05Evo$curvepoints[,13]/0.5,col="blue")
abline(v=Reserve05Evo$bifpoints[1,1],lty=2)
abline(v=Reserve05Evo$bifpoints[3,1],lty=2)
#############################################################

dev.off()



























