clear 
clc 
close all 

%figure settings
figpos = [100 100 800 600]; %figure position
fs=32; %font size
figpos_small = [100 100 800 400]; %figure position

%6 model
mi_6A = readmatrix("6A_info.csv"); %all parameter fits for model 6A 
[cfv_6A,i_6A] = min(mi_6A(:,3)); %get best cost function 
conv_flg_6A = mi_6A(i_6A,4); %convergence flag status 
fit_6A = readmatrix("6A_fit.csv"); %simulation of model 6A @ optimized parameters 
%7 model A
mi_7A = readmatrix("7A_info.csv"); 
[cfv_7A,i_7A] = min(mi_7A(:,3));
fit_7A = readmatrix("7A_fit.csv"); 
conv_flg_7A = mi_7A(i_7A,4);
%7 model B
mi_7B = readmatrix("7B_info.csv"); 
[cfv_7B,i_7B] = min(mi_7B(:,3));
fit_7B = readmatrix("7B_fit.csv"); 
conv_flg_7B = mi_7B(i_7B,4);
%7 model C
mi_7C = readmatrix("7C_info.csv"); 
[cfv_7C,i_7C] = min(mi_7C(:,3));
fit_7C = readmatrix("7C_fit.csv"); 
conv_flg_7C = mi_7C(i_7C,4);
%7 model D
mi_7D = readmatrix("7D_info.csv"); 
[cfv_7D,i_7D] = min(mi_7D(:,3));
fit_7D = readmatrix("7D_fit.csv"); 
conv_flg_7D = mi_7D(i_7D,4);
%8 model AB
mi_8AB = readmatrix("8AB_info.csv"); 
[cfv_8AB,i_8AB] = min(mi_8AB(:,3));
fit_8AB = readmatrix("8AB_fit.csv");
conv_flg_8AB = mi_8AB(i_8AB,4);
%8 model AC
mi_8AC = readmatrix("8AC_info.csv"); 
[cfv_8AC,i_8AC] = min(mi_8AC(:,3));
fit_8AC = readmatrix("8AC_fit.csv"); 
conv_flg_8AC = mi_8AC(i_8AC,4);
%8 model AD
mi_8AD = readmatrix("8AD_info.csv"); 
[cfv_8AD,i_8AD] = min(mi_8AD(:,3));
fit_8AD = readmatrix("8AD_fit.csv"); 
conv_flg_8AD = mi_8AD(i_8AD,4);
%8 model BC
mi_8BC = readmatrix("8BC_info.csv"); 
[cfv_8BC,i_8BC] = min(mi_8BC(:,3));
fit_8BC = readmatrix("8BC_fit.csv"); 
conv_flg_8BC = mi_8BC(i_8BC,4);
%8 model BD
mi_8BD = readmatrix("8BD_info.csv"); 
[cfv_8BD,i_8BD] = min(mi_8BD(:,3));
fit_8BD = readmatrix("8BD_fit.csv"); 
conv_flg_8BD = mi_8BD(i_8BD,4);
%8 model CD
mi_8CD = readmatrix("8CD_info.csv"); 
[cfv_8CD,i_8CD] = min(mi_8CD(:,3));
fit_8CD = readmatrix("8CD_fit.csv");
conv_flg_8CD = mi_8CD(i_8CD,4);
%9 model ABC
mi_9ABC = readmatrix("9ABC_info.csv"); 
[cfv_9ABC,i_9ABC] = min(mi_9ABC(:,3));
fit_9ABC = readmatrix("9ABC_fit.csv");
conv_flg_9ABC = mi_9ABC(i_9ABC,4);
%9 model ABD
mi_9ABD = readmatrix("9ABD_info.csv"); 
[cfv_9ABD,i_9ABD] = min(mi_9ABD(:,3));
fit_9ABD = readmatrix("9ABD_fit.csv");
conv_flg_9ABD = mi_9ABD(i_9ABD,4);
%9 model ACD
mi_9ACD = readmatrix("9ACD_info.csv"); 
[cfv_9ACD,i_9ACD] = min(mi_9ACD(:,3));
fit_9ACD = readmatrix("9ACD_fit.csv");
conv_flg_9ACD = mi_9ACD(i_9ACD,4);
%9 model BCD
mi_9BCD = readmatrix("9BCD_info.csv"); 
[cfv_9BCD,i_9BCD] = min(mi_9BCD(:,3));
fit_9BCD = readmatrix("9BCD_fit.csv");
conv_flg_9BCD = mi_9BCD(i_9BCD,4);
%10A
mi_10A = readmatrix("10A_info.csv"); 
[cfv_10A,i_10A] = min(mi_10A(:,3));
fit_10A = readmatrix("10A_fit.csv");
conv_flg_10A = mi_10A(i_10A,4);
% read in the scaled training and validation data. 
data = readmatrix("ags_training.csv"); 
val_data = readmatrix("ags_validate.csv");

