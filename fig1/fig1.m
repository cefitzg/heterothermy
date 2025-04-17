clear 
clc 
close all 

%creates body temperature plot and inset of body temperature plot in Fig 1.

%figure settings
figpos = [100 100 800 600]; %figure position
figpos_small = [100 100 800 400]; %figure position
fs=40; %font size

%arctic ground squirrel data 
ags_data_ms = readmatrix("9903_M_Toolik_temp.csv"); 

figure(1)
plot(1:length(ags_data_ms(5390:18222,2)),ags_data_ms(5390:18222,2),'LineWidth',3,'Color','#785EF0');
set(gca,'FontSize',fs)
%ylabel('T_b ({\circ}C)')
axis([1 12833 -3 42])
set(gca,'linewidth',6)
%xticks([1 3208 6417 9625 12833])
%xticklabels({'September','November','January','March','May'})
set(gca,'xtick',[])
%set(gca,'ytick',[])
set(gca,'fontname','helvetica')
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%ax=gca;
%exportgraphics(ax,'tb.tiff','Resolution',1000) 

%inset 
figure(2)
plot(1:length(ags_data_ms(5390+5432:18222-1500,2)),ags_data_ms(5390+5432:18222-1500,2),'LineWidth',1,'Color','#785EF0');
set(gca,'FontSize',fs)
%ylabel('T_b ({\circ}C)')
axis([1 12833 -3 42])
axis off
%xticks([1 3208 6417 9625 12833])
%xticklabels({'September','November','January','March','May'})
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gcf,'units','pixels','outerposition',figpos_small,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%ax=gca;
%exportgraphics(ax,'tb_small.tiff','Resolution',1000) 