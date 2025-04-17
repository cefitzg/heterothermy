clear 
clc 
close all 

%read in hibernation data 
ags_data = readmatrix("9903_M_Toolik_temp.csv"); 
ags_data(:,2); %extract temperature 

%scale data 
training=rescale(ags_data(10811:13747,2)); 
validate=rescale(ags_data(13748:16573+111,2));

%writematrix(validate,"ags_validate.csv")
%writematrix(training,"ags_training.csv")





