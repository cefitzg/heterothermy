using CSV, DataFrames
using Printf

#written by Andrew Engedal & modified by Cody FitzGerald

#parse arguments
directory = ARGS[1]
seed_start = parse(Int, ARGS[2])
seed_end = parse(Int, ARGS[3])
output_file = ARGS[4]

seeds = seed_start:seed_end

#seed, cost, parameters (16 in this case), initial conditions(2)
models = []

for seed in seeds
	#load in files
	#need separate cost function file because for some reason I didn't include that in the unfiltered output
	costfunc_file = normpath(joinpath(@__DIR__, directory, "D2_M1_IC$(seed)_Hibernation.dat"))
	unfiltered_params_file = normpath(joinpath(@__DIR__, directory, "D2_M1_IC$(seed)_HibernationUnfiltered.dat"))

	#read important info from each line into floats
	cost_vals = readlines(costfunc_file) .|> line -> parse(Float64, split(line, " ")[3])	
	params = readlines(unfiltered_params_file) .|> line -> parse.(Float64, split(line, " ")[1:5896])

	#select all lines
	cost_select = cost_vals[(1):(1):(length(cost_vals))]
	params_select = params[(1):(1):(length(params))]
	
	for i in 1:length(params_select)
		new_model = zeros(24)
		new_model[1] = seed
		param_vals = params_select[i]
		cost = cost_select[i]

		new_model[2] = param_vals[1]
		new_model[3] = cost
		new_model[4] = param_vals[2]
		new_model[5:24] = param_vals[end-19:end]
		#new_model[20:21] = initial_conditions
		
		push!(models, new_model)
	end
end

model_matrix = vcat([model' for model in models]...) 

#sort by cost function
sorted_models = model_matrix[sortperm(model_matrix[:, 3]), :]

#store in file
CSV.write(output_file,DataFrame(sorted_models,:auto),header=false) 
