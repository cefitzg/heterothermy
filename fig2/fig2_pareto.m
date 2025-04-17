clear
clc 
close all 

%creates plot model structures organized by fit and active terms in Fig2

%figure settings
figpos = [100 100 800 600]; %figure position
fs=32; %font size

dahsi_filter = readmatrix("model_selection_output.csv"); %read in all model structures 
% size(dahsi_filter)
% length(dahsi_filter)

dahsi_filter_beta = dahsi_filter(dahsi_filter(:,4)>=75 & dahsi_filter(:,4)<=85,:); %filter to include only 75 <= beta <= 85

%count up number of active terms 
for i = 1:length(dahsi_filter_beta)
    lam = dahsi_filter_beta(i,2); %get lambda 
    param = dahsi_filter_beta(i,5:end); %get parameters 
    param ( abs(param) < lam) = 0; %set parameters less than lambda = 0 
    active_terms(i) = nnz(param); %count nonzero elements 
end

%add num active terms to summary
dahsi_summary = horzcat(dahsi_filter_beta,active_terms');

%collect all 8 term models 
models_w_8_terms = dahsi_summary(dahsi_summary(:,end)==8,:); 
[s1,s2] = size(models_w_8_terms);

%set all parameters less than lambda to zero for 8 term models 
for i = 1:s1
    lam = models_w_8_terms(i,2); 
    param = models_w_8_terms(i,5:end-1); 
    param ( abs(param) < lam) = 0; 
    models_w_8_terms(i,5:end-1) = param;
end

%collect all 9 term models 
models_w_9_terms = dahsi_summary(dahsi_summary(:,end)==9,:);
[s1,s2] = size(models_w_9_terms);

%set all parameters less than lambda to zero for 9 term models 
for i = 1:s1
    lam = models_w_9_terms(i,2); 
    param = models_w_9_terms(i,5:end-1); 
    param ( abs(param) < lam) = 0; 
    models_w_9_terms(i,5:end-1) = param;
end

%collect all 10 term models 
models_w_10_terms = dahsi_summary(dahsi_summary(:,end)==10,:);
[s1,s2] = size(models_w_10_terms);

%set all parameters less than lambda to zero for 10 term models 
for i = 1:s1
    lam = models_w_10_terms(i,2); 
    param = models_w_10_terms(i,5:end-1); 
    param ( abs(param) < lam) = 0; 
    models_w_10_terms(i,5:end-1) = param;
end


figure(1)
for i = 1:length(dahsi_summary)
    semilogy(dahsi_summary(i,end),dahsi_summary(i,3),'o','MarkerFaceColor','#FFB000','MarkerSize',20, 'MarkerEdgeColor','#FFB000')
    hold on
end 

semilogy(8,models_w_8_terms(1,3),'o','MarkerFaceColor','#DC267F','MarkerSize',20, 'MarkerEdgeColor','#DC267F')
semilogy(9,models_w_9_terms(1,3),'o','MarkerFaceColor','#DC267F','MarkerSize',20, 'MarkerEdgeColor','#DC267F')
semilogy(10,models_w_10_terms(1,3),'o','MarkerFaceColor','#DC267F','MarkerSize',20, 'MarkerEdgeColor','#DC267F')
%xlabel("Active Terms")
%ylabel("Cost Function Value")
axis([7 20 5*1e-6 15])
set(gca,'FontSize',fs)
set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
set(gca,'units','normalized','position',[0.1 0.1 0.9 0.9], ...
	'plotboxaspectratio',[1 1 1])
%ax=gca;
% exportgraphics(ax,'1D.tif','Resolution',1000)










