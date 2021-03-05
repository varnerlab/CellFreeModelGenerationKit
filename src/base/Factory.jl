"""
    build_julia_model_object(path_to_model_file::String, path_to_output_dir::String; 
        defaults_file_name::String="Defaults.toml", model_type::Symbol=:static)::VLResult
"""
function build_julia_model_object(path_to_model_file::String, path_to_output_dir::String; 
    defaults_file_name::String="Defaults.toml", model_type::Symbol=:static)::VLResult

    # Check: is path_to_model_file legit?
    check_result = is_file_path_ok(path_to_model_file)
    if (isnothing(check_result.value) == false)
        return check_result
    end

    # Check: do we have a trailing slash on the path_to_output_dir?
    last_char = path_to_output_dir[end]
    if (last_char == '/')
        path_to_output_dir = path_to_output_dir[1:(end-1)]
    end
    
    # Check: is path_to_output_dir legit?
    # before we get too far along, we need to check if the user already has code in the location that we want to generate at -
    # if they do, then move it -    
    if (isdir(path_to_output_dir) == true)

        # let the user know that we found code -
        @info "Ooops! We found some code where you wanted to generate your model code."

        # ask the user: should we move or delete?
        user_input_result = _request_user_input("Overwrite the existing project files [Y]/N ? ")
        if (lowercase(user_input_result) == "no" || lowercase(user_input_result) == "n")

            @info "Got it. Backing up the existing files ..."
           
            # ok, looks like we may have a conflict - mv the offending code
            if (move_existing_project_at_path(path_to_output_dir) == false)
            
                # Something happend ... the world is ending ...
                error = ArgumentError("automatic directory conflict resolution failed. Unable to move existing directory $(path_to_output_dir)")
                return VLResult(error)
            end 
        else
            @info "Ok! Overwriting the existing files ..."
        end
    end

    # Check: do we have a defaults file?
    path_to_defaults_file = joinpath(dirname(path_to_model_file), defaults_file_name)
    if (isfile(path_to_defaults_file) == false)
        
        # ok, we do not have a defaults file, so lets build one, and let the user know -
        generate_defaults_result = generate_default_project_file(path_to_defaults_file)
        if (isnothing(generate_defaults_result.value) == false)
            return generate_defaults_result
        end

        # let the user know that we have generated a new Defaults.toml file -
        @info "We generated Defaults.toml using the generate_default_project_file function, see the help system in the REPL"
    end

    # build the model wrapper -
    model_object = VLJuliaModelObject(path_to_model_file, path_to_output_dir; 
        defaults_file_path=path_to_defaults_file, model_type=model_type)

    # return -
    return VLResult{VLJuliaModelObject}(model_object)
end