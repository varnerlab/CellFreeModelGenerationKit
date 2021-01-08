function read_model_document(path_to_file::String; 
    strip_comments::Bool = true)::Array{String,1}

    # initialize -
    buffer = String[]

    # Read in the file -
    open("$(path_to_file)", "r") do file
        for line in eachline(file)
            
            # exclude comments -
            if (occursin("//",line) == false && isempty(line) == false && strip_comments == true)
                +(buffer,line) 
            end
        end
    end

    # return -
    return buffer
end