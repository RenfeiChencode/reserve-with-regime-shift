clear

%bfore a reserve is implemented
befreserve = dlmread('NoReserve.out');
befreserve = befreserve(402:end,:);
%after a reserve is implemented
Reserve01Evo = dlmread('Reserve01Evo.out');
Reserve01NoEvo = dlmread('Reserve01NoEvo.out');
Reserve05Evo = dlmread('Reserve05Evo.out');
Reserve05NoEvo = dlmread('Reserve05NoEvo.out');

time=0:.5:800;

figure %ecological dynamics
subplot(2,2,1)
hold on
plot(time,[befreserve(:,8);Reserve01NoEvo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve01NoEvo(:,14)],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve01NoEvo(:,16)],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve01NoEvo(:,18)],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve01NoEvo(:,20)],'-','color','b')%Total biomass of adults  in marine reserve

ylabel('Biomass')
legend('Juveniles in habitat 1','Juveniles in habitat 2 (outside reserve)', 'Juveniles in habitat 2 (inside reserve)','Adults in habitat 2 (outside reserve)', 'Adults in habitat 2 (inside reserve)')
title('c = 0.1, no evolution')


subplot(2,2,2)
hold on
plot(time,[befreserve(:,8);Reserve01Evo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve01Evo(:,14)],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve01Evo(:,16)],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve01Evo(:,18)],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve01Evo(:,20)],'-','color','b')%Total biomass of adults  in marine reserve

title('c = 0.1, evolution')

subplot(2,2,3)
hold on
plot(time,[befreserve(:,8);Reserve05NoEvo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve05NoEvo(:,14)],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve05NoEvo(:,16)],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve05NoEvo(:,18)],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve05NoEvo(:,20)],'-','color','b')%Total biomass of adults  in marine reserve

title('c = 0.5, no evolution')
xlabel('Time')
ylabel('Biomass')

subplot(2,2,4)
hold on
plot(time,[befreserve(:,8);Reserve05Evo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve05Evo(:,14)],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve05Evo(:,16)],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve05Evo(:,18)],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve05Evo(:,20)],'-','color','b')%Total biomass of adults  in marine reserve

title('c = 0.5, evolution')
xlabel('Time')

figure %trait dynamics
subplot(2,2,1)
hold on
plot(time,[befreserve(:,21);Reserve01NoEvo(:,21)])
ylim([.18 .35])
ylabel('Body size at habitat switch')
title('c = 0.1, no evolution')

subplot(2,2,2)
hold on
plot(time,[befreserve(:,21);Reserve01Evo(:,21)])
ylim([.18 .35])
title('c = 0.1, evolution')

subplot(2,2,3)
hold on
plot(time,[befreserve(:,21);Reserve05NoEvo(:,21)])
ylim([.18 .35])
title('c = 0.5, no evolution')
xlabel('Time')
ylabel('Body size at habitat switch')

subplot(2,2,4)
hold on
plot(time,[befreserve(:,21);Reserve05Evo(:,21)])
ylim([.18 .35])
title('c = 0.5, evolution')
xlabel('Time')

figure %ecological dynamics under extensively strong fishing intensity
Fmortality1000c05Evo = dlmread('Fmortality1000c05Evo.out');
Jmortality14c05Evo = dlmread('Jmortality14c05Evo.out');
subplot(1,2,1)
hold on
plot(time,[befreserve(:,8);Fmortality1000c05Evo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Fmortality1000c05Evo(:,14)],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Fmortality1000c05Evo(:,16)],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Fmortality1000c05Evo(:,18)],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Fmortality1000c05Evo(:,20)],'-','color','b')%Total biomass of adults  in marine reserve

title({'Fishing mortality   1000','Mortality in habitat 1   1.0','c   0.5;  evolution'})
xlabel('Time')
ylabel('Biomass')
subplot(1,2,2)
hold on
plot(time,[befreserve(:,8);Jmortality14c05Evo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Jmortality14c05Evo(:,14)],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Jmortality14c05Evo(:,16)],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Jmortality14c05Evo(:,18)],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Jmortality14c05Evo(:,20)],'-','color','b')%Total biomass of adults  in marine reserve

