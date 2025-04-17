clear 
clc 
close all

%set random seed 
rng(2025)

%plots heterothermy time series and time delay embedding

%arctic ground squirrel data 
ags_data_ms = readmatrix("9903_M_Toolik_temp.csv"); 
%phase space reconstruction for Arctic ground squirrel 
[XR,eLag,eDim] = phaseSpaceReconstruction(ags_data_ms(10811:13747,2));
disp("tis is the squirrel's TDE dimension")
eDim

% %shrew data {cannot release data set}
% shrew_data_1 = readmatrix("247DBH (Male).xls"); 
% %phase space reconstruction for shrew  
% [XR_shrew,eLag,eDim_shrew] = phaseSpaceReconstruction(smoothdata(shrew_data_1(:,2),"gaussian"));
% disp("this is the shrew's TDE dimension")
% eDim_shrew
% 
% %noisy miner data {cannot release data set}
% nm_data = readmatrix("NoisyMiner-cb21-Tb&Ta vs Date-time. Fig.3.7HibBook.xlsx");
% %phase space reconstruction for miner 
% [XR_miner,eLag,eDim_miner] = phaseSpaceReconstruction(smoothdata(nm_data(:,2),"loess"));
% disp("this is the miner's TDE dimension")
% eDim_miner

%black bear data 
M_bear2_body_temp=csvread('digitized_bb.csv');
sv = 1e-10; %small value for bear interpolation  
%black bear interpolation 
a = M_bear2_body_temp(:, 1);
anew = a + sv*abs(rand(1,length(a)))'; %make all a values unique (need to interpolate)
a_interp = anew(1):0.01:anew(end); %set interp values 
b = M_bear2_body_temp(:, 2);
bnew = b + sv*abs(rand(1,length(b)))'; %make all a values unique (need to interpolate)
b_interp = interp1(anew,bnew,anew(1):0.01:anew(end)); %interpolate

%phase space reconstruction for bear 
[XR_bb,eLag,eDim_bb] = phaseSpaceReconstruction(smoothdata(b_interp,"loess"));
disp("this is the bear's TDE dimension")
eDim_bb

%simulated physiological models
ags_sim = readmatrix("ags_sim.csv"); %Model 6 
miner_sim = readmatrix("miner_sim.csv"); %Model 6 miner variant 
shrew_sim = readmatrix("shrew_sim.csv"); %Model 6 shrew variant 
bear_sim = readmatrix("bear_sim.csv"); %Model 6 bear variant 

%figure settings
figpos = [100 100 800 600]; %figure position
fs=40; %font size


%Figure 3 (individual) 
figure(1)
plot(1:length(ags_data_ms(5390:18222,2)),ags_data_ms(5390:18222,2),'LineWidth',3,'Color','#648FFF');
set(gca,'FontSize',fs)
%ylabel('T_b ({\circ}C)')
axis([1 12833 -2 42])
%xticks([1 3208 6417 9625 12833])
%xticklabels({'September','November','January','March','May'})
set(gca,'xtick',[])
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3A.tif','Resolution',1000) 

% figure(2) {cannot release data set}
% plot(1:length(shrew_data_1),shrew_data_1(:,2),'LineWidth',3,'Color','#648FFF')
% %xticks([1 2916])
% %xticklabels({'June','July'})
% set(gca,'xtick',[])
% axis([1 2916 12 39.9])
% %ylabel('T_b ({\circ}C)')
% set(gca,'FontSize',fs)
% %title('(B) Elephant shrew (ES)')
% set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
% set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
% 	'plotboxaspectratio',[1 1 1])
% set(gca,'linewidth',6)
% set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3B.tif','Resolution',1000) 
% 
% figure(3) {cannot release data set}
% plot(nm_data(:,1),nm_data(:,2),'Color','#648FFF')
% set(gca,'FontSize',fs)
% %xticks([131 162 193 224 258])
% %xticklabels({'May', 'June', 'July', 'August', 'September'})
% set(gca,'xtick',[])
% axis([nm_data(1,1) nm_data(end,1) 32 43])
% %ylabel('T_b ({\circ}C)')
% %title('(C) Noisy miner (NM)')
% set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
% set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
% 	'plotboxaspectratio',[1 1 1])
% set(gca,'linewidth',6)
% set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3C.tif','Resolution',1000) 

figure(4)
plot(a, b,'LineWidth',2,'Color','#648FFF'); %plot OG data
%xticks([0 30 60 90 120 150])
%xticklabels({'December','January','February','March','April','May'})
set(gca,'xtick',[])
%ylabel('T_b ({\circ}C)')
xlim([0 160]);
ylim([29 39.9]);
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3D.tif','Resolution',1000) 

figure(5)
plot(XR(:,1),XR(:,2),'LineWidth',2,'Color','#648FFF')
set(gca,'FontSize',32)
%xlabel('Tb(t)')
%ylabel('Tb(t + \tau)')
set(gca,'FontSize',fs)
%title('(E) AGS Phase Space Reconstruction (PSR)')
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
axis([-3 42 -3 42])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3E.tif','Resolution',1000) 



