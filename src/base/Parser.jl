# -- PRIVATE FUNCTIONS NOT EXPORTED -------------------------------------------------------------- #
function _extract_section(file_buffer_array::Array{String,1}, start_section_marker::String, 
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
# ------------------------------------------------------------------------------------------------ #

function parse_vff_metabolic_section(buffer::Array{String,1})::VLResult

    try 
        # extract the metabolic section -
        metabolic_section_buffer = _extract_section(buffer, "#METABOLISM::START", "#METABOLISM::STOP")

        # make the buffer flat, and then write to tmp_file -
        flat_buffer = ""
        for line in metabolic_section_buffer
            flat_buffer *= line
            flat_buffer *= "\n"
        end
        
        # ok, so now lets load the tmp file in CSV, and put into a 
        df_tmp = CSV.read(IOBuffer(flat_buffer),DataFrame; header=false)

        # rename the cols -
        rename!(df_tmp,:Column1 => :reaction_name)
        rename!(df_tmp,:Column2 => :ec_number_array)
        rename!(df_tmp,:Column3 => :phrase_reactant)
        rename!(df_tmp,:Column4 => :phrase_product)
        rename!(df_tmp,:Column5 => :is_reaction_reversible)

        # return the data frame -
        return VLResult(df_tmp)
    catch error
        return VLResult(error)
    end
end

function parse_vff_model_document(model::VLAbstractModelObject)::VLResult

    # initialize -
    intermediate_representation_dictionary = Dict{String,Any}()

    # get the path to the vff model -
    vff_model_file_path = model.path_to_model_file

    # load the vff buffer -
    vff_file_buffer = read_model_document(vff_model_file_path)

    # -- SEQ SECTION --------------------------------------------------------------------------------- #
    # ------------------------------------------------------------------------------------------------ #

    # -- METABOLISM SECTION -------------------------------------------------------------------------- #
    result = parse_vff_metabolic_section(vff_file_buffer)
    if (isa(result.value,Exception) == true)
        return result
    end
    df_metabolic_reaction_table = result.value
    # ------------------------------------------------------------------------------------------------ #

    # -- GRN SECTION --------------------------------------------------------------------------------- #
    # ------------------------------------------------------------------------------------------------ #

    # ok, put stuff in the IR dictionary -
    intermediate_representation_dictionary[ir_master_reaction_table_key] = df_metabolic_reaction_table 

    # return -
    return VLResult(intermediate_representation_dictionary)
end