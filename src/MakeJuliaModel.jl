function generate(julia_model_object::VLJuliaModelObject)

    try

        # parse the vff document -
        result = parse_vff_model_document(julia_model_object)
        if (isa(result.value,Exception) == true)
            rethrow(result.value) # re-throw
        end
        ir_dictionary = result.value

        # Step 1: Copy the "distribution" files to thier location -
        path_to_output_dir = julia_model_object.path_to_output_dir

        # Transfer distrubtion jl files to the output -> these files are shared between model types
        transfer_distribution_files("$(path_to_package)/distribution/julia/src", "$(path_to_output_dir)/src",".jl")

        # Transfer root jl files -> these files are moved to the root dir of the file
        transfer_distribution_files("$(path_to_package)/distribution/julia/root", "$(path_to_output_dir)",".jl")

        # Transfer root toml files -> these files are moved to the root dir of the model
        transfer_distribution_files("$(path_to_package)/distribution/julia/root", "$(path_to_output_dir)",".toml")

    catch error
        # if we catch an error, then rethrow -
        rethrow(error)
    end
end