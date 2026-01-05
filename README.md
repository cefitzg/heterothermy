# "Discovering universal temperature regulation dynamics in animals" https://arxiv.org/abs/2504.00359 code base

## ai_files
* contains .ai files (and pdf versions) of figures in the main text. 

## fig1
* contains matlab scripts to reproduce panels in Figure 1 in the main text. 

## fig2 
* contains matlab scripts to reproduce panels in Figure 2 in the main text.

## fig3 
* contains matlab scripts to reproduce panels in Figure 3 in the main text.

## fig4 
* contains matlab scripts to reproduce panels in Figure 4 in the main text.

## fig5 
* contains matlab scripts to reproduce panels in Figure 5 in the main text.

## supp_figs
* contains matlab scripts to reproduce supplementary figures. 

## code directory includes: 
* DAHSI_Dockerfile folder 
	* Contains dockerized version of "DAHSI" sparse model selection algorithm, as described here: https://pubs.aip.org/aip/cha/article/32/6/063101/2835714.
	* Dockerfiles also hosted here: https://github.com/nuitrcs/quest_software_dockerfiles/tree/main/DAHSI.
	* !To do! DAHSI_files subdirectory contains data and configuration scripts used during model selection. 
* data_scaling folder 
	* Matlab script used for scaling the training and validation data.  
* identifiability_check folder 
	* Julia script to check the identifiability of model 10. 
* parameter_estimation_6 folder 
	* sample parameter estimation of Model 6. 
* qual_models folder 
	* Forward simulations of the qualitative models describing the dynamics of the shrew, noisy miner, and the black bear seen in Figure 5D. Note: in review we changed the qualitative dynamics of the Arctic ground squirrel to be the same as Figure 4. !To do! remove AGS files. 
* scaling_symmetry_6 folder 
	* Code for simulating Model 6 with change of variables $\tilde{y}=-y$ seen in Figure 3C (bottom). 
