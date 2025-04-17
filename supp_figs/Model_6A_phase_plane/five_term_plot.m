clear 
clc 
close all

%figure settings
figpos = [100 100 800 600]; %figure position
fs=30; %font size

%x and y range 
x=-2.1:0.02:2.1; 
y=-2.1:0.02:2.1; 

%make meshgrid
[X,Y] = meshgrid(x,y);  

%parameter values 
g=1.2; 
k=0.02; 
l=0.000002; 

NX = X.*X-X.*X.*X-g*X.*Y+l; 
NY = k*(X.*X-Y.*Y);
L = sqrt(NX.^2+NY.^2); 

%forward simulate the system 
f=@(t,P)[P(1)*(P(1)-P(1).^2-g*P(2))+l;k*(P(1).^2-P(2).^2)]
[t,sol] = ode45(f,[0:0.1:100000],[0.01,0.1]);

%plot 
figure(1)
fimplicit(@(x,y) x.*(x-x.^2-g*y)+l,'MeshDensity',200,'LineWidth',5,'Color','#648FFF')
hold on 
fimplicit(@(x,y) k*(x.^2-y.^2),'MeshDensity',200,'LineWidth',5,'Color','#FE6100')
plot(sol(:,1),sol(:,2),'LineWidth',5,'Color','#DC267F')
quiver(X,Y,NX./L,NY./L,0.5,'k')
xlabel('$$\hat{x}$$','Interpreter','Latex')
ylabel('$$\hat{y}$$','Interpreter','Latex')
axis([-0.1 0.92 -0.1 0.35])
set(gca,'FontSize',fs)
set(gca, 'FontName', 'Helvetica')
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.2 0.2 0.8 0.8], ...
	'plotboxaspectratio',[1 1 1])
% ax=gca;
% exportgraphics(ax,'phase_plane.jpg','Resolution',1000) 