title({'Fishing mortality   1000','Mortality in habitat 1   1.4','c   0.5;  evolution'})
xlabel('Time')

%calculating biomass per unit volume
figure %ecological dynamics
subplot(2,2,1)
hold on
plot(time,[befreserve(:,8);Reserve01NoEvo(:,8)/1],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve01NoEvo(:,14)/0.9],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve01NoEvo(:,16)/0.1],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve01NoEvo(:,18)/0.9],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve01NoEvo(:,20)/0.1],'-','color','b')%Total biomass of adults  in marine reserve

ylabel('Biomass per unit volume')
legend('Juveniles in habitat 1','Juveniles in habitat 2 (outside reserve)', 'Juveniles in habitat 2 (inside reserve)','Adults in habitat 2 (outside reserve)', 'Adults in habitat 2 (inside reserve)')
title('c = 0.1, no evolution')


subplot(2,2,2)
hold on
plot(time,[befreserve(:,8);Reserve01Evo(:,8)/1],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve01Evo(:,14)/0.9],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve01Evo(:,16)/0.1],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve01Evo(:,18)/0.9],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve01Evo(:,20)/0.1],'-','color','b')%Total biomass of adults  in marine reserve

title('c = 0.1, evolution')

subplot(2,2,3)
hold on
plot(time,[befreserve(:,8);Reserve05NoEvo(:,8)/1],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve05NoEvo(:,14)/0.5],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve05NoEvo(:,16)/0.5],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve05NoEvo(:,18)/0.5],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve05NoEvo(:,20)/0.5],'-','color','b')%Total biomass of adults  in marine reserve

title('c = 0.5, no evolution')
xlabel('Time')
ylabel('Biomass per unit volume')

subplot(2,2,4)
hold on
plot(time,[befreserve(:,8);Reserve05Evo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Reserve05Evo(:,14)/0.5],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Reserve05Evo(:,16)/0.5],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Reserve05Evo(:,18)/0.5],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Reserve05Evo(:,20)/0.5],'-','color','b')%Total biomass of adults  in marine reserve

title('c = 0.5, evolution')
xlabel('Time')


figure %ecological dynamics under extensively strong fishing intensity
Fmortality1000c05Evo = dlmread('Fmortality1000c05Evo.out');
Jmortality14c05Evo = dlmread('Jmortality14c05Evo.out');
subplot(1,2,1)
hold on
plot(time,[befreserve(:,8);Fmortality1000c05Evo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Fmortality1000c05Evo(:,14)/0.5],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Fmortality1000c05Evo(:,16)/0.5],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Fmortality1000c05Evo(:,18)/0.5],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Fmortality1000c05Evo(:,20)/0.5],'-','color','b')%Total biomass of adults  in marine reserve

title({'Fishing mortality   1000','Mortality in habitat 1   1.0','c   0.5;  evolution'})
xlabel('Time')
ylabel('Biomass per unit volume')
subplot(1,2,2)
hold on
plot(time,[befreserve(:,8);Jmortality14c05Evo(:,8)],'color','black') %Biomass in habitat 1
plot(time,[befreserve(:,14);Jmortality14c05Evo(:,14)/0.5],'--','color',[1 0.5 0])% Total biomass of juveniles in harvested area
plot(time,[befreserve(:,16);Jmortality14c05Evo(:,16)/0.5],'-','color',[1 0.5 0])%Total biomass of juveniles in marine reserve
plot(time,[befreserve(:,18);Jmortality14c05Evo(:,18)/0.5],'--','color','b')% Total biomass of adults  in harvested area
plot(time,[befreserve(:,20);Jmortality14c05Evo(:,20)/0.5],'-','color','b')%Total biomass of adults  in marine reserve

title({'Fishing mortality   1000','Mortality in habitat 1   1.4','c   0.5;  evolution'})
xlabel('Time')
