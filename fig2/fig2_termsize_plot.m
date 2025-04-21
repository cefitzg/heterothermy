clear 
clc 
close all 

%creates term size argument plot in figure 2 

%figure settings
figpos = [100 100 1000 800]; %figure position
fs=32; %font size

sim_data = readmatrix("8AB_fit.csv"); %forward simulation of 8AB 
opt_parameters_8AB = readmatrix("8AB_info.csv"); %all optimized parameters 
[~,ind]=sort(opt_parameters_8AB(:,3)); %sort cost function values 
best_fit = opt_parameters_8AB(ind(1),5:end); %get the best fit from 10k seeds 

%the model has the form: 
%xdot = B104*x*x+B106*x*x*x+B108*x*y+B109*x*x*y+l+B107*y*y*y+B110*x*y*y,
%ydot = B204*x*x+B205*y*y 

%assign parameter values from best fit. ordering slightly different. 
b104 = best_fit(1); 
b106 = abs(best_fit(2));
b107 = abs(best_fit(8)); 
b108 = abs(best_fit(3));
b109 = 9.999995000000000; %fixed for identifiability reasons 
b110 = best_fit(9); 
b204 = best_fit(4); 
b205 = abs(best_fit(5));
l = best_fit(6);

%assign forward simulation to x and y state. 
x=sim_data(1,:); 
y=sim_data(2,:); 

% %confirm solution oscillates. 
% figure(1)
% plot(1:length(x),x,'x')
% hold on 
% plot(1:length(y),y,'x')

figure(2)
plot(1:length(x),b104*x.^2,'LineWidth',7,'Color','#737373')
hold on 
plot(1:length(x),b106*x.^3,'LineWidth',7,'Color','#000000')
plot(1:length(x),b107*y.^3,'LineWidth',7,'Color','#56B4E9') 
plot(1:length(x),b108*x.*y,'LineWidth',7,'Color','#d9d9d9')
plot(1:length(x),b109*x.^2.*y,'LineWidth',7,'Color','#bdbdbd')
plot(1:length(x),b110*x.*y.^2,'LineWidth',7,'Color','#0072B2') 
%cannot cut any of the terms below, as they are all needed for limit cycle.
%plot(1:length(x),l*ones(1,length(x)),'LineWidth',5,'Color','#e31a1c')
%plot(1:length(x),b204*x.^2,'LineWidth',7,'Color','#969696')
%plot(1:length(x),b205*y.^2,'LineWidth',7,'Color','#737373')
axis([480 600 0 10.5])
%xlabel('time')
%ylabel('size of term')
xticks({})
yline(1.6,'LineWidth',5,'LineStyle',':')
temp = legend('', '', '$$\dot{x}: y^3$$', '', '', '$$\dot{x}: xy^2$$','interpreter','latex');
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.85], ...
	'plotboxaspectratio',[1 1 1])
set(temp, 'FontName', 'Helvetica')
%ax=gca;
%exportgraphics(ax,'termsize.tif','Resolution',1000)
