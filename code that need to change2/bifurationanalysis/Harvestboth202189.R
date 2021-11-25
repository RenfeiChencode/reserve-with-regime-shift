#harvesting both adults and juvernails 
library(PSPManalysis)
setwd("C:\\Users\\lenovo\\Desktop\\bifurationanalysis")
#########################################################
#regime shift analysis
################### effect of body size at habitat switch
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 2.0, ETA2 = 0.8,FET = 0.1,WS =0.1)
init=c(0.1,0.2676730242,	0.4784988755,1)#time at t=7.5 in transient time analysis (figure 2)
TBregime <- PSPMequi(modelname = "HarvestbothNOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(7, 0.05, 0.99), parameters = pars,clean=TRUE, force=TRUE)
pars <- c(PHI = 1.0, RHO = 0.5, RHO2 = 0.5,Q = 1.0, BETA = 2000, ETA1 = 2.0, ETA2 = 0.8,ETA3 = 0.8,E0 =0.1,WS = 0.1,C=0.9)
init=c(0.1,0.0396481318,	0.4987672906,	0.4569176079, 1)#time at t=6 in corresponding transient time analysis 
init=c(2.88885829E-08, 9.99999692E-01, 2.29022594E-01, 3.85213765E-02, 1.06487171E+01)#根据上面初始值获得的初始值
MBregime <- PSPMequi(modelname = "Harvestbothwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(9, 0, 0.99), parameters = pars,clean=TRUE, force=TRUE)
################### effect of fishing effort
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 2.0, ETA2 = 0.8,FET = 0.1,WS =0.1)
init=c(0.1,0.2676730242,	0.4784988755,1)
TFregime <- PSPMequi(modelname = "HarvestbothNOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(6, 0.05, 4), parameters = pars,clean=TRUE, force=TRUE)
pars <- c(PHI = 1.0, RHO = 0.5, RHO2 = 0.5,Q = 1.0, BETA = 2000, ETA1 = 2.0, ETA2 = 0.8,ETA3 = 0.8,E0 =0.1,WS = 0.1,C=0.9)
init=c(0.1, 0.0396481318,	0.4987672906,	0.4569176079, 1)
MFregime <- PSPMequi(modelname = "Harvestbothwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(8, 0.05, 10), parameters = pars,clean=TRUE, force=TRUE)
################### effect of reserve size
pars <- c(PHI = 1.0, RHO = 0.5, RHO2 = 0.5,Q = 1.0, BETA = 2000, ETA1 = 2.0, ETA2 = 0.8,ETA3 = 0.8,E0 =0.1,WS = 0.1,C=0.9)
init=c(0.9, 0.0396481318,	0.4987672906,	0.4569176079, 1)
MRregime <- PSPMequi(modelname = "Harvestbothwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(10, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)
#########################################################
#long transient analysis
################### effect of body size at habitat switch
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,FET = 0.5,WS =0.1)
init=c(0.1, 0.1370699906,	0.3426460330,1)
TBtransient <- PSPMequi(modelname = "HarvestbothNOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(7, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)
pars <- c(PHI = 1.0, RHO = 0.5, RHO2 = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.0,E0 =0.5,WS = 0.1,C=0.1)
init=c(0.1, 0.0383854934,	0.2794246935,	0.3855175019, 1)#time at t=13 in corresponding transient time analysis 
MBtransient <- PSPMequi(modelname = "Harvestbothwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(9, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)
################### effect of fishing effort
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,FET = 0.5,WS =0.1)
init=c(0.5, 0.1370699906,	0.3426460330,1)
TFtransient <- PSPMequi(modelname = "HarvestbothNOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(6, 0.01, 4), parameters = pars,clean=TRUE, force=TRUE)
pars <- c(PHI = 1.0, RHO = 0.5, RHO2 = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.0,E0 =0.5,WS = 0.1,C=0.1)
init=c(0.5, 0.0383854934,	0.2794246935,	0.3855175019, 1)#time at t=13 in corresponding transient time analysis 
MFtransient <- PSPMequi(modelname = "Harvestbothwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(8, 0.01, 10), parameters = pars,clean=TRUE, force=TRUE)
################### effect of reserve size
pars <- c(PHI = 1.0, RHO = 0.5, RHO2 = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.0,E0 =0.5,WS = 0.1,C=0.1)
init=c(0.1, 0.0383854934,	0.2794246935,	0.3855175019, 1)#time at t=13 in corresponding transient time analysis 
MRtransient <- PSPMequi(modelname = "Harvestbothwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(10, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)

pdf("Appendixharvestbothequilibrium.pdf")
par(mfrow = c(2, 3))
################### effect of body size at habitat switch
plot(TBregime$curvepoints[,1],TBregime$curvepoints[,7]+TBregime$curvepoints[,8]+TBregime$curvepoints[,9],col="red",xlim = c(0,0.3),ylim = c(0,1.7),type="l",xlab = "",ylab = "Population biomass (scaled unit)",main = "a") #total biomass part1 no reserve habitat 1 and 2
lines(TBregime$curvepoints[,1],TBregime$curvepoints[,8]+TBregime$curvepoints[,9],col="blue")#total biomass in the harvested area part1 no reserve
lines(MBregime$curvepoints[,1],MBregime$curvepoints[,9]+MBregime$curvepoints[,10]+MBregime$curvepoints[,11]+MBregime$curvepoints[,12]+MBregime$curvepoints[,13],col="black") #total biomass part2 with reserve
lines(MBregime$curvepoints[,1],MBregime$curvepoints[,10]+MBregime$curvepoints[,12],col="grey")#total biomass in the harvested area part2 with reserve
points(TBregime$bifpoints[,1], TBregime$bifpoints[,7]+TBregime$bifpoints[,8]+TBregime$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
points(TBregime$bifpoints[,1], TBregime$bifpoints[,8]+TBregime$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
text(TBregime$bifpoints[,1], TBregime$bifpoints[,7]+TBregime$bifpoints[,8]+TBregime$bifpoints[,9], TBregime$biftype, pos=3, offset=0.3, cex = 0.5)
text(TBregime$bifpoints[,1], TBregime$bifpoints[,8]+TBregime$bifpoints[,9], TBregime$biftype, pos=3, offset=0.3, cex = 0.5)

points(MBregime$bifpoints[,1], MBregime$bifpoints[,9]+MBregime$bifpoints[,10]+MBregime$bifpoints[,11]+MBregime$bifpoints[,12]+MBregime$bifpoints[,13], col="red", pch=8, lwd=1, cex = 0.5)
points(MBregime$bifpoints[,1], MBregime$bifpoints[,10]+MBregime$bifpoints[,12], col="red", pch=8, lwd=1, cex = 0.5)
text(MBregime$bifpoints[,1], MBregime$bifpoints[,9]+MBregime$bifpoints[,10]+MBregime$bifpoints[,11]+MBregime$bifpoints[,12]+MBregime$bifpoints[,13], MBregime$biftype, pos=3, offset=0.3, cex = 0.5)
text(MBregime$bifpoints[,1], MBregime$bifpoints[,10]+MBregime$bifpoints[,12], MBregime$biftype, pos=3, offset=0.3, cex = 0.5)
######################## effect of fishing effort
plot(TFregime$curvepoints[,1],TFregime$curvepoints[,7]+TFregime$curvepoints[,8]+TFregime$curvepoints[,9],col="red",xlim = c(0,3),ylim = c(0,1.7),type="l",xlab = "",ylab = "",main = "b") #total biomass part1 no reserve habitat 1 and 2
lines(TFregime$curvepoints[,1],TFregime$curvepoints[,8]+TFregime$curvepoints[,9],col="blue")#total biomass in the harvested area part1 no reserve
lines(MFregime$curvepoints[,1],MFregime$curvepoints[,9]+MFregime$curvepoints[,10]+MFregime$curvepoints[,11]+MFregime$curvepoints[,12]+MFregime$curvepoints[,13],col="black") #total biomass part2 with reserve
lines(MFregime$curvepoints[,1],MFregime$curvepoints[,10]+MFregime$curvepoints[,12],col="grey")#total biomass in the harvested area part2 with reserve
points(TFregime$bifpoints[,1], TFregime$bifpoints[,7]+TFregime$bifpoints[,8]+TFregime$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
points(TFregime$bifpoints[,1], TFregime$bifpoints[,8]+TFregime$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
text(TFregime$bifpoints[,1], TFregime$bifpoints[,7]+TFregime$bifpoints[,8]+TFregime$bifpoints[,9], TFregime$biftype, pos=3, offset=0.3, cex = 0.5)
text(TFregime$bifpoints[,1], TFregime$bifpoints[,8]+TFregime$bifpoints[,9], TFregime$biftype, pos=3, offset=0.3, cex = 0.5)

points(MFregime$bifpoints[,1], MFregime$bifpoints[,9]+MFregime$bifpoints[,10]+MFregime$bifpoints[,11]+MFregime$bifpoints[,12]+MFregime$bifpoints[,13], col="red", pch=8, lwd=1, cex = 0.5)
points(MFregime$bifpoints[,1], MFregime$bifpoints[,10]+MFregime$bifpoints[,12], col="red", pch=8, lwd=1, cex = 0.5)
text(MFregime$bifpoints[,1], MFregime$bifpoints[,9]+MFregime$bifpoints[,10]+MFregime$bifpoints[,11]+MFregime$bifpoints[,12]+MFregime$bifpoints[,13], MFregime$biftype, pos=3, offset=0.3, cex = 0.5)
text(MFregime$bifpoints[,1], MFregime$bifpoints[,10]+MFregime$bifpoints[,12], MFregime$biftype, pos=3, offset=0.3, cex = 0.5)

####################effect of reserve size
plot(MRregime$curvepoints[,1],MRregime$curvepoints[,9]+MRregime$curvepoints[,10]+MRregime$curvepoints[,11]+MRregime$curvepoints[,12]+MRregime$curvepoints[,13],col="black",xlim = c(0.9,1),ylim = c(0,1.7),type="l",xlab = "",ylab = "",main = "c") #total biomass part2 with reserve
lines(MRregime$curvepoints[,1],MRregime$curvepoints[,10]+MRregime$curvepoints[,12],col="grey")#total biomass in the harvested area part2 with reserve

points(MRregime$bifpoints[,1], MRregime$bifpoints[,9]+MRregime$bifpoints[,10]+MRregime$bifpoints[,11]+MRregime$bifpoints[,12]+MRregime$bifpoints[,13], col="red", pch=8, lwd=1, cex = 0.5)
points(MRregime$bifpoints[,1], MRregime$bifpoints[,10]+MRregime$bifpoints[,12], col="red", pch=8, lwd=1, cex = 0.5)
text(MRregime$bifpoints[,1], MRregime$bifpoints[,9]+MRregime$bifpoints[,10]+MRregime$bifpoints[,11]+MRregime$bifpoints[,12]+MRregime$bifpoints[,13], MRregime$biftype, pos=3, offset=0.3, cex = 0.5)
text(MRregime$bifpoints[,1], MRregime$bifpoints[,10]+MRregime$bifpoints[,12], MRregime$biftype, pos=3, offset=0.3, cex = 0.5)
#################################
#long transient
################### effect of body size at habitat switch
plot(TBtransient$curvepoints[,1],TBtransient$curvepoints[,7]+TBtransient$curvepoints[,8]+TBtransient$curvepoints[,9],col="red",xlim = c(0,1),ylim = c(0,1.25),type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Population biomass (scaled unit)",main = "d") #total biomass part1 no reserve habitat 1 and 2
lines(TBtransient$curvepoints[,1],TBtransient$curvepoints[,8]+TBtransient$curvepoints[,9],col="blue")#total biomass in the harvested area part1 no reserve
lines(MBtransient$curvepoints[,1],MBtransient$curvepoints[,9]+MBtransient$curvepoints[,10]+MBtransient$curvepoints[,11]+MBtransient$curvepoints[,12]+MBtransient$curvepoints[,13],col="black") #total biomass part2 with reserve
lines(MBtransient$curvepoints[,1],MBtransient$curvepoints[,10]+MBtransient$curvepoints[,12],col="grey")#total biomass in the harvested area part2 with reserve
points(TBtransient$bifpoints[,1], TBtransient$bifpoints[,7]+TBtransient$bifpoints[,8]+TBtransient$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
points(TBtransient$bifpoints[,1], TBtransient$bifpoints[,8]+TBtransient$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
text(TBtransient$bifpoints[,1], TBtransient$bifpoints[,7]+TBtransient$bifpoints[,8]+TBtransient$bifpoints[,9], TBtransient$biftype, pos=3, offset=0.3, cex = 0.5)
text(TBtransient$bifpoints[,1], TBtransient$bifpoints[,8]+TBtransient$bifpoints[,9], TBtransient$biftype, pos=3, offset=0.3, cex = 0.5)

points(MBtransient$bifpoints[,1], MBtransient$bifpoints[,9]+MBtransient$bifpoints[,10]+MBtransient$bifpoints[,11]+MBtransient$bifpoints[,12]+MBtransient$bifpoints[,13], col="red", pch=8, lwd=1, cex = 0.5)
points(MBtransient$bifpoints[,1], MBtransient$bifpoints[,10]+MBtransient$bifpoints[,12], col="red", pch=8, lwd=1, cex = 0.5)
text(MBtransient$bifpoints[,1], MBtransient$bifpoints[,9]+MBtransient$bifpoints[,10]+MBtransient$bifpoints[,11]+MBtransient$bifpoints[,12]+MBtransient$bifpoints[,13], MBtransient$biftype, pos=3, offset=0.3, cex = 0.5)
text(MBtransient$bifpoints[,1], MBtransient$bifpoints[,10]+MBtransient$bifpoints[,12], MBtransient$biftype, pos=3, offset=0.3, cex = 0.5)
######################## effect of fishing effort
plot(TFtransient$curvepoints[,1],TFtransient$curvepoints[,7]+TFtransient$curvepoints[,8]+TFtransient$curvepoints[,9],col="red",xlim = c(0,3),ylim = c(0,1.25),type="l",xlab = "Fishing effort (scaled unit)",ylab = "",main = "e") #total biomass part1 no reserve habitat 1 and 2
lines(TFtransient$curvepoints[,1],TFtransient$curvepoints[,8]+TFtransient$curvepoints[,9],col="blue")#total biomass in the harvested area part1 no reserve
lines(MFtransient$curvepoints[,1],MFtransient$curvepoints[,9]+MFtransient$curvepoints[,10]+MFtransient$curvepoints[,11]+MFtransient$curvepoints[,12]+MFtransient$curvepoints[,13],col="black") #total biomass part2 with reserve
lines(MFtransient$curvepoints[,1],MFtransient$curvepoints[,10]+MFtransient$curvepoints[,12],col="grey")#total biomass in the harvested area part2 with reserve
points(TFtransient$bifpoints[,1], TFtransient$bifpoints[,7]+TFtransient$bifpoints[,8]+TFtransient$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
points(TFtransient$bifpoints[,1], TFtransient$bifpoints[,8]+TFtransient$bifpoints[,9], col="red", pch=8, lwd=1, cex = 0.5)
text(TFtransient$bifpoints[,1], TFtransient$bifpoints[,7]+TFtransient$bifpoints[,8]+TFtransient$bifpoints[,9], TFtransient$biftype, pos=3, offset=0.3, cex = 0.5)
text(TFtransient$bifpoints[,1], TFtransient$bifpoints[,8]+TFtransient$bifpoints[,9], TFtransient$biftype, pos=3, offset=0.3, cex = 0.5)

points(MFtransient$bifpoints[,1], MFtransient$bifpoints[,9]+MFtransient$bifpoints[,10]+MFtransient$bifpoints[,11]+MFtransient$bifpoints[,12]+MFtransient$bifpoints[,13], col="red", pch=8, lwd=1, cex = 0.5)
points(MFtransient$bifpoints[,1], MFtransient$bifpoints[,10]+MFtransient$bifpoints[,12], col="red", pch=8, lwd=1, cex = 0.5)
text(MFtransient$bifpoints[,1], MFtransient$bifpoints[,9]+MFtransient$bifpoints[,10]+MFtransient$bifpoints[,11]+MFtransient$bifpoints[,12]+MFtransient$bifpoints[,13], MFtransient$biftype, pos=3, offset=0.3, cex = 0.5)
text(MFtransient$bifpoints[,1], MFtransient$bifpoints[,10]+MFtransient$bifpoints[,12], MFtransient$biftype, pos=3, offset=0.3, cex = 0.5)

####################effect of reserve size
plot(MRtransient$curvepoints[,1],MRtransient$curvepoints[,9]+MRtransient$curvepoints[,10]+MRtransient$curvepoints[,11]+MRtransient$curvepoints[,12]+MRtransient$curvepoints[,13],col="black",xlim = c(0,1),ylim = c(0,1.4),type="l",xlab = "Marine reserve size (scaled unit)",ylab = "",main = "f") #total biomass part2 with reserve
lines(MRtransient$curvepoints[,1],MRtransient$curvepoints[,10]+MRtransient$curvepoints[,12],col="grey")#total biomass in the harvested area part2 with reserve

points(MRtransient$bifpoints[,1], MRtransient$bifpoints[,9]+MRtransient$bifpoints[,10]+MRtransient$bifpoints[,11]+MRtransient$bifpoints[,12]+MRtransient$bifpoints[,13], col="red", pch=8, lwd=1, cex = 0.5)
points(MRtransient$bifpoints[,1], MRtransient$bifpoints[,10]+MRtransient$bifpoints[,12], col="red", pch=8, lwd=1, cex = 0.5)
text(MRtransient$bifpoints[,1], MRtransient$bifpoints[,9]+MRtransient$bifpoints[,10]+MRtransient$bifpoints[,11]+MRtransient$bifpoints[,12]+MRtransient$bifpoints[,13], MRtransient$biftype, pos=3, offset=0.3, cex = 0.5)
text(MRtransient$bifpoints[,1], MRtransient$bifpoints[,10]+MRtransient$bifpoints[,12], MRtransient$biftype, pos=3, offset=0.3, cex = 0.5)

dev.off()

