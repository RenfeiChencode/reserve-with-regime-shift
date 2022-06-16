%describing the method: In a local time zone, calculating the value of the difference between
%maximum and mimimum. The value will increase untile the tipping point
%occur.
clear all
load    Reserve05Evo.out
Default=Reserve05Evo
ti=400    %initial time point
tzone=200 %decide the width of the time zone you want to search
int=(540-ti)*2
ii=1
for i=int:int+tzone
JH1(ii)=max(Default(int:i,8))-min(Default(int:i,8))
Joutside(ii)=max(Default(int:i,14))-min(Default(int:i,14))
Jinside(ii)=max(Default(int:i,16))-min(Default(int:i,16))
Aoutside(ii)=max(Default(int:i,18))-min(Default(int:i,18))
Ainside(ii)=max(Default(int:i,20))-min(Default(int:i,20))
ii=ii+1
end
ii=1
for i=2:length(JH1)
if JH1(i-1)<JH1(i)
ii=ii+1 
 else
     TJH1=(ii+int)/2 %time at which the tipping point arrive
break 
end
end
ii=1
for j=2:length(Joutside)
if Joutside(j-1)<Joutside(j)
    ii=ii+1
else
    TJoutside=(ii/2)+(int/2)%time at which the tipping point arrive
break
end
end
ii=1
for i=2:length(Jinside)
if Jinside(i-1)<Jinside(i)
    ii=ii+1
else
    TJinside=(ii/2)+(int/2)%time at which the tipping point arrive
break
end
end

ii=1
for i=2:length(Aoutside)
if Aoutside(i-1)<Aoutside(i)
    ii=ii+1
else
    TAoutside=(ii/2)+(int/2)%time at which the tipping point arrive
break
end
end

ii=1
for i=2:length(Ainside)
if Ainside(i-1)<Ainside(i)
    ii=ii+1
else
    TAinside=(ii/2)+(int/2)%time at which the tipping point arrive
break
end
end
plot(Default(:,1),Default(:,8),'color','black') %Biomass in habitat 1
hold on
plot(Default(:,1),Default(:,14),'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(Default(:,1),Default(:,16),'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(Default(:,1),Default(:,18),'--','color','b')% Total biomass of adults  in harvested area
plot(Default(:,1),Default(:,20),'-','color','b')%Total biomass of adults  in marine reserve
hold off    
TJH1
TJoutside
TJinside
TAoutside
TAinside



    