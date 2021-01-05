# abstract types
abstract type VLAbstractModelObject end

# concrete types -
struct VLResult{T}
    value::T
end

struct VLJuliaModelObject <: VLAbstractModelObject

    # data -
    path_to_model_file::String
    path_to_output_dir::String
    defaults_file_name::String 
    model_type::Symbol

    # constructor -
    function VLJuliaModelObject(path_to_model_file, path_to_output_dir; 
        defaults_file_name::String="Defaults.toml", model_type::Symbol=:static )
        
        # build new model object -
        this = new(path_to_model_file, path_to_output_dir; 
            defaults_file_name=defaults_file_name, model_type=model_type)
    end
end
