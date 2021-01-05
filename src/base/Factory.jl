function build_julia_model_object(path_to_model_file::String, path_to_output_dir::String; 
    defaults_file_name::String="Defaults.toml", model_type::Symbol=:static)::VLResult

    # Checks go here
    # ...

    # build the model wrapper -
    model_object = VLJuliaModelObject(path_to_model_file, path_to_output_dir; 
        defaults_file_name=defaults_file_name, model_type=model_type)

    # return -
    return VLResult{VLJuliaModelObject}(model_object)
end