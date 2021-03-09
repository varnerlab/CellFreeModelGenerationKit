function is_file_path_ok(path_to_file::String)::VLResult

    if (isfile(path_to_file) == false)

        # error message -
        error_message = "Ooops! $(path_to_file) does not exist."
        error_object = ArgumentError(error_message)

        # return -
        return VLResult{ArgumentError}(error_object)
    end

    # default: return nothing -
    return VLResult(nothing)
end

function is_dir_path_ok(path_to_file::String)::VLResult

    # get the dir of the path -
    dir_name = dirname(path_to_file)

    # check, is this a legit dir?
    if (isdir(dir_name) == false)

        # error message -
        error_message = "Ooops! $(dir_name) does not exist."
        error_object = ArgumentError(error_message)

        # return -
        return VLResult{ArgumentError}(error_object)
    end

    # default: return nothing -
    return VLResult(nothing)
end

function check(result::VLResult; logger::Union{Nothing,SimpleLogger} = nothing)::(Union{Nothing,T} where T<:Any)

    # ok, so check, do we have an error object?
    # Yes: log the error if we have a logger, then throw the error. 
    # No: return the result.value

    # Error case -
    if (isa(result.value, Exception) == true)
        
        # get the error object -
        error_object = result.value

        # get the error message as a String -
        error_message = sprint(showerror, error_object)
    
        # log -
        if (isnothing(logger) == false)
            with_logger(logger) do
                @error(error_message)
            end
        end

        # throw -
        throw(result.value)
    end

    # default -
    return result.value
end