#Qualitative noisy miner thermophysiological model 

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
u0=[1-1e-4,1e-4]

#build model 
@variables x(t) y(t) f(t)
@parameters ga l k 
eqs = [
f ~ 0.1*sin((2*pi*t)/300) + 0.1
D(x) ~ -(x-f)*(1-x-ga*y)*(1-x)-l
D(y) ~ k*((1-x)^2-y^2)]

@mtkbuild nm_sys = System(eqs,t)
nm_sys  = ODEProblem(nm_sys, [x => u0[1], y => u0[2]], tspan, [ga => 1.6 l => 0.009 k => 0.15])

#solve
nm_sol = solve(nm_sys, Vern9(),maxiters=1e10,saveat=SaveTimes)
nm_sol_rs = reduce(hcat, nm_sol.u) #reshape

#plot
p1=plot(SaveTimes,nm_sol_rs[1,:],label=["Tb"])
plot!(SaveTimes,nm_sol_rs[2,:],label=["Hidden State"],xlabel="dimensionless time",title="noisy miner thermophysiology model")
display(p1) 

#save simulation 
CSV.write("miner_sim.csv",DataFrame(nm_sol_rs,:auto),header=false)



