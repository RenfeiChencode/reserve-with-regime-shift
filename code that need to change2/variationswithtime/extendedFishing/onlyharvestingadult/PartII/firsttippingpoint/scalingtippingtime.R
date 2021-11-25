setwd("C:/Users/Lenovo/Desktop/variationswithtime/extendedFishing/onlyharvestingadult/PartII")
library(basicTrendline)
F=read.csv("scalingoffirsttippingpoint.csv")
firsttippingtime=F$firsttippingtime
Fishingeffort=F$E0SA[17:26]
Reservesize=F$C[7:13]
Rho2=F$RHO2[40:47]
Rho3=F$RHO3[48:55]
pdf("scalingfirsttipping.pdf",width = 5, height = 4.5,pointsize=8)
par(mfrow = c(2, 2))
par(mar = c(4, 4.5, 3, 1))
trendline(Fishingeffort,firsttippingtime[17:26], model="power3P", ePos.x = "topright", summary=TRUE, eDigit=5,ylab = "Time of first tipping point",xlab = "Fishing effort")
trendline(Reservesize, firsttippingtime[7:13], model="power3P", ePos.x = "topleft", summary=TRUE, eDigit=5,ylab="",xlab = "Marine reserve size")
trendline(Rho2,firsttippingtime[40:47], model="power3P", ePos.x = "topleft", summary=TRUE, eDigit=5,ylim = c(0,350),ylab = "Time of first tipping point",xlab = "Productivity ratio (Rho2)")
trendline(Rho3,firsttippingtime[48:55], model="power3P", ePos.x = "topleft", summary=TRUE, eDigit=5,ylab="",xlab = "Productivity ratio (Rho3)")
dev.off()