%collect cfvs 
cfvs = [cfv_6A,cfv_7A,cfv_7B,cfv_7C,cfv_7D,cfv_8AB,cfv_8AC,cfv_8AD,cfv_8BC,cfv_8BD,cfv_8CD,cfv_9ABC,cfv_9ABD,cfv_9ACD,cfv_9BCD,cfv_10A];
%look at convergence status 
conv_flag = [conv_flg_6A,conv_flg_7A,conv_flg_7B,conv_flg_7C,conv_flg_7D,conv_flg_8AB,conv_flg_8AC,conv_flg_8AD,conv_flg_8BC,conv_flg_8BD,conv_flg_8CD,conv_flg_9ABC,conv_flg_9ABD,conv_flg_9ACD,conv_flg_9BCD,conv_flg_10A];

%create aic for models 
aic_val_td = 2*[7,8,8,8,8,9,9,9,9,9,9,10,10,10,10,11]-2*log(cfvs); 

%read in simulations of models across training and validation data 
val_6A = readmatrix("6A_val_fts.csv"); 
val_7A = readmatrix("7A_val_fts.csv"); 
val_7B = readmatrix("7B_val_fts.csv"); 
val_7C = readmatrix("7C_val_fts.csv"); 
val_7D = readmatrix("7D_val_fts.csv"); 
val_8AB = readmatrix("8AB_val_fts.csv"); 
val_8AC = readmatrix("8AC_val_fts.csv"); 
val_8AD = readmatrix("8AD_val_fts.csv"); 
val_8BC = readmatrix("8BC_val_fts.csv"); 
val_8BD = readmatrix("8BD_val_fts.csv"); 
val_8CD = readmatrix("8CD_val_fts.csv"); 
val_9ABC = readmatrix("9ABC_val_fts.csv"); 
val_9ABD = readmatrix("9ABD_val_fts.csv");
val_9ACD = readmatrix("9ACD_val_fts.csv");
val_9BCD = readmatrix("9BCD_val_fts.csv");
val_10A = readmatrix("10A_val_fts.csv"); 

%collect just the measured state 
val_ts = vertcat(val_6A(1,:),val_7A(1,:),val_7B(1,:),val_7C(1,:),val_7D(1,:),val_8AB(1,:),val_8AC(1,:),val_8AD(1,:),val_8BC(1,:),val_8BD(1,:),val_8CD(1,:),val_9ABC(1,:),val_9ABD(1,:),val_9ACD(1,:),val_9BCD(1,:),val_10A(1,:)); 

for i =1:16
    dtw_val(i) = dtw(val_ts(i,2938:end),val_data','squared'); %compute dynamic time warping values on just the validation data 
end 

%read in scaling symmetry 
fit_sym1 = readmatrix("6A_val_sym1.csv");

figure(1)
plot(1:length(aic_val_td),aic_val_td,'o','MarkerFaceColor','#969696','MarkerEdgeColor','#969696','MarkerSize',30)
hold on 
plot(1,aic_val_td(1),'o','MarkerFaceColor','#648FFF','MarkerEdgeColor','#648FFF','MarkerSize',30)
plot(12,aic_val_td(12),'o','MarkerFaceColor','#FE6100','MarkerEdgeColor','#FE6100','MarkerSize',30)
yline(aic_val_td(1)+3,'LineWidth',4,'LineStyle',':')
yline(aic_val_td(1)-3,'LineWidth',4,'LineStyle',':')
set(gca,'FontSize',fs)
set(gca, 'XTickLabel', [])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
%xticks([1:16])
%xticklabels({'6','7A','7B','7C','7D','8AB','8AC','8AD','8BC','8BD','8CD','9ABC','9ABD','9ACD','9BCD','10'})
%xlabel('Models')
%ylabel('Fit')
axis([1 16 min(aic_val_td)-3.6 max(aic_val_td)+0.6])
set(gcf,'units','pixels','outerposition',figpos_small,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.2 0.9 0.8], ...
	'plotboxaspectratio',[1 0.5 1])
