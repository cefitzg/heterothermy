# Discovering a low-dimensional temperature control architecture across animals https://arxiv.org/abs/2504.00359 codebase

## Figure Directories:

* ai_files directory
	* contains .ai files (and pdf versions) of figures in the main text. 

* fig1 directory
	* contains matlab scripts to reproduce panels in Figure 1 in the main text. 

* fig2 directory
	* contains matlab scripts to reproduce panels in Figure 2 in the main text.

* fig3 directory
	* contains matlab scripts to reproduce panels in Figure 3 in the main text.

* fig4 directory
	* contains matlab scripts to reproduce panels in Figure 4 in the main text.

* fig5 directory
	* contains matlab scripts to reproduce panels in Figure 5 in the main text.

* supp_figs directory
	* contains matlab scripts to reproduce supplementary figures. 

## Code Directory: 

This project utilizes several, somewhat involved bases written by myself, Andrew Engedal, and the authors of the paper: https://pubs.aip.org/aip/cha/article/32/6/063101/2835714. The code is written in Python, Julia, Matlab, and some bash. 
 
* DAHSI_Dockerfile folder 
	* Contains dockerized version of "DAHSI" sparse model selection algorithm, as described here: https://pubs.aip.org/aip/cha/article/32/6/063101/2835714. The algorithm is written in Python. 
	* Dockerfiles also hosted here: https://github.com/nuitrcs/quest_software_dockerfiles/tree/main/DAHSI.
	* DAHSI_files subdirectory contains data (ags_training.dat), configuration scripts (File1.txt, File2.txt, File3.txt) for the model selection algorithm, and bash submission script (sub.sh). 
	* Helper_script subdirectory contains a helper script (combine.jl) we used to compile the model selection output (estimates for the states and parameters of the systems) on the HPC cluster. TO DO: add exact Project.toml from QUEST Supercomputer. 
* data_scaling folder 
	* Matlab script used for scaling the training and validation data.  
* identifiability_check folder 
	* Julia script to check the identifiability of model 10. Project.toml included. 
* parameter_estimation_6 folder 
	* sample parameter estimation of Model 6. All julia scripts related to parameter estimation across the 16 models considered (forward simulation-based) are in the folder parameter_estimation_forward_simulation. A Project.toml file is included for the Julia dependencies. Julia version 1.10.4 was used. Originally, this calculation was run on a Mac Studio with 24 cores. 
* qual_models folder 
	* Forward simulations of the qualitative models describing the dynamics of the shrew, noisy miner, and the black bear seen in Figure 5D. Note: in review we changed Figure 5D and 5E to be the same as Figure 4B and 4C. Project.toml included. 
* scaling_symmetry_6 folder 
	* Code for simulating Model 6 with change of variables $\tilde{y}=-y$ seen in Figure 3C (bottom). Project.toml included. 
* Nondimensionalization 
	* Contains maple scripts for the nondimensionalizations used in the paper. Maple requires a license. 

## Computational requirements and computing notes. 

Julia version 1.10.4 was used for this project in the code subdirectory (see juliaup to get 1.10.4 https://github.com/JuliaLang/juliaup). A Project.toml file is included for the necessary Julia dependencies in each folder. The code was run with the requirements globally installed. To re-run code without globally installing the dependencies, activate a local environment using a Project.toml file, include the following code at the top any julia script you want to run: 

```julia
using Pkg;
Pkg.activate(@__DIR__);
Pkg.instantiate()
```
Then run from the terminal: 

```
julia --project=. {script_name.jl}
```


MATLAB version 2023B was used for all MATLAB-based calculations. 

The model selection algorithm was run on Quest high performance computing facility at Northwestern University

<!---
* Chaetev_Theorem_Calculation 
	* **!To do!**
* Private REPO for Figure 5, as some of the data cannot be released. 
* Test all code on several machines. 
--->

