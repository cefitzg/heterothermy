#Qualitative elephant shrew thermophysiological model 

#load in modules 
using DataFrames, CSV, Random
using OrdinaryDiffEq, Plots
using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D

Random.seed!(2025) #set random seed. 

#define tt & SaveTimes 
tt = 0.0:0.1:10000.0
SaveTimes = 0.0:0.1:10000.0
tspan = (tt[1],tt[end])

#IC 
u0=[1-1e-4,1e-4]

@variables x(t) y(t) h(t) g(t)
@parameters ga l k 

eqs = [
h ~ 0.3*cos((2*pi*t)/10000) + 0.3
g ~ 0.2*cos((2*pi*t)/10000) + 0.8
D(x) ~ -(x-h)*(g-x-ga*y)*(g-x)-l
D(y) ~ k*((g-x)^2-y^2)]

@mtkbuild bb_sys = System(eqs,t)
bb_sys  = ODEProblem(bb_sys, [x => u0[1], y => u0[2]], tspan, [ga => 1.5 l => 0.0015 k => 0.1])

bb_sol = solve(bb_sys, Vern9(),saveat=SaveTimes)
bb_sol_rs = reduce(hcat, bb_sol.u) #reshape

p1=plot(SaveTimes,bb_sol_rs[1,:],label=["Tb"])
plot!(SaveTimes,bb_sol_rs[2,:],label=["Hidden State"],xlabel="dimensionless time",title="bear thermophysiology model")
display(p1) 

CSV.write("bear_sim.csv",DataFrame(bb_sol_rs,:auto),header=false)



