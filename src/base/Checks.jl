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