clear 
clc 
close all

%set random seed 
rng(2025)

%data smoothing plots

%shrew data 
% shrew_data_1 = readmatrix("247DBH (Male).xls"); %{cannot release data set}

%noisy miner data 
% nm_data = readmatrix("NoisyMiner-cb21-Tb&Ta vs Date-time.
% Fig.3.7HibBook.xlsx"); %{cannot release data set}

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

%figure settings
figpos = [100 100 800 600]; %figure position
%axpos = [120 120 780 480]; %figure position
fs=40; %font size


% %figures for the supplement with smoothing 
% figure(1) %{cannot release data set}
% set(gcf,'Position',figpos)
% plot(1:length(shrew_data_1),shrew_data_1(:,2),'LineWidth',3,'Color','#648FFF')
% hold on 
% plot(1:length(shrew_data_1),smoothdata(shrew_data_1(:,2),"gaussian"),'LineWidth',3,'Color','#FE6100') %plot interpolated & smoothed
% %legend('Data', 'Smoothed Data','Location','southeastoutside')
% set(gca,'FontSize',fs)
% xticks([1 2916])
% xticklabels({'June','July'})
% axis([1 2916 12 40])
% ylabel('Body Temperature ({\circ}C)')
% set(gca,'FontSize',20)
% set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
% set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
% 	'plotboxaspectratio',[1 1 1])
% set(gca,'linewidth',6)
% set(gca,'fontname','helvetica')
% % ax=gca;
% % exportgraphics(ax,'supplement_shrew.tif','Resolution',1000) 

% figure(2)
% set(gcf,'Position',figpos) %{cannot release data set}
% plot(nm_data(:,1),nm_data(:,2),'Color','#648FFF')
% hold on 
% plot(nm_data(:,1),smoothdata(nm_data(:,2),"loess"),'LineWidth',1,'Color','#FE6100') %plot interpolated & smoothed
% %legend('Data', 'Smoothed Data','Location','southeastoutside')
% xticks([131 162 193 224 258])
% xticklabels({'May', 'June', 'July', 'August', 'September'})
% axis([nm_data(1,1) nm_data(end,1) 32 42])
% ylabel('Body Temperature ({\circ}C)')
% set(gca,'FontSize',20)
% set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
% set(gca,'units','normalized','position',[0.1 0.125 0.9 0.9], ...
% 	'plotboxaspectratio',[1 1 1])
% set(gca,'linewidth',6)
% set(gca,'fontname','helvetica')
% % ax=gca;
% % exportgraphics(ax,'supplement_miner.tif','Resolution',1000) 

figure(3)
set(gcf,'Position',figpos)
plot(a, b,'LineWidth',3,'Color','#648FFF'); 
hold 
plot(a_interp,smoothdata(b_interp,"loess"),'LineWidth',3,'Color','#FE6100') %plot interpolated & smoothed
xticks([0 30 60 90 120 150])
xticklabels({'December','January','February','March','April','May'})
ylabel('Body Temperature ({\circ}C)')
xlim([0 160]);
ylim([29 40]);
%legend('digitized data','smoothed data','Location','southeastoutside')
set(gca,'FontSize',20)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.15 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'supplement_bear.tif','Resolution',1000) 

