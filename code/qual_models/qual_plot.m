clear
clc 
close all 

%making plot of qual behavior 

ags_data = readmatrix("ags_sim.csv"); 
miner_data = readmatrix("miner_sim.csv");
shrew_data = readmatrix("shrew_sim.csv"); 
bear_data = readmatrix("bear_sim.csv"); 

figure(1) 
ax = axes;
subplot(1,4,1)
plot(1:length(ags_data(1,:)),ags_data(1,:),'LineWidth',3)
hold on 
plot(1:length(ags_data(2,:)),ags_data(2,:),'LineWidth',3)
xlabel('Dimensionless Time')
set(gca,'XTick',[]);
title('(A) Arctic ground squirrel')
xlim([0 length(ags_data)])
ylim([0 1.05])
ylabel('Dimensionless Body Temperature')
set(gca,'FontSize',28)
subplot(1,4,2)
plot(1:length(miner_data(1,1:1:end)),miner_data(1,1:1:end),'LineWidth',1)
hold on 
plot(1:length(miner_data(2,1:1:end)),miner_data(2,1:1:end),'LineWidth',1)
%set(gca,'FontSize',20)
xlabel('Dimensionless Time')
set(gca,'XTick',[]);
title('(B) Noisy miner')
xlim([0 length(miner_data)])
ylim([0 1.05])
set(gca,'FontSize',28)
subplot(1,4,3)
plot(1:length(shrew_data(1,1:1:end)),shrew_data(1,1:1:end),'LineWidth',1)
hold on 
plot(1:length(shrew_data(2,1:1:end)),shrew_data(2,1:1:end),'LineWidth',1)
%set(gca,'FontSize',20)
xlabel('Dimensionless Time')
set(gca,'XTick',[]);
title('(C) Elephant shrew')
xlim([0 length(shrew_data)])
ylim([0 1.05])
set(gca,'FontSize',28)
subplot(1,4,4)
plot(1:length(bear_data(1,1:1:end)),bear_data(1,1:1:end),'LineWidth',3)
hold on 
plot(1:length(bear_data(2,1:1:end)),bear_data(2,1:1:end),'LineWidth',3)
%set(gca,'FontSize',20)
xlabel('Dimensionless Time')
set(gca,'XTick',[]);
title('(D) Black bear')
%xlim([0 length(bear_data)])
ylim([0 1.05])
set(gca,'FontSize',28)
yyaxis right
ylabel('Concentration of Hidden Process')
ax = gca;
ax.YAxis(1).Color = [0 0 0];
ax.YAxis(2).Color = [0 0 0];

