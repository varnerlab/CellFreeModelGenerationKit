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

function transfer_distribution_file(path_to_distribution_files::String,
                                      input_file_name_with_extension::String,
                                      path_to_output_files::String,
                                      output_file_name_with_extension::String)

    # Load the specific file -
    # create src_buffer -
    src_buffer::Array{String} = String[]

    # check - do we have the file path?
    if (isdir(path_to_output_files) == false)
        mkpath(path_to_output_files)
    end

    # path to distrubtion -
    path_to_src_file = path_to_distribution_files*"/"*input_file_name_with_extension
    open(path_to_src_file,"r") do src_file
        for line in eachline(src_file)

            # need to add a new line for some reason in Julia 0.6
            new_line_with_line_ending = line*"\n"
            push!(src_buffer,new_line_with_line_ending)
        end
    end

    # Write the file to the output -
    path_to_program_file = path_to_output_files*"/"*output_file_name_with_extension
    outfile = open(path_to_program_file, "w")
    write(outfile,src_buffer);
    close(outfile);
end

function transfer_distribution_files(path_to_distribution_files::String,
                                      path_to_output_files::String,
                                      file_extension::String)


    # Search the directory for src files -
    # load the files -
    searchdir(path,key) = filter(x->contains(x,key),readdir(path))

    # build src file list -
    list_of_src_files = searchdir(path_to_distribution_files,file_extension)

    # check - do we have the file path?
    if (isdir(path_to_output_files) == false)
        mkpath(path_to_output_files)
    end

    # go thru the src file list, and copy the files to the output path -
    for src_file in list_of_src_files

        # create src_buffer -
        src_buffer::Array{String,1} = String[]

        # path to distrubtion -
        path_to_src_file = path_to_distribution_files*"/"*src_file
        open(path_to_src_file,"r") do src_file
            for line in eachline(src_file)

                # need to add a new line for some reason in Julia 0.6
                new_line_with_line_ending = line*"\n"
                push!(src_buffer,new_line_with_line_ending)
            end
        end

        # Write the file to the output -
        path_to_program_file = path_to_output_files*"/"*src_file
        open(path_to_program_file, "w") do f
            for line in src_buffer
                write(f,line)
            end
        end
    end
end


function write_program_components_to_disk(file_path::String, set_of_program_components::Set{NamedTuple})

    # check - do we have teh file path?
    if (isdir(file_path) == false)
      mkpath(file_path)
    end
  
    # go through each component, and dump the buffer to disk -
    for program_component in set_of_program_components
  
      # We switch on type -
      filename = program_component.filename
      component_type = program_component.component_type
      if (component_type == :buffer)
  
          # get the data -
          program_buffer = program_component.buffer
  
          # build the path -
          path_to_program_file = file_path*"/"*filename
  
          # Write the file -
          outfile = open(path_to_program_file, "w")
          write(outfile,program_buffer);
          close(outfile);
  
      elseif (component_type == :matrix || component_type == :vector)
          
          # get the matrix -
          program_matrix = program_component.matrix
      
          # build the path -
          path_to_program_file = file_path*"/"*filename
  
          # write the file -
          writedlm(path_to_program_file, program_matrix)
  
      else
          error("unsupported program component type: $(component_type)")
      end
    end
  end