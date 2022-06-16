%%describing the method: In a local time zone, calculating the value of the difference between
%maximum and mimimum. The value is larger than the tolerance value. When the value approach or is 
% identical to the Tolerance value, the convergent stable equilibrium
% arrive
clear all
%Define Tolerance value (determining identity with zero) as 1.0E-6
Tolerance=1.0E-6
load Reserve01NoEvo.out
Default=Reserve01NoEvo
plot(Default(:,1),Default(:,8),'color','black') %Biomass in habitat 1
hold on
plot(Default(:,1),Default(:,14),'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(Default(:,1),Default(:,16),'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(Default(:,1),Default(:,18),'--','color','b')% Total biomass of adults  in harvested area
plot(Default(:,1),Default(:,20),'-','color','b')%Total biomass of adults  in marine reserve
hold off 
for i=1:length(Reserve01NoEvo)-10
Default=Reserve01NoEvo(i:i+10,:)
JH1=max(Default(:,8))-min(Default(:,8))
Joutside=max(Default(:,14))-min(Default(:,14))
Jinside=max(Default(:,16))-min(Default(:,16))
Aoutside=max(Default(:,18))-min(Default(:,18))
Ainside=max(Default(:,20))-min(Default(:,20))

if JH1>Tolerance
    TJH1=i/2 %time at which the equilibrium arrive
else
    break
end
if Joutside>Tolerance
    TJoutside=i/2 %time at which the equilibrium arrive
    else
    break
end
if Jinside>Tolerance
    TJinside=i/2%time at which the equilibrium arrive
    else
    break
end
if Aoutside>Tolerance
    TAoutside=i/2%time at which the equilibrium arrive
    else
    break
end
if Ainside>Tolerance
    TAinside=i/2%time at which the equilibrium arrive
    else
    break
end
end
TJH1
TJoutside
TJinside
TAoutside
TAinside

   
% plot(Default(:,1),Default(:,6),'color','blue','linewidth',1)% total biomass habitat 1, 2, 3
% hold on
% plot(Default(:,1),Default(:,10),'color','black','linewidth',1)%total biomass in the harvested area
% plot(Default(:,1),Default(:,12),'color','red','linewidth',1)% total biomass in the marine reserve
% hold off 
    