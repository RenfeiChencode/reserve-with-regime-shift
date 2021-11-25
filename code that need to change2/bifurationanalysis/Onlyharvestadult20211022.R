#only harvesting adults
library(PSPManalysis)
#library(rgl)#做三维图用"
setwd("C:\\Users\\lenovo\\Desktop\\bifurationanalysis")
#########################################################
#bifurcation analysis with parameters in figure 2
##cases no bifurcation point in traditional ways, have bifurcation points under strategies with reserves
################### effect of body size at habitat switch
#without reserves
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,FETA = 2.0,FETJ = 0,WS =0.1)
init=c(0.1,0.1025903940,0.5119289701,1)# time t=0.5
init=c(8.02760161E-02, 1.00000019E+00, 4.99999945E-01, 6.29548253E-08)
init=c(9.97986193E-01, 1.23163394E-01, 4.97130464E-01, 5.70416483E+00)
TBtransient <- PSPMequi(modelname = "OnlyHANOreserve", biftype = "EQ", startpoint = init, stepsize = -0.1, parbnds = c(8, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)
#with reserves
pars <- c(PHI = 1.0, RHO = 0.9, RHO2 = 0.1,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=2.0,E0J=0, WS = 0.1,C=0.1)
init=c(0.1,0.0779714942,	0.6910008220,	0.1139354861,1)# time at t=0.5 in corresponding transient time analysis 
init=c(9.20697481E-03, 9.75730779E-01, 5.36777741E-01, 8.51014398E-02, 2.64592203E+00)
MBtransient <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(10, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)
################### effect of fishing effort
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,FETA = 2.0,FETJ = 0,WS =0.1)
init=c(2.0,0.1025903940,0.5119289701,1)# time t=0.5
init=c(9.69639682E-03, 8.27777892E-01, 2.39628984E-01, 1.80678270E+00)
TFtransient <- PSPMequi(modelname = "OnlyHANOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(6, 0.01, 2), parameters = pars,clean=TRUE, force=TRUE)
pars <- c(PHI = 1.0, RHO = 0.9, RHO2 = 0.1,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=2.0,E0J=0, WS = 0.1,C=0.1)
init=c(2.0,0.0779714942,	0.6910008220,	0.1139354861,1)# time at t=0.5 in corresponding transient time analysis 
init=c(9.04331438E-03, 5.16674730E-01, 2.45550882E-01, 7.70466529E-02, 5.21708637E+00)
MFtransient <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(8, 0.01, 4), parameters = pars,clean=TRUE, force=TRUE)
################### effect of reserve size
pars <- c(PHI = 1.0, RHO = 0.9, RHO2 = 0.1,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=2.0,E0J=0, WS = 0.1,C=0.1)
init=c(0.1,0.0779714942,	0.6910008220,	0.1139354861,1)# time at t=0.5 in corresponding transient time analysis 
init=c(9.70110272E-01, 9.99999995E-01, 9.00000000E-01, 9.99999740E-02, 5.08904446E-08)
MRtransient <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = -0.1, parbnds = c(11, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)
################### effect of RHO (productivity ratio)
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,FETA = 2.0,FETJ = 0,WS =0.1)
init=c(0.5,0.1025903940,0.5119289701,1)# time t=0.5
init=c(4.91752847E-01, 9.99999974E-01, 4.91752791E-01, 5.38881866E-08)
TRHOtransient <- PSPMequi(modelname = "OnlyHANOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(1, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)
pars <- c(PHI = 1.0, RHO = 0.9, RHO2 = 0.1,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=2.0,E0J=0, WS = 0.1,C=0.1)
init=c(0.9,0.0779714942,	0.6910008220,	0.1139354861,1)# time at t=0.5 in corresponding transient time analysis 
init=c(  4.98841882E-01, 9.99999970E-01, 4.98841821E-01, 9.99999694E-02, 3.43187193E-08)
MRHOtransient <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(1, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)

pars <- c(PHI = 1.0, RHO = 0.9, RHO2 = 0.1,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=2.0,E0J=0, WS = 0.1,C=0.1)
init=c(0.1,0.0779714942,	0.6910008220,	0.1139354861,1)# time at t=0.5 in corresponding transient time analysis 
init=c( 9.90191134E-01, 2.15849306E-02, 7.26414106E-01, 9.33358001E-01, 3.71762578E+01)
MRHO2transient <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = -0.1, parbnds = c(2, 0.01, 0.99), parameters = pars,clean=TRUE, force=TRUE)



