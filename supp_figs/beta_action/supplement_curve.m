clear 
clc 
close all 

dahsi_filter = readmatrix("model_selection_output.csv"); %read in all model structures 

figure(41)
nrows = 3; % number of subplot rows
ncols = 13; % number of subplot columns
nsubs = nrows * ncols; % total number of subplots
tiledlayout(nrows, ncols)
for i = 1:nsubs
    tmp = round(0.05*i,2); %increment lambda 
    dahsi_sort_by_lambda = dahsi_filter(dahsi_filter(:,2)==tmp,:); %sort by each lambda value
    nexttile
    semilogy(dahsi_sort_by_lambda(:,4),dahsi_sort_by_lambda(:,3),'x','Color','#785EF0') %plot 
    hold on 
    xline(75,'LineWidth',2,'Color','#FFB000'); %beta=75 cutoff 
    xline(85,'r','LineWidth',2,'Color','#FFB000'); %beta=85 cutoff 
    title("\lambda= " + tmp,'FontSize',22)
    xlabel("\beta",'FontSize',22)
    ylabel("CFV",'FontSize',22)
    xlim([0 120])
end