% ax=gca;
% exportgraphics(ax,'1A.tif','Resolution',1000) 


figure(2)
plot(1:length(cfvs),cfvs,'o','MarkerFaceColor','#969696','MarkerEdgeColor','#969696','MarkerSize',30)
hold on 
plot(1,cfvs(1),'o','MarkerFaceColor','#648FFF','MarkerEdgeColor','#648FFF','MarkerSize',30)
plot(12,cfvs(12),'o','MarkerFaceColor','#FE6100','MarkerEdgeColor','#FE6100','MarkerSize',30)
set(gca,'FontSize',fs)
set(gca, 'XTickLabel', [])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
%xticks([1:16])
%xticklabels({'6','7A','7B','7C','7D','8AB','8AC','8AD','8BC','8BD','8CD','9ABC','9ABD','9ACD','9BCD','10'})
%xlabel('Models')
%ylabel('Fit')
%legend('RMSE','AIC','Location','northeastoutside')
axis([1 16 min(cfvs)-0.02 max(cfvs)+0.05])
set(gcf,'units','pixels','outerposition',figpos_small,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.2 0.9 0.8], ...
	'plotboxaspectratio',[1 0.5 1])
% ax=gca;
% exportgraphics(ax,'1AA.tif','Resolution',1000) 


figure(3)
semilogy(1:length(dtw_val),dtw_val,'o','MarkerFaceColor','#969696','MarkerEdgeColor','#969696','MarkerSize',30)
hold on 
plot(1,dtw_val(1),'o','MarkerFaceColor','#648FFF','MarkerEdgeColor','#648FFF','MarkerSize',30)
plot(12,dtw_val(12),'o','MarkerFaceColor','#FE6100','MarkerEdgeColor','#FE6100','MarkerSize',30)
set(gca,'FontSize',fs)
set(gca, 'XTickLabel', [])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
%xticks([1:16])
%xticklabels({'6','7A','7B','7C','7D','8AB','8AC','8AD','8BC','8BD','8CD','9ABC','9ABD','9ACD','9BCD','10'})
%xlabel('Models')
%ylabel('DTW fit (validation data)')
axis([1 16 0 0.7])
set(gcf,'units','pixels','outerposition',figpos_small,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.8], ...
	'plotboxaspectratio',[1 0.5 1])
% ax=gca;
% exportgraphics(ax,'1AAA.tif','Resolution',1000) 

figure(4)
plot(0:0.1:293.6,fit_6A(1,:),'Color','#648FFF','LineWidth',7)
hold on 
% plot(0:0.1:293.6,fit_7A(1,:),'Color','g','LineWidth',2)
% plot(0:0.1:293.6,fit_7B(1,:),'Color','k','LineWidth',2)
% plot(0:0.1:293.6,fit_7C(1,:),'Color','r','LineWidth',2)
% plot(0:0.1:293.6,fit_7D(1,:),'Color','y','LineWidth',2)
% plot(0:0.1:293.6,fit_8AB(1,:),'Color','m','LineWidth',2)
% plot(0:0.1:293.6,fit_8AC(1,:),'Color','c','LineWidth',2)
% plot(0:0.1:293.6,fit_8AD(1,:),'Color','#D95319','LineWidth',2)
% plot(0:0.1:293.6,fit_8BC(1,:),'Color','#EDB120','LineWidth',2)
%plot(0:0.1:293.6,fit_8BD(1,:),'Color',"#7E2F8E",'LineWidth',2)
%plot(0:0.1:293.6,fit_8CD(1,:),'Color','#77AC30','LineWidth',2)
% plot(0:0.1:293.6,fit_9ABC(1,:),'Color','#A2142F','LineWidth',2)
% plot(0:0.1:293.6,fit_9ABD(1,:),'Color','#aad62b','LineWidth',2)
% plot(0:0.1:293.6,fit_9ACD(1,:),'Color','#cbc5e3','LineWidth',2)
% plot(0:0.1:293.6,fit_9BCD(1,:),'Color','#c4a610','LineWidth',2)
% plot(0:0.1:293.6,fit_10A(1,:),'Color','#df87cf','LineWidth',2)
plot(0:0.1:293.6,data,'LineWidth',7,'Color','#785EF0','LineStyle',':')
%legend('6','7A','7B','7C','7D','8AB','8AC','8AD','8BC','8BD','8CD','9ABC','9ABD','9ACD','9BCD','10','Data','Location','northeastoutside')
set(gca,'FontSize',fs)
%ylabel('x')
%xlabel('Time')
axis([0 200 -0.05 1.05])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
% ax=gca;
% exportgraphics(ax,'2A.tif','Resolution',1000) 


