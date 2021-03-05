# include the strategy for this language -
include("./strategy/JuliaStrategy.jl")

"""
    generate(julia_model_object::VLJuliaModelObject; 
        intermediate_representation_dictionary::Union{Nothing,Dict{String,Any}} = nothing, 
        logger::Union{Nothing,SimpleLogger} = nothing)
"""
function generate(julia_model_object::VLJuliaModelObject; 
    intermediate_representation_dictionary::Union{Nothing,Dict{String,Any}} = nothing, 
    logger::Union{Nothing,SimpleLogger} = nothing)

    # initialize -
    src_component_set = Set{NamedTuple}()
    config_component_set = Set{NamedTuple}()
    root_component_set = Set{NamedTuple}()

    try

        # check: do we have an intermediate representation?
        ir_dictionary = intermediate_representation_dictionary
        if (isnothing(intermediate_representation_dictionary) == true)
            
            # parse the vff document -
            result = parse_vff_model_document(julia_model_object)
            if (isa(result.value,Exception) == true)
                rethrow(result.value) # TODO: what is the diff between re-throw -vs- throw?
            end
            ir_dictionary = result.value
        end

        # Step 1: Copy the "distribution" files to thier location -
        path_to_output_dir = julia_model_object.path_to_output_dir

        # Transfer distrubtion jl files to the output -> these files are shared between model types
        transfer_distribution_files("$(path_to_package)/distribution/julia/src", "$(path_to_output_dir)/src",".jl")

        # Transfer root jl files -> these files are moved to the root dir of the file
        transfer_distribution_files("$(path_to_package)/distribution/julia/root", "$(path_to_output_dir)",".jl")

        # Transfer root toml files -> these files are moved to the root dir of the model
        transfer_distribution_files("$(path_to_package)/distribution/julia/root", "$(path_to_output_dir)",".toml")

        # start building the custom program components -
        # Build the Data.jl data dictionary -
        program_component = build_data_dictionary_program_component(ir_dictionary)
        if (isa(program_component.value, Exception) == true)
            throw(program_component.value)
        end
        data_dictionary_component = program_component.value
        push!(src_component_set, data_dictionary_component)

        # Build the Kinetics.jl file which holds all the rates -
        program_component = build_kinetics_program_component(ir_dictionary)
        if (isa(program_component.value, Exception) == true)
            throw(program_component.value)
        end
        kinetics_file_component = program_component.value
        push!(src_component_set, kinetics_file_component)

        # Build the Control.jl file which holds the control values for each rate -
        program_component = build_control_program_component(ir_dictionary)
        if (isa(program_component.value, Exception) == true)
            throw(program_component.value)
        end
        control_file_component = program_component.value
        push!(src_component_set, control_file_component)

        # Generate the stoichiometric_matrix -
        stm_generation_result = generate_stoichiometric_matrix(ir_dictionary)
        if (isa(stm_generation_result.value,Exception) == true)
            throw(stm_generation_result.value)
        end
        stoichiometric_matrix = stm_generation_result.value
        stm_program_component = (matrix=stoichiometric_matrix, filename="Network.dat", component_type=:matrix)
        push!(src_component_set, stm_program_component)

        # dump src and config components to disk -
        _output_path_to_src_distribution_files = joinpath(path_to_output_dir,"src")
        write_program_components_to_disk(_output_path_to_src_distribution_files, src_component_set)

        # let the user know the model has been generated ...
        @info "Model code generation has completed. Please check: $(path_to_output_dir) for your model files."

    catch error
        
        # let the user know that something went wrong, and prompt them to the log file -
        @info "Model code generation failed before completion. If logging is enabled, please check the log file."

        # ok, so if we get an error, log it (if we have a logger), then explode -
        if (isnothing(logger) == false)
            with_logger(logger) do 
                # generate a back trace -
                @error "Ooops! we encountered an error" exception=(error, catch_backtrace())
            end
        end
    end
end