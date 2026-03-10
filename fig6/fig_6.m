clear 
clc 
close all

%read in miner and bear sim 
miner_sim = readmatrix("miner_sim.csv"); %Model 6 miner variant 
bear_sim = readmatrix("bear_sim.csv"); %Model 6 bear variant 

%figure settings
figpos = [100 100 800 600]; %figure position
fs=40; %font size 

%plot the miner sim 
figure(1)
plot(1:length(miner_sim(1,500:1:end)),miner_sim(1,500:1:end),'LineWidth',2,'Color','#648FFF')
%hold on 
%plot(1:length(miner_sim(2,1:1:end)),miner_sim(2,1:1:end),'LineWidth',2,'LineStyle','-.','Color','#DC267F')
set(gca,'FontSize',fs)
%xlabel('Nondim. Time')
%ylabel('Nondim. T_b ({\circ}C)')
set(gca,'XTick',[]);
%title('(K) NM sim.')
xlim([0 length(miner_sim)])
ylim([0 1.05])
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
axis off;
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
ax=gca;
exportgraphics(ax,'miner_signal.png','BackgroundColor','none') 

%plot the bear sim 
figure(2)
plot(1:length(bear_sim(1,1:1:end)),bear_sim(1,1:1:end),'LineWidth',2,'Color','#648FFF')
%hold on 
%plot(1:length(bear_sim(2,1:1:end)),bear_sim(2,1:1:end),'LineWidth',2,'LineStyle','-.','Color','#DC267F')
%xlabel('Nondim. Time')
%ylabel('Nondim. T_b ({\circ}C)')
set(gca,'XTick',[]);
xlim([0 100000])
%title('(L) BB sim.')
ylim([0 1.05])
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
axis off;
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
ax=gca;
exportgraphics(ax,'bear_signal.png','BackgroundColor','none') 

%simulate the qualitative AGS model 

omega=0.99; 
q2=1.0;
%q3=0.99; this is the parameter that changes. 
zeta=0.0001; 
rho=0.1; 

f=@(t,P)[omega*P(1).^2-P(1).^3-(0.2*(tanh(0.005*(t-3500)))+0.79)*(P(1).*P(2)-P(1).^2.*P(2))+zeta;rho*(P(1).^2-P(2).^2)]
[t,sol] = ode89(f,[0:0.01:12000],[0.99,0.99]); %q3 case 

f=@(t,P)[omega*P(1).^2-P(1).^3-(0.2*(1-tanh(0.005*(t-8500)))+0.59)*(P(1).*P(2)-P(1).^2.*P(2))+zeta;rho*(P(1).^2-P(2).^2)]
[t2,sol2] = ode89(f,[0:0.01:12000],[sol(end,1),sol(end,2)]); %q3 case 

figure(3)
plot(1:length(sol),sol(:,1),'LineWidth',3,'Color','#648FFF')
hold on 
%plot(1:length(sol),sol(:,2),'LineWidth',5,'LineStyle','-.','Color','#DC267F')
plot(1+length(sol):2*length(sol),sol2(:,1),'LineWidth',3,'Color','#648FFF')
%plot(1+length(sol):2*length(sol),sol2(:,2),'LineWidth',5,'LineStyle','-.','Color','#DC267F')
axis([0 2*length(sol) 0.0 1.05])
xticks({})
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
axis off;
set(gcf, 'color', 'none');
set(gca, 'color', 'none');
ax=gca;
exportgraphics(ax,'squirrel_signal.png','BackgroundColor','none') 





