setwd("C:\\Users\\lenovo\\Desktop\\analyses2022615\\Dynamics analyses Fig2 4 and 5\\output\\regression analyses tipping equilibrium")

library(basicTrendline)
F=read.csv("firsttippingpointequilibrium.csv")
CF=F$CF
FTJH1=F$FTJH1
FTJoutside=F$FTJoutside
FTJinside=F$FTJinside
FTAoutside=F$FTAoutside
FTAinside=F$FTAinside

ETJH1=F$ETJH1
ETJoutside=F$ETJoutside
ETJinside=F$ETJinside
ETAoutside=F$ETAoutside
ETAinside=F$ETAinside
CE=F$CE

#juveniles 
#adults 			
#putting in the main text
pdf("maintextpower3Pmodelscaling.pdf",width = 4, height = 5,pointsize=4)
par(mfrow = c(2, 2))
par(mfg=c(1,1))
#par(mar = c(3, 4.5, 3, 1))
#juveniles biomass inside reserve
trendline(CE, log(ETJinside), model="power3P", ePos.x = "topleft", summary=TRUE, eDigit=2,ylab="Time achieving equilibrium (log-transformed)",xlab = "",main="No evolution",xaxt="n",cex.lab=1.5,cex.main=1.5,eSize = 1.5)
par(mfg=c(2,1))
#par(mar = c(4, 4.5, 1, 1))
#adults biomass in the marine reserve
trendline(CE, log(ETAinside), model="power3P", ePos.x = "topleft", summary=TRUE, eDigit=2,ylab="Time achieving equilibrium (log-transformed)",xlab = "Marine reserve size,c",main="",cex.lab=1.5,eSize = 1.5)
par(mfg=c(1,2))
#juveniles biomass in the marine reserve
trendline(CF, FTJinside, model="power3P", ePos.x = "topleft", summary=TRUE, eDigit=2,ylab="Time of first tipping point",xlab = "",main="With evolution",xaxt="n",cex.lab=1.5,cex.main=1.5,eSize = 1.5)
par(mfg=c(2,2))
#par(mar = c(4, 4.5, 1, 1))
#adults biomass in the marine reserve
trendline(CF, FTAinside, model="power3P", ePos.x = "topleft", summary=TRUE, eDigit=2,ylab="Time of first tipping point",xlab = "Marine reserve size,c",main="",cex.lab=1.5,eSize = 1.5)
dev.off()


