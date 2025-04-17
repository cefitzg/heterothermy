clear 
clc 
close all

hess_6A = readmatrix("6A_hessian.csv"); %read in hessian of Model 6A 
eig_6A=eig(hess_6A); %get eigenvalues 
[V,D]=eig(hess_6A); %get eigenvalues and eigenvectors 

%figure settings
figpos = [100 100 800 600]; %figure position
fs=20; %font size

%plot sloppiness 
figure(2)
semilogy(1:length(eig_6A),1./sqrt(abs(eig_6A)),'o','MarkerSize',20,'MarkerFaceColor','#648FFF') %sloppiness 
%set(gca,'FontSize',25)
xlabel("eigenvalue")
ylabel("sloppines, $$\frac{1}{\sqrt{|eig|}}$$",'Interpreter','Latex')
axis([1 7 min(1./sqrt(abs(eig_6A))) max(1./sqrt(abs(eig_6A)))+3])
set(gca, 'FontName', 'Helvetica')
set(gca,'FontSize',fs)
%set(gcf,'units','pixels','outerposition',figpos,'windowstyle','normal')
%set(gca,'units','normalized','position',[0.2 0.2 0.8 0.8], ...
%	'plotboxaspectratio',[1 1 1])
% ax=gca;
% exportgraphics(ax,'sloppy.tiff','Resolution',1000)

%plot eigenvalue components
figure(3)
for i = 1:7
    nexttile()
    plot(0:6,V(:,i),'o','MarkerSize',10,'MarkerFaceColor','#648FFF')
    xticks([0:6])
        axis([0 6 -1 1])
    xticklabels({'\theta_1','\theta_3','\theta_2','\theta_5','\theta_6','\theta_0','y(0)'})
    title("eigenvalue "+i)
    set(gca,'FontSize',fs)
    set(gca, 'FontName', 'Helvetica')
end 
%saveas(gcf,'eig_comp.tiff')

 
