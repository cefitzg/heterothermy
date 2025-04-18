#Qualitative Arctic ground squirrel thermophysiological model 

#load in modules 
using DataFrames, CSV 
using OrdinaryDiffEq, Plots
using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D

#define tt & SaveTimes 
tt = 0.0:0.1:10000.0
SaveTimes = 0.0:0.1:10000.0
tspan = (tt[1],tt[end])

#IC 
u0=[1e-4,1e-4]

#define model 
@variables x(t) y(t)
@parameters ga l k 
eqs = [D(x) ~ x*(x-ga*y)*(1-x)+l
D(y) ~ k*(x^2-y^2)]


@mtkbuild ags_sys = ODESystem(eqs,t)
ags_sys  = ODEProblem(ags_sys, [x => u0[1], y => u0[2]], tspan, [ga => 1.1 k => 0.1 l => 0.0001])

#solve 
ags_sol = solve(ags_sys, Vern9(),saveat=SaveTimes)
ags_sol_rs = reduce(hcat, ags_sol.u) #reshape

#plot
p1=plot(SaveTimes,ags_sol_rs[1,:],label=["Tb"])
plot!(SaveTimes,ags_sol_rs[2,:],label=["Hidden State"],xlabel="dimensionless time",title="squirrel thermophysiology model")
display(p1) 

#save simulation 
CSV.write("ags_sim.csv",DataFrame(ags_sol_rs,:auto),header=false)



