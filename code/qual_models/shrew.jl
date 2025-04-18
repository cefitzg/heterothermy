#Qualitative elephant shrew thermophysiological model 

#load in modules 
using DataFrames, CSV, Random
using StochasticDiffEq, Plots
using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D

Random.seed!(2025) #set random seed. 

#define tt & SaveTimes 
tt = 0.0:0.1:10000.0
SaveTimes = 0.0:0.1:10000.0
tspan = (tt[1],tt[end])

#IC 
u0=[1-1e-4,1e-4]

#build model 
@variables x(t) y(t) f(t)
@parameters ga l k 
@brownian a
eqs = [
f ~ 0.1*sin((2*pi*t)/300) + 0.1
D(x) ~ -(x-f)*(1-x-ga*y)*(1-x)-l*a
D(y) ~ k*((1-x)^2-y^2)]

@mtkbuild es_sys = System(eqs,t)
es_sys  = SDEProblem(es_sys, [x => u0[1], y => u0[2]], tspan, [ga => 1.6 l => 0.02 k => 0.3])

#solve 
es_sol = solve(es_sys, LambaEulerHeun(), maxiters=1e10,saveat=SaveTimes)
es_sol_rs = reduce(hcat, es_sol.u) #reshape

#plot 
p1=plot(SaveTimes,es_sol_rs[1,:],label=["Tb"])
plot!(SaveTimes,es_sol_rs[2,:],label=["Hidden State"],xlabel="dimensionless time",title="shrew thermophysiology model")
display(p1) 

#save simulation 
CSV.write("shrew_sim.csv",DataFrame(es_sol_rs,:auto),header=false)



