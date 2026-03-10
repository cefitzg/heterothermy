clear 
clc 
close all 

%hopf curve, nu-path, and dynamics 
figpos = [100 100 800 600]; %figure position
figpos_small = [100 100 800 400]; %figure position
fs=40; %font size

x=0:0.01:12000;
x2=12001:24000;


%h=@(xi,gamma1) gamma1.^4 - 8*gamma1.^3.*iota + 2*gamma1.^3.*kappa - 4*gamma1.^3.*xi - 4*gamma1.^2.*kappa.^2 + 4*gamma1.^2.*xi.^2 - 8*gamma1.*kappa.^3 + 16*gamma1.*kappa.^2.*xi - 8*gamma1.*kappa.*xi.^2 - 2*gamma1.^3 + 36*gamma1.^2.*iota - 6*gamma1.^2.*kappa + 9*gamma1.^2.*xi + 12*gamma1.*kappa.*xi - 12*gamma1.*xi.^2 + 8*kappa.^3 - 12*kappa.^2.*xi + 4*xi.^3 - 54*gamma1.*iota + 27*iota; 

zeta=0.0001; 
rho=0.1; 
h=@(omega,nu) nu.^4 - 4*nu.^3.*omega + 2*nu.^3.*rho - 8*nu.^3.*zeta + 4*nu.^2.*omega.^2 - 4*nu.^2.*rho.^2 - 8*nu.*omega.^2.*rho + 16*nu.*omega.*rho.^2 - 8*nu.*rho.^3 - 2*nu.^3 + 9*nu.^2.*omega - 6*nu.^2.*rho + 36*nu.^2.*zeta - 12*nu.*omega.^2 + 12*nu.*omega.*rho + 4*omega.^3 - 12*omega.*rho.^2 + 8*rho.^3 - 54*nu.*zeta + 27*zeta;

figure(1)
fimplicit(h,'MeshDensity',5000,'LineWidth',7,'Color',' k')
hold on
axis([0 1.2 0 2.2])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
ax=gca;
exportgraphics(ax,'h1.tif','Resolution',1000) 

figure(2)
plot(x,0.2*(tanh(0.005*(x-3500)))+0.79,'LineWidth',7,'Color','#FE6100')
hold on 
plot(x2,0.2*(1-tanh(0.005*(x2-20500)))+0.59,'LineWidth',7,'Color','#FE6100')
%set(gca,'FontSize',fs)
%xlabel('time')
%ylabel('$$\gamma(t)$$','interpreter','latex')
%title('Circannual signal')
xticks({})
axis([0 24000 0.57 1.02])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
ax=gca;
exportgraphics(ax,'h2.tif','Resolution',1000) 

%plot the dynamics here instead of in julia 


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
plot(1:length(sol),sol(:,2),'LineWidth',5,'LineStyle','-.','Color','#DC267F')
plot(1+length(sol):2*length(sol),sol2(:,1),'LineWidth',3,'Color','#648FFF')
plot(1+length(sol):2*length(sol),sol2(:,2),'LineWidth',5,'LineStyle','-.','Color','#DC267F')
axis([0 2*length(sol) 0.0 1.05])
xticks({})
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
ax=gca;
exportgraphics(ax,'h3.tif','Resolution',1000) 

%extra plots for Figure 5 in revision 1 (same as above)
figure(4)
plot(x,0.2*(tanh(0.005*(x-3500)))+0.79,'LineWidth',7,'Color','#FE6100')
hold on 
plot(x2,0.2*(1-tanh(0.005*(x2-20500)))+0.59,'LineWidth',7,'Color','#FE6100')
%set(gca,'FontSize',fs)
%xlabel('time')
%ylabel('$$\gamma(t)$$','interpreter','latex')
%title('Circannual signal')
xticks({})
axis([0 24000 0.57 1.02])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%ax=gca;
%exportgraphics(ax,'3O.tif','Resolution',1000) 

figure(5)
plot(1:length(sol),sol(:,1),'LineWidth',3,'Color','#648FFF')
hold on 
plot(1:length(sol),sol(:,2),'LineWidth',5,'LineStyle','-.','Color','#DC267F')
plot(1+length(sol):2*length(sol),sol2(:,1),'LineWidth',3,'Color','#648FFF')
plot(1+length(sol):2*length(sol),sol2(:,2),'LineWidth',5,'LineStyle','-.','Color','#DC267F')
axis([0 2*length(sol) 0.0 1.05])
xticks({})
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%ax=gca;
%exportgraphics(ax,'3I.tif','Resolution',1000) 



