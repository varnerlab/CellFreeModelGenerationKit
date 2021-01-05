function contains(string,token)
    return occursin(token,string)
end

function read_file_from_path(path_to_file::String)::Array{String,1}

    # initialize -
    buffer = String[]

    # Read in the file -
    open("$(path_to_file)", "r") do file
        for line in eachline(file)
            +(buffer,line)
        end
    end

    # return -
    return buffer
end

function extract_section(file_buffer_array::Array{String,1}, start_section_marker::String, 
    end_section_marker::String)::Array{String,1}

    # initialize -
    section_buffer = String[]

    # find the SECTION START AND END -
    section_line_start = 1
    section_line_end = 1
    for (index,line) in enumerate(file_buffer_array)

        if (occursin(start_section_marker,line) == true)
            section_line_start = index
        elseif (occursin(end_section_marker,line) == true)
            section_line_end = index
        end
    end

    for line_index = (section_line_start+1):(section_line_end-1)
        line_item = file_buffer_array[line_index]
        push!(section_buffer,line_item)
    end

    # return -
    return section_buffer
end