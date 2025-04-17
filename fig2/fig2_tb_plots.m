clear 
clc 
close all 

%creates body temperature plot and phase space reconstruction for Fig 2. 

%figure settings
figpos = [100 100 800 600]; %figure position
figpos_small = [100 100 800 400]; %figure position
%axpos = [120 120 780 480]; %figure position
fs=40; %font size

%arctic ground squirrel data 
ags_data_ms = readmatrix("9903_M_Toolik_temp.csv"); 
%phase space reconstruction for Arctic ground squirrel 
[XR,eLag,eDim] = phaseSpaceReconstruction(ags_data_ms(10811:13747,2));
disp("tis is the squirrel's TDE dimension")
eDim

figure(1)
plot(1:length(ags_data_ms(5390:18222,2)),ags_data_ms(5390:18222,2),'LineWidth',3,'Color','#785EF0');
hold on 
plot(10811-5390:13747-5390,ags_data_ms(10811:13747,2),'LineWidth',3,'Color','#648FFF')
plot(13748-5390:16573-5390,ags_data_ms(13748:16573,2),'LineWidth',3,'Color', '#FE6100')
set(gca,'FontSize',fs)
%ylabel('T_b ({\circ}C)')
axis([1 12833 -3 42])
axis off
%xticks([1 3208 6417 9625 12833])
%xticklabels({'September','November','January','March','May'})
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%ax=gca;
%exportgraphics(ax,'tb.tiff','Resolution',1000) 

figure(2)
plot(XR(:,1),XR(:,2),'LineWidth',3,'Color','#648FFF');
set(gca,'FontSize',fs)
%ylabel('T_b ({\circ}C)')
axis([-3 42 -3 42])
axis off
%xticks([1 3208 6417 9625 12833])
%xticklabels({'September','November','January','March','May'})
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%ax=gca;
%exportgraphics(ax,'dimension.tiff','Resolution',1000) 