% figure(6) {cannot release data set}
% plot3(XR_shrew(:,1),XR_shrew(:,2),XR_shrew(:,3),'LineWidth',2,'Color','#648FFF')
% set(gca,'FontSize',20)
% %xlabel('Tb(t)')
% %ylabel('Tb(t + \tau)')
% %zlabel('Tb(t + 2\tau)')
% set(gca,'FontSize',fs)
% view(-60,30)
% set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
% set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
% 	'plotboxaspectratio',[1 1 1])
% set(gca,'linewidth',6)
% set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3F.tif','Resolution',1000) 
% 
% figure(7) {cannot release data set}
% plot3(XR_miner(:,1),XR_miner(:,2),XR_miner(:,3),'LineWidth',2,'Color','#648FFF')
% set(gca,'FontSize',fs)
% %xlabel('Tb(t)')
% %ylabel('Tb(t + \tau)')
% %zlabel('Tb(t + 2\tau)')
% view(-45,-20)
% set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
% set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
% 	'plotboxaspectratio',[1 1 1])
% set(gca,'linewidth',6)
% set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3G.tif','Resolution',1000) 

figure(8)
plot3(XR_bb(:,1),XR_bb(:,2),XR_bb(:,3),'LineWidth',1.5,'Color','#648FFF')
%xlabel('Tb(t)')
%ylabel('Tb(t + \tau)')
%zlabel('Tb(t + 2\tau)')
view(20,20)
set(gca,'FontSize',fs)
%title('(H) BB PSR')
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3H.tif','Resolution',1000) 


figure(9)
plot(1:length(ags_sim(1,:)),ags_sim(1,:),'LineWidth',3,'Color','#648FFF')
hold on 
plot(1:length(ags_sim(2,:)),ags_sim(2,:),'LineWidth',5,'LineStyle','-.','Color','#DC267F')
%xlabel('Nondim. Time')
set(gca,'XTick',[]);
%title('(I) AGS sim.')
xlim([0 length(ags_sim)])
ylim([0 1.05])
set(gca,'xtick',[])
%ylabel('Nondim. T_b ({\circ}C)')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%axis([0 10000 0 1.1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3I.tif','Resolution',1000) 

figure(10)
plot(1:length(shrew_sim(1,1:1:end)),shrew_sim(1,1:1:end),'LineWidth',2,'Color','#648FFF')
hold on 
plot(1:length(shrew_sim(2,1:1:end)),shrew_sim(2,1:1:end),'LineWidth',2,'LineStyle','-.','Color','#DC267F')
%xlabel('Nondim. Time')
%ylabel('Nondim. T_b ({\circ}C)')
set(gca,'xtick',[])
set(gca,'FontSize',fs)
%title('(J) ES sim.')
xlim([0 length(shrew_sim)])
ylim([0 1.05])
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3J.tif','Resolution',1000) 

figure(11)
plot(1:length(miner_sim(1,1:1:end)),miner_sim(1,1:1:end),'LineWidth',2,'Color','#648FFF')
hold on 
plot(1:length(miner_sim(2,1:1:end)),miner_sim(2,1:1:end),'LineWidth',2,'LineStyle','-.','Color','#DC267F')
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
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3K.tif','Resolution',1000) 

figure(12)
plot(1:length(bear_sim(1,1:1:end)),bear_sim(1,1:1:end),'LineWidth',2,'Color','#648FFF')
hold on 
plot(1:length(bear_sim(2,1:1:end)),bear_sim(2,1:1:end),'LineWidth',2,'LineStyle','-.','Color','#DC267F')
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
% ax=gca;
% exportgraphics(ax,'3L.tif','Resolution',1000) 

figure(13)
t=0:0.1:10000;
plot(t,0.1*sin((2*pi*t)/300)+0.1,'LineWidth',1,'Color','#FE6100')
%xlabel('Nondim. Time')
%title('(M) circadian signal')
set(gca,'XTick',[]);
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
axis([0 10000 0 0.21])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3M.tif','Resolution',1000) 


figure(14)
t=0:0.1:10000;
plot(t,0.3*cos((2*pi*t)/10000)+0.3,'LineWidth',5,'Color','#FE6100')
hold on 
plot(t,0.2*cos((2*pi*t)/10000)+0.8,'LineWidth',5,'Color','#FE6100')
%xlabel('Nondim. Time')
%title('(O) circannual signal')
set(gca,'XTick',[]);
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
axis([0 10000 -0.1 1.1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3N.tif','Resolution',1000) 

figure(15)
t=0:0.1:10000;
plot(t,zeros(1,length(t)),'LineWidth',5,'Color','#FE6100')
%xlabel('Nondim. Time')
%title('(O) circannual signal')
set(gca,'XTick',[]);
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
axis([0 10000 -1 1.1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'3O.tif','Resolution',1000) 

