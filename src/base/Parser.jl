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

function _extract_molecular_symbol_array(reaction_table::DataFrame)::Array{String,1}

    # strategy: compile a list of strings, in the order in which they are found from the L and R phrases.
    # Next, cut around the +, ane finally look for any * (which denote st coeff)

    # initialize -
    reaction_phrase_array = Array{String,1}()
    molecular_symbol_array = Array{String,1}()

    # what is the size of the reaction_table?
    (number_of_reaction, number_of_fields) = size(reaction_table)

    # process the L and R phrases -
    [push!(reaction_phrase_array,line) for line in reaction_table[!,:left_phrase]]
    [push!(reaction_phrase_array,line) for line in reaction_table[!,:right_phrase]]

    # ok, so now let's cut around the +'s -
    for phrase in reaction_phrase_array
    
        # compnents -
        if (occursin("+",phrase) == true)
            
            # ok, so we have some +'s
            component_array = split(phrase,"+")
            for component in component_array
                inner_component_array = split(component,"*")
                push!(molecular_symbol_array, string(last(inner_component_array)))
            end
        else
            # we have a single spcies, check for * -
            if (occursin("*",phrase) == true)
                
                # split -
                component_array = split(phrase,"*")

                # the symbol will be the last element -
                push!(molecular_symbol_array, string(last(component_array)))
            else
               # grab -
               push!(molecular_symbol_array, phrase)
            end
        end
    end

    # we want the array to be unique -
    unique!(molecular_symbol_array)

    # return the unique array -
    # NOTE: this is in random order
    return molecular_symbol_array
end

# ------------------------------------------------------------------------------------------------ #

function parse_vff_sequence_section(buffer::Array{String,1})::VLResult

    # initialize -
    # ...

    try

        # extract the sequence section -
        sequence_section_buffer = _extract_section(buffer, "#TXTL-SEQUENCE::START", "#TXTL-SEQUENCE::START")

        # make the buffer flat, and then write to tmp_file -
        flat_buffer = ""
        for line in sequence_section_buffer
            flat_buffer *= line
            flat_buffer *= "\n"
        end
        
        # ok, so now lets load the tmp file in CSV, and put into a 
        df_tmp = CSV.read(IOBuffer(flat_buffer),DataFrame; header=false)

        # let's create 


    catch error
        return VLResult(error)
    end

end

function parse_vff_metabolic_section(buffer::Array{String,1}; 
    molecular_callback::Union{Function,Nothing} = nothing, reaction_callback::Union{Function,Nothing} = nothing)::VLResult

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
        rename!(df_tmp,:Column1 => :reaction_tag)
        rename!(df_tmp,:Column2 => :ec_number_array)
        rename!(df_tmp,:Column3 => :left_phrase)
        rename!(df_tmp,:Column4 => :right_phrase)
        rename!(df_tmp,:Column5 => :is_reaction_reversible)

        # Next, let's get the list of molecular symbols -
        molecular_symbol_array = _extract_molecular_symbol_array(df_tmp)

        # we need to put the symbols in order -
        molecular_symbol_array = reorder_molecular_symbol_array(molecular_symbol_array; callback = molecular_callback)

        # put the reactions in order -
        reaction_tag_array = df_tmp[!,:reaction_tag]
        reaction_tag_array = reorder_reaction_symbol_array(reaction_tag_array; callback = reaction_callback)

        # ok, so let's build a NamedTuple and return to the caller =
        results_tuple = (reaction_table=df_tmp, molecular_symbol_array=molecular_symbol_array, reaction_tag_array=reaction_tag_array)

        # return the data frame -
        return VLResult(results_tuple)
    catch error
        return VLResult(error)
    end
end

function parse_vff_model_document(model::VLAbstractModelObject; 
        molecular_callback::Union{Function,Nothing} = nothing, reaction_callback::Union{Function,Nothing} = nothing)::VLResult

    # initialize -
    intermediate_representation_dictionary = Dict{String,Any}()

    # get the path to the vff model -
    vff_model_file_path = model.path_to_model_file

    # load the vff buffer -
    vff_file_buffer = read_model_document(vff_model_file_path)

    # -- SEQ SECTION --------------------------------------------------------------------------------- #
    result = parse_vff_sequence_section(vff_file_buffer)
    # ------------------------------------------------------------------------------------------------ #

    # -- METABOLISM SECTION -------------------------------------------------------------------------- #
    result = parse_vff_metabolic_section(vff_file_buffer; 
        molecular_callback = molecular_callback, reaction_callback = reaction_callback)
    if (isa(result.value,Exception) == true)
        return result
    end
    metabolic_section_results_tuple = result.value
    # ------------------------------------------------------------------------------------------------ #

    # -- GRN SECTION --------------------------------------------------------------------------------- #
    # ------------------------------------------------------------------------------------------------ #

    # ok, put stuff in the IR dictionary -
    intermediate_representation_dictionary[ir_master_reaction_table_key] = metabolic_section_results_tuple.reaction_table
    intermediate_representation_dictionary[ir_list_of_molecular_species_key] = metabolic_section_results_tuple.molecular_symbol_array
    intermediate_representation_dictionary[ir_list_of_reaction_tags_key] = metabolic_section_results_tuple.reaction_tag_array

    # return -
    return VLResult(intermediate_representation_dictionary)
end