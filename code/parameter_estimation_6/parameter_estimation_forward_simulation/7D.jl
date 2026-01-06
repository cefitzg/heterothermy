#arctic ground squirrel re-optimization 

#load in modules 
using Random, LinearAlgebra, DataFrames, CSV, LatinHypercubeSampling
using Base.Threads: @threads
using OrdinaryDiffEq, Optimization, SciMLSensitivity, ForwardDiff, Plots
using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D

Random.seed!(2024)

#define tt & SaveTimes 
tt = 0.0:0.1:293.6
SaveTimes = 0.0:0.1:293.6
tspan = (tt[1],tt[end])

z=10000 #number of seeds to test reoptimization 
tot_num_param = 8 #total number of parameters

#read in data
data = Matrix(CSV.read("ags_training.csv",DataFrame,header=false))

u0=[data[1],-0.03500839]

@variables x(t) y(t)

@parameters B104 B106 B108 B109 B204 B205 l B208

eqs = [D(x) ~ B104*x*x+B106*x*x*x+B108*x*y+B109*x*x*y+l #note Andrew: k2 is the real parameter on the x,y term. I further simplified. 

D(y) ~ B204*x*x+B205*y*y+B208*x*y]

@mtkbuild ags_sys = ODESystem(eqs,t)

p_opt = [9.785506000000000, -9.999987000000001, -9.407997000000000, 1.987823000000000, -2.915110000000000, 0.0019, -0.03500839,0.998481] 

ags_sys  = ODEProblem(ags_sys, [x => u0[1], y => u0[2]], tspan, [B104 => p_opt[1] B106 => p_opt[2] B108=> p_opt[3] B109=> 9.999995000000000 B204 => p_opt[4] B205 => p_opt[5] l=>p_opt[6] B208=>p_opt[7]])

function model_loss(theta)
	_ags_sys = remake(ags_sys,u0=[x => u0[1], y => theta[7]], p=[B104 => theta[1] B106 => theta[2] B108=> theta[3] B204 => theta[4] B205 => theta[5] l=>theta[6] B208=>theta[8]])
	ags_sol = solve(_ags_sys, saveat=SaveTimes)
	ags_sol_rs = reduce(hcat, ags_sol.u) #reshape
	sol = ags_sol_rs[1,:]
	loss = norm(sol[1:2000]-data[1:2000],2)
	return loss
end 



sv=0.5 #how much to vary each parameter around it's optimization values from DAHSI. 

lb = p_opt -sv*abs.(p_opt)
ub = p_opt +sv*abs.(p_opt)

lb[7] = -0.1
ub[7] = 0.1
lb[6] = 1e-5
ub[6] = 1e-3

adtype = Optimization.AutoForwardDiff()
optf = Optimization.OptimizationFunction((x, theta) -> model_loss(x),adtype)


#generate sampling plan: 
plan, _ = LHCoptim(z,tot_num_param,1000,threading=true)
scaled_plan = scaleLHC(plan,[(lb[1],ub[1]),(lb[2],ub[2]),(lb[3],ub[3]),(lb[4],ub[4]),(lb[5],ub[5]),(lb[6],ub[6]),(lb[7],ub[7]),(lb[8],ub[8])]) #could also define function for spreading seeds out differently
store_p = zeros(z,1*tot_num_param+4) #preallocate 

# #perform parameter estimation over z seeds 
@time begin 
	@threads for i in 1:z
		println(i)
		p0 = scaled_plan[i,:]
		store_p[i,:] = try 
			optprob = Optimization.OptimizationProblem(optf, p0, lb=lb, ub=ub)
			etime = @elapsed begin 
			sol = solve(optprob, Optimization.LBFGS(), maxiters = 1000)
			end 
			vcat(i,etime,sol.objective,Int(SciMLBase.successful_retcode(sol)),sol.u)
		catch
			777*ones(1,1*tot_num_param+4)
		end 
	end 
end

println(argmin(store_p[:,3]))

println(store_p[argmin(store_p[:,3]),:])

r = store_p[argmin(store_p[:,3]),4+1:4+tot_num_param]

_ags_sys = remake(ags_sys,u0=[x => u0[1], y => r[7]], p=[B104 => r[1] B106 => r[2] B108=> r[3] B204 => r[4] B205 => r[5] l=>r[6] B208 => r[8]])
ags_sol = solve(_ags_sys, saveat=SaveTimes)
ags_sol_rs = reduce(hcat, ags_sol.u) #reshape
CSV.write("7D_fit.csv",DataFrame(ags_sol_rs,:auto),header=false) 

p1=plot(ags_sol,label=["x" "y"],legend=:outertopright)
plot!(SaveTimes,data[1:2937,1],label=["data"],legend=:outertopright)
xlabel!("time")
ylabel!("Tb")
display(p1) 
CSV.write("7D_info.csv",DataFrame(store_p,:auto),header=false) 

hessian = ForwardDiff.hessian(z -> model_loss(z), r)
CSV.write("7D_hessian.csv",DataFrame(hessian,:auto),header=false)
savefig(p1,"7D")

#long time series for dtw stuff:
tt = 0.0:0.1:293.6*2+0.1
SaveTimes = 0.0:0.1:293.6*2+0.1
#tspan = (tt[1],tt[end])
__ags_sys = remake(_ags_sys,tspan=(tt[1],tt[end]))
ags_sol = solve(__ags_sys, saveat=SaveTimes)
ags_sol_rs = reduce(hcat, ags_sol.u) #reshape
CSV.write("7D_val_fts.csv",DataFrame(ags_sol_rs,:auto),header=false) 