figure(5)
plot(0:0.1:293.6,fit_6A(1,:),'Color','#648FFF','LineWidth',7)
hold on 
% plot(0:0.1:293.6,fit_7A(1,:),'Color','g','LineWidth',2)
% plot(0:0.1:293.6,fit_7B(1,:),'Color','k','LineWidth',2)
% plot(0:0.1:293.6,fit_7C(1,:),'Color','r','LineWidth',2)
% plot(0:0.1:293.6,fit_7D(1,:),'Color','y','LineWidth',2)
% plot(0:0.1:293.6,fit_8AB(1,:),'Color','m','LineWidth',2)
% plot(0:0.1:293.6,fit_8AC(1,:),'Color','c','LineWidth',2)
% plot(0:0.1:293.6,fit_8AD(1,:),'Color','#D95319','LineWidth',2)
% plot(0:0.1:293.6,fit_8BC(1,:),'Color','#EDB120','LineWidth',2)
% plot(0:0.1:293.6,fit_8BD(1,:),'Color',"#7E2F8E",'LineWidth',2)
% plot(0:0.1:293.6,fit_8CD(1,:),'Color','#77AC30','LineWidth',2)
plot(0:0.1:293.6,fit_9ABC(1,:),'Color','#FE6100','LineWidth',7)
% plot(0:0.1:293.6,fit_9ABD(1,:),'Color','#aad62b','LineWidth',2)
% plot(0:0.1:293.6,fit_9ACD(1,:),'Color','#cbc5e3','LineWidth',2)
% plot(0:0.1:293.6,fit_9BCD(1,:),'Color','#c4a610','LineWidth',2)
% plot(0:0.1:293.6,fit_10A(1,:),'Color','#df87cf','LineWidth',2)
plot(0:0.1:293.6,data,'LineWidth',7,'Color','#785EF0','LineStyle',':')
yline(0,'LineWidth',3)
%legend('6','7A','7B','7C','7D','8AB','8AC','8AD','8BC','8BD','8CD','9ABC','9ABD','9ACD','9BCD','10','Data','Location','northeastoutside')
set(gca,'FontSize',fs)
%ylabel('x')
%xlabel('Time')
axis([45 60 -0.05 1.05])
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'2AA.tif','Resolution',1000) 


figure(6)
plot(0:0.1:293.6,fit_6A(1,:),'Color','#648FFF','LineWidth',7)
hold on 
plot(0:0.1:293.6,fit_6A(2,:),'Color','#DC267F','LineWidth',7,'LineStyle','-.')
%plot(0:0.1:293.6,data,'LineWidth',6,'Color','#e16911','LineStyle',':')
set(gca,'FontSize',fs)
%ylabel('T_b')
%xlabel('Time')
axis([0 200 -0.05 1.05])
%legend("T_b","Y","Data","Location","northeastoutside")
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
% ax=gca;
% exportgraphics(ax,'2B.tif','Resolution',1000) 

figure(7)
plot(0:0.1:293.6,fit_sym1(1,:),'Color','#648FFF','LineWidth',7)
hold on 
plot(0:0.1:293.6,fit_sym1(2,:),'Color','#DC267F','LineWidth',7,'LineStyle','-.')
%plot(0:0.1:293.6,data,'LineWidth',6,'Color','#e16911','LineStyle',':')
%ylabel('T_b')
%xlabel('Time')
%legend("T_b","Y","Data","Location","northeastoutside")
axis([0 200 -0.8 1.05])
set(gca,'linewidth',6)
set(gca,'fontname','helvetica')
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
% ax=gca;
% exportgraphics(ax,'2E.tif','Resolution',1000) 