################### effect of body size at habitat switch with bifurcation point in traditional ways,
################### and without bifurcation points under strategies with reserves
#without reserves
##with a smaller fishing effort (E)
pars <- c(PHI = 1.0, RHO = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,FETA = 0.1,FETJ = 0,WS =0.1)
init=c(9.10515293E-03, 9.87519831E-01, 2.69734718E-01, 1.37573233E+00)
TBeffort <- PSPMequi(modelname = "OnlyHANOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(8, 0, 0.5), parameters = pars,clean=TRUE, force=TRUE)
##with a bigger productivity ratio (RHO)
pars <- c(PHI = 1.0, RHO = 0.9,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,FETA = 2.0,FETJ = 0,WS =0.1)
init=c(9.75157815E-03, 9.76021431E-01, 5.29074350E-01, 2.46878252E+00)
TBRHO <- PSPMequi(modelname = "OnlyHANOreserve", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(8, 0, 0.5), parameters = pars,clean=TRUE, force=TRUE)
#with reserves
##with a larger fishing effort (E=3.5)
pars <- c(PHI = 1.0, RHO = 0.9, RHO2 = 0.1,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=3.5,E0J=0, WS = 0.1,C=0.1)
init=c(9.05274073E-03, 9.88429864E-01, 7.31810656E-01, 9.21749349E-02, 1.28276895E+00)
MBeffort <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(10, 0.0, 0.5), parameters = pars,clean=TRUE, force=TRUE)
## a bigger marine reserve size (c=0.5)
pars <- c(PHI = 1.0, RHO = 0.9, RHO2 = 0.1,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=2.0,E0J=0, WS = 0.1,C=0.5)
init=c(9.43527254E-03, 9.63952080E-01, 5.82320560E-01, 4.40812798E-02, 3.83552678E+00)
MBreservesize <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(10, 0, 0.5), parameters = pars,clean=TRUE, force=TRUE)
## a smaller productivity ratio (RHO) and bigger RHO2
pars <- c(PHI = 1.0, RHO = 0.5, RHO2 = 0.5,Q = 1.0, BETA = 2000, ETA1 = 0.8, ETA2 = 1.5,ETA3 =1.5,E0A=2.0,E0J=0, WS = 0.1,C=0.1)
init=c(9.51559519E-03, 9.54456347E-01, 2.24634400E-01, 3.79417359E-01, 4.80532372E+00)
MBRHO <- PSPMequi(modelname = "OnlyHAwithreserves", biftype = "EQ", startpoint = init, stepsize = 0.1, parbnds = c(10, 0, 0.5), parameters = pars,clean=TRUE, force=TRUE)

pdf("testOnlyharvestadult202110221.pdf",width = 4.5, height = 6,pointsize=5)
par(mfrow = c(5, 3))
par(mar = c(5, 4.5, 4, 4.5))
#without marine reserves
######################## effect of fishing effort without bifurcation points
plot(TFtransient$curvepoints[,1],TFtransient$curvepoints[,7]+TFtransient$curvepoints[,8]+TFtransient$curvepoints[,9],col="blue",xlim = c(0,2),ylim = c(0,0.4),type="l",xlab = "Fishing effort (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part1 no reserve habitat 1 and 2
lines(TFtransient$curvepoints[,1],TFtransient$curvepoints[,8]+TFtransient$curvepoints[,9],col="black")#total biomass in the harvested area part1 no reserve
################### effect of body size at habitat switch without bifurcation points
plot(TBtransient$curvepoints[,1],TBtransient$curvepoints[,7]+TBtransient$curvepoints[,8]+TBtransient$curvepoints[,9],col="blue",xlim = c(0,0.8),ylim = c(0,1.35),type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part1 no reserve habitat 1 and 2
lines(TBtransient$curvepoints[,1],TBtransient$curvepoints[,8]+TBtransient$curvepoints[,9],col="black")#total biomass in the harvested area part1 no reserve
################### effect of body size at habitat switch with bifurcation points with a smaller fishing effort (E) 
plot(TBeffort$curvepoints[,1],TBeffort$curvepoints[,7]+TBeffort$curvepoints[,8]+TBeffort$curvepoints[,9],col="blue",xlim = c(0,0.5),ylim = c(0,1.35),type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part1 no reserve habitat 1 and 2
lines(TBeffort$curvepoints[,1],TBeffort$curvepoints[,8]+TBeffort$curvepoints[,9],col="black")#total biomass in the harvested area part1 no reserve
points(TBeffort$bifpoints[,1], TBeffort$bifpoints[,7]+TBeffort$bifpoints[,8]+TBeffort$bifpoints[,9], col="Orange", pch=8, lwd=1, cex = 0.5)
points(TBeffort$bifpoints[,1], TBeffort$bifpoints[,8]+TBeffort$bifpoints[,9], col="Orange", pch=8, lwd=1, cex = 0.5)
text(TBeffort$bifpoints[,1], TBeffort$bifpoints[,7]+TBeffort$bifpoints[,8]+TBeffort$bifpoints[,9], TBeffort$biftype, pos=3, offset=0.3, col="Orange",cex = 0.5)
text(TBeffort$bifpoints[,1], TBeffort$bifpoints[,8]+TBeffort$bifpoints[,9], TBeffort$biftype, pos=3, offset=0.3, col="Orange",cex = 0.5)
######################## effect of productivity ratio(RHO) without bifurcation points
plot(TRHOtransient$curvepoints[,1],TRHOtransient$curvepoints[,7]+TRHOtransient$curvepoints[,8]+TRHOtransient$curvepoints[,9],col="blue",xlim = c(0.5,0.9),ylim = c(0,0.2),type="l",xlab = "Productivity ratio (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part1 no reserve habitat 1 and 2
lines(TRHOtransient$curvepoints[,1],TRHOtransient$curvepoints[,8]+TRHOtransient$curvepoints[,9],col="black")#total biomass in the harvested area part1 no reserve
plot(1,1,xlab="",ylab = "")# 为了占据subplot位置而作，need to delete later

################### effect of body size at habitat switch with bifurcation points with a bigger productivity ratio (RHO)
plot(TBRHO$curvepoints[,1],TBRHO$curvepoints[,7]+TBRHO$curvepoints[,8]+TBRHO$curvepoints[,9],col="blue",xlim = c(0,0.5),ylim = c(0,1.35),type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part1 no reserve habitat 1 and 2
lines(TBRHO$curvepoints[,1],TBRHO$curvepoints[,8]+TBRHO$curvepoints[,9],col="black")#total biomass in the harvested area part1 no reserve
points(TBRHO$bifpoints[,1], TBRHO$bifpoints[,7]+TBRHO$bifpoints[,8]+TBRHO$bifpoints[,9], col="Orange", pch=8, lwd=1, cex = 0.5)
points(TBRHO$bifpoints[,1], TBRHO$bifpoints[,8]+TBRHO$bifpoints[,9], col="Orange", pch=8, lwd=1, cex = 0.5)
text(TBRHO$bifpoints[,1], TBRHO$bifpoints[,7]+TBRHO$bifpoints[,8]+TBRHO$bifpoints[,9], TBRHO$biftype, pos=3, offset=0.3, col="Orange",cex = 0.5)
text(TBRHO$bifpoints[,1], TBRHO$bifpoints[,8]+TBRHO$bifpoints[,9], TBRHO$biftype, pos=3, offset=0.3, col="Orange",cex = 0.5)


#with reserves
################### effect of fishing effort without bifurcations
plot(MFtransient$curvepoints[,1],MFtransient$curvepoints[,9]+MFtransient$curvepoints[,10]+MFtransient$curvepoints[,11]+MFtransient$curvepoints[,12]+MFtransient$curvepoints[,13],col="blue",type="l",xlab = "Fishing effort (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MFtransient$curvepoints[,1],MFtransient$curvepoints[,10]+MFtransient$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MFtransient$curvepoints[,1],MFtransient$curvepoints[,11]+MFtransient$curvepoints[,13],col="red")#total biomass in the marine reserve part2 with reserve
################### effect of body size at habitat switch with bifurcations
plot(MBtransient$curvepoints[,1],MBtransient$curvepoints[,9]+MBtransient$curvepoints[,10]+MBtransient$curvepoints[,11]+MBtransient$curvepoints[,12]+MBtransient$curvepoints[,13],col="blue",type="l",xlim = c(0,0.5),ylim = c(0,1.2),xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MBtransient$curvepoints[,1],MBtransient$curvepoints[,10]+MBtransient$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MBtransient$curvepoints[,1],MBtransient$curvepoints[,11]+MBtransient$curvepoints[,13],col="red")#total biomass in the marine reserve part2 with reserve
points(MBtransient$bifpoints[,1], MBtransient$bifpoints[,9]+MBtransient$bifpoints[,10]+MBtransient$bifpoints[,11]+MBtransient$bifpoints[,12]+MBtransient$bifpoints[,13], col="Orange", pch=8, lwd=1, cex = 0.5)
points(MBtransient$bifpoints[,1], MBtransient$bifpoints[,10]+MBtransient$bifpoints[,12], col="Orange", pch=8, lwd=1, cex = 0.5)
#points(MBtransient$bifpoints[,1], MBtransient$bifpoints[,11]+MBtransient$bifpoints[,13], col="Orange", pch=8, lwd=1, cex = 0.5)
text(MBtransient$bifpoints[,1], MBtransient$bifpoints[,9]+MBtransient$bifpoints[,10]+MBtransient$bifpoints[,11]+MBtransient$bifpoints[,12]+MBtransient$bifpoints[,13], MBtransient$biftype, pos=3, offset=0.3, col="Orange",cex = 0.5)
text(MBtransient$bifpoints[,1], MBtransient$bifpoints[,10]+MBtransient$bifpoints[,12], MBtransient$biftype, pos=3, offset=0.3,col="Orange",cex = 0.5)
#text(MBtransient$bifpoints[,1], MBtransient$bifpoints[,11]+MBtransient$bifpoints[,13], MBtransient$biftype, pos=3, offset=0.3,col="Orange",cex = 0.5)
################### effect of body size at habitat switch without bifurcations with a larger fishing effort (E=3.5)
plot(MBeffort$curvepoints[,1],MBeffort$curvepoints[,9]+MBeffort$curvepoints[,10]+MBeffort$curvepoints[,11]+MBeffort$curvepoints[,12]+MBeffort$curvepoints[,13],col="blue",type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MBeffort$curvepoints[,1],MBeffort$curvepoints[,10]+MBeffort$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MBeffort$curvepoints[,1],MBeffort$curvepoints[,11]+MBeffort$curvepoints[,13],col="red")#total biomass in the marine reserve part2 with reserve
####################effect of reserve size without bifurcations
plot(MRtransient$curvepoints[,1],MRtransient$curvepoints[,9]+MRtransient$curvepoints[,10]+MRtransient$curvepoints[,11]+MRtransient$curvepoints[,12]+MRtransient$curvepoints[,13],col="blue",type="l",xlim = c(0,1),ylim = c(0,1),xlab = "Marine reserve size (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MRtransient$curvepoints[,1],MRtransient$curvepoints[,10]+MRtransient$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MRtransient$curvepoints[,1],MRtransient$curvepoints[,11]+MRtransient$curvepoints[,13],col="red")#total biomass in the marine reserve part2 with reserve
plot(1,1,xlab = "",ylab = "")# 为了占据subplot位置而作，need to delete later
################### effect of body size at habitat switch without bifurcations with a bigger marine reserve size (c=0.5)
plot(MBreservesize$curvepoints[,1],MBreservesize$curvepoints[,9]+MBreservesize$curvepoints[,10]+MBreservesize$curvepoints[,11]+MBreservesize$curvepoints[,12]+MBreservesize$curvepoints[,13],col="blue",xlim = c(0,0.5),ylim = c(0,1.2),type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MBreservesize$curvepoints[,1],MBreservesize$curvepoints[,10]+MBreservesize$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MBreservesize$curvepoints[,1],MBreservesize$curvepoints[,11]+MBreservesize$curvepoints[,13],col="red")  #total biomass in the marine reserve part2 with reserve

################### effect of RHO without bifurcations 
plot(MRHOtransient$curvepoints[,1],MRHOtransient$curvepoints[,9]+MRHOtransient$curvepoints[,10]+MRHOtransient$curvepoints[,11]+MRHOtransient$curvepoints[,12]+MRHOtransient$curvepoints[,13],col="blue",type="l",xlab = "Productivity ratio (rho1)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MRHOtransient$curvepoints[,1],MRHOtransient$curvepoints[,10]+MRHOtransient$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MRHOtransient$curvepoints[,1],MRHOtransient$curvepoints[,11]+MRHOtransient$curvepoints[,13],col="red")#total biomass in the marine reserve part2 with reserve
################### effect of RHO2 without bifurcations 
plot(MRHO2transient$curvepoints[,1],MRHO2transient$curvepoints[,9]+MRHO2transient$curvepoints[,10]+MRHO2transient$curvepoints[,11]+MRHO2transient$curvepoints[,12]+MRHO2transient$curvepoints[,13],col="blue",type="l",xlim = c(0,1),ylim = c(0,1.35),xlab = "Productivity ratio (rho2)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MRHO2transient$curvepoints[,1],MRHO2transient$curvepoints[,10]+MRHO2transient$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MRHO2transient$curvepoints[,1],MRHO2transient$curvepoints[,11]+MRHO2transient$curvepoints[,13],col="red")#total biomass in the marine reserve part2 with reserve
################### effect of body size at habitat switch without bifurcations with a smaller productivity ratio (RHO) and bigger RHO2
plot(MBRHO$curvepoints[,1],MBRHO$curvepoints[,9]+MBRHO$curvepoints[,10]+MBRHO$curvepoints[,11]+MBRHO$curvepoints[,12]+MBRHO$curvepoints[,13],type="l",xlim = c(0,0.5),ylim = c(0,1),col="blue",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6) #total biomass part2 with reserve
lines(MBRHO$curvepoints[,1],MBRHO$curvepoints[,10]+MBRHO$curvepoints[,12],col="black")#total biomass in the harvested area part2 with reserve
#lines(MBRHO$curvepoints[,1],MBRHO$curvepoints[,11]+MBRHO$curvepoints[,13],col="red")  #total biomass in the marine reserve part2 with reserve

dev.off()
#arrows(0, 0.4, 2, 0.1, length = 0.15, angle = 15,code = 2, col = "Orange", lty = 1,lwd = 2.5)


pdf("testOnlyharvestadult202110222biomassinreserve.pdf",width = 7, height = 6,pointsize=8)
par(mfrow = c(3, 3))
#with reserves
################### effect of fishing effort without bifurcations
plot(MFtransient$curvepoints[,1],MFtransient$curvepoints[,11]+MFtransient$curvepoints[,13],col="red",type="l",xlab = "Fishing effort (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)#total biomass in the marine reserve part2 with reserve
################### effect of body size at habitat switch with bifurcations
plot(MBtransient$curvepoints[,1],MBtransient$curvepoints[,11]+MBtransient$curvepoints[,13],col="red",type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)#total biomass in the marine reserve part2 with reserve
points(MBtransient$bifpoints[,1], MBtransient$bifpoints[,11]+MBtransient$bifpoints[,13], col="black", pch=8, lwd=1, cex = 0.5)
text(MBtransient$bifpoints[,1], MBtransient$bifpoints[,11]+MBtransient$bifpoints[,13], MBtransient$biftype, pos=3, offset=0.3,col="black",cex = 0.5)
################### effect of body size at habitat switch without bifurcations with a larger fishing effort (E=3.5)
plot(MBeffort$curvepoints[,1],MBeffort$curvepoints[,11]+MBeffort$curvepoints[,13],col="red",type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)#total biomass in the marine reserve part2 with reserve
####################effect of reserve size without bifurcations
plot(MRtransient$curvepoints[,1],MRtransient$curvepoints[,11]+MRtransient$curvepoints[,13],col="red",type="l",xlab = "Marine reserve size (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)#total biomass in the marine reserve part2 with reserve
plot(1,1,xlab = "",ylab = "",main = "Biomass inside reserves")# 为了占据subplot位置而作，need to delete later
################### effect of body size at habitat switch without bifurcations with a bigger marine reserve size (c=0.5)
plot(MBreservesize$curvepoints[,1],MBreservesize$curvepoints[,11]+MBreservesize$curvepoints[,13],col="red",type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)  #total biomass in the marine reserve part2 with reserve

################### effect of RHO without bifurcations 
plot(MRHOtransient$curvepoints[,1],MRHOtransient$curvepoints[,11]+MRHOtransient$curvepoints[,13],col="red",type="l",xlab = "Productivity ratio (rho1)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)#total biomass in the marine reserve part2 with reserve
################### effect of RHO2 without bifurcations 
plot(MRHO2transient$curvepoints[,1],MRHO2transient$curvepoints[,11]+MRHO2transient$curvepoints[,13],col="red",type="l",xlab = "Productivity ratio (rho2)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)#total biomass in the marine reserve part2 with reserve
################### effect of body size at habitat switch without bifurcations with a smaller productivity ratio (RHO) and bigger RHO2
plot(MBRHO$curvepoints[,1],MBRHO$curvepoints[,11]+MBRHO$curvepoints[,13],col="red",type="l",xlab = "Body size at habitat switch (scaled unit)",ylab = "Fish biomass (scaled unit)",cex.lab=1.6,cex.axis=1.6)  #total biomass in the marine reserve part2 with reserve

dev.off()




