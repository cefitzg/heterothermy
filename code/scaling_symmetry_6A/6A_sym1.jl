#creates scaling symmetry in Model 6A for Fig 3

#load in modules 
using DataFrames, CSV, Plots
using OrdinaryDiffEq
using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D

#define tt & SaveTimes 
tt = 0.0:0.1:293.6
SaveTimes = 0.0:0.1:293.6
tspan = (tt[1],tt[end])

tot_num_param = 7 #total number of parameters
data = Matrix(CSV.read("ags_training.csv",DataFrame,header=false)) #read in data for x(0)

u0=[data[1],-0.03500839] #y(0) will be replaced optimized values 

#define model with scaling symmetry 
@variables x(t) y(t)
@parameters B104 B106 B108 B109 B204 B205 l
eqs = [D(x) ~ B104*x*x+B106*x*x*x+B108*x*(-y+0.1)+B109*x*x*(-y+0.1)+l 
D(y) ~ -B204*x*x-B205*(-y+0.1)*(-y+0.1)]

@mtkbuild ags_sys = ODESystem(eqs,t)

fits = Matrix(CSV.read("6A_info.csv",DataFrame,header=false)) #read in optimized parameters 
r = fits[argmin(fits[:,3]),4+1:4+tot_num_param] #pick set with lowest cost function value

#build and solve ODEProblem 
_ags_sys = ODEProblem(ags_sys,[x => u0[1], y => -r[7]+0.1], tspan, [B104 => r[1] B106 => r[2] B108=> r[3] B109=> 9.999995000000000 B204 => r[4] B205 => r[5] l=>r[6]])
ags_sol = solve(_ags_sys, saveat=SaveTimes)
ags_sol_rs = reduce(hcat, ags_sol.u) #reshape

#plot 
p=plot(tt,ags_sol_rs[1,:],label=["Tb"],xlabel="Time",title="Scaling Symmetry in Model 6A")
plot!(tt,ags_sol_rs[2,:],label=["Hidden State"],xlabel="Time",title="Scaling Symmetry in Model 6A")
display(p)

#save simulation 
CSV.write("6A_val_sym1.csv",DataFrame(ags_sol_rs,:auto),header=false) 




