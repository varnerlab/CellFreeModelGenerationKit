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
    operation_type_array = Array{Symbol,1}()
    molecular_symbol_array = Array{String,1}()
    macromolecular_symbol_array = Array{String,1}()
    molecular_species_type_array = Array{Symbol,1}()
    sequence_array = Array{String,1}()

    # what are the alphabets for the sequences?
    dna_sequence_alphabet = ["a","t","g","c"]
    protein_sequence_alphabet = ["G","A","L","M","F","W","K","Q","E","S","P","V","I","C","Y","H","R","N","D","T"]

    try

        # extract the sequence section -
        sequence_section_buffer = _extract_section(buffer, "#TXTL-SEQUENCE::START", "#TXTL-SEQUENCE::STOP")

        # make the buffer flat, and then write to tmp_file -
        flat_buffer = ""
        for line in sequence_section_buffer
            flat_buffer *= line

            if (occursin(";",line) == true)
                flat_buffer *= "\n"
            end
        end
        
        # remove the ; -
        flat_buffer = replace(flat_buffer,";"=>"")

        # ok, so now lets load the tmp file in CSV, and put into a 
        df_tmp = CSV.read(IOBuffer(flat_buffer), DataFrame; header=false)

        # let's create a DataFrame w/the each peice of data in a col -
        [push!(operation_type_array,Symbol(line)) for line in df_tmp[!,:Column1]]
        [push!(molecular_symbol_array, line) for line in df_tmp[!,:Column2]]

        # ok, so we need to do some additional logic for this next bit -
        # what type is the molecular symbol?
        for operation_type in operation_type_array
            if (operation_type == :X)
                push!(molecular_species_type_array,:DNA)
            else
                push!(molecular_species_type_array,:PROTEIN)
            end        
        end

        # we need to split the {RNAP_symbol|Ribosome_symbol}::sequence -
        for record in df_tmp[!,:Column3]
            
            # ok, so we need to split around :: -
            component_array = split(record,"::")

            # the first element is the macromolecular_symbol, the second is the sequence -
            macromolecular_symbol = string(component_array[1])
            sequence_record = string(component_array[2])

            # push! -
            push!(macromolecular_symbol_array, macromolecular_symbol)
            push!(sequence_array, sequence_record)
        end

        # Finally, add everything to new data frame -
        new_sequence_df = DataFrame(operation_type=operation_type_array,
            sequence_type=molecular_species_type_array,
            molecular_symbol=molecular_symbol_array,
            macromolecular_symbol=macromolecular_symbol_array,
            sequence=sequence_array)

        # Analysis of sequences -
        # process the DNA sequence -
        dna_sequence_df = filter(row->row.sequence_type == :DNA, new_sequence_df)
        
        # get dimension of the dna data frame -
        (number_of_dna_sequences,number_of_cols_dna) = size(dna_sequence_df)
        for dna_sequence_index = 1:number_of_dna_sequences
            
            # ok, get the DNA sequence -


        end

        # return the new_df -
        return VLResult(new_sequence_df)
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

function parse_vff_species_bounds_section(buffer::Array{String,1}, metabolic_results_tuple::NamedTuple)::VLResult

    # initialize -
    permissible_bounds_set = Set{Symbol}()
    species_bounds_table = Dict{String,Symbol}()

    try 

        # fill in the permissible_bounds_set -
        push!(permissible_bounds_set, :SINK)
        push!(permissible_bounds_set, :SOURCE)
        push!(permissible_bounds_set, :UNBOUNDED)
        push!(permissible_bounds_set, :BOUNDED)

        # grab the metabolic section -
        molecular_symbol_array = metabolic_results_tuple.molecular_symbol_array

        # ok, first step - put the default, which is bounded -
        for test_biological_symbol in molecular_symbol_array
            species_bounds_table[test_biological_symbol] = :BOUNDED
        end

        # extract the species bounds section -
        species_bounds_section_buffer = _extract_section(buffer, "#SPECIES_BOUNDS::START", "#SPECIES_BOUNDS::STOP")

        # process each bounds record -
        for species_bounds_record in species_bounds_section_buffer
            
            # tokenize -
            token_array = tokenize(species_bounds_record)

            # if this record is formulated correctly, there will be a biological symbol in the first position, and a bound in the last position -
            test_biological_symbol = first(token_array)
            test_bound_type = last(uppercase(token_array))

            # test the first and the last position, do we have these?
            # check: do we have the biological species?
            if (in(test_biological_symbol, molecular_symbol_array) == false)
                error_message = "Cannot classify $(test_biological_symbol). $(test_biological_symbol) is not contained in the molecular_symbol_array"
                throw(ErrorException(error_message))
            end
        
            # check: do we have the correct bound?
            if (in(Symbol(test_bound_type),permissible_bounds_set) == false)
                error_message = "Cannot classify $(test_bound_type). $(test_bound_type) is not a member of the bounds set"
                throw(ErrorException(error_message))
            end

            # so if we get then we have ok bounds 
            species_bounds_table[test_biological_symbol] = Symbol(test_bound_type)
        end 

        # return -
        return VLResult(species_bounds_table)

    catch error
        return VLResult(error)
    end
end

function parse_vff_model_document(model::VLAbstractModelObject; 
        molecular_callback::Union{Function,Nothing} = nothing, reaction_callback::Union{Function,Nothing} = nothing)::VLResult

    # initialize -
    intermediate_representation_dictionary = Dict{String,Any}()

    try 
    
         # get the path to the vff model -
        vff_model_file_path = model.path_to_model_file

        # load the vff buffer -
        vff_file_buffer = read_model_document(vff_model_file_path)

        # -- SEQ SECTION --------------------------------------------------------------------------------- #
        result = parse_vff_sequence_section(vff_file_buffer)
        if (ias(result.value, Exception) == true)
            throw(result.value)
        end
        sequence_data_table = result.value
        # ------------------------------------------------------------------------------------------------ #

        # -- METABOLISM SECTION -------------------------------------------------------------------------- #
        result = parse_vff_metabolic_section(vff_file_buffer; 
            molecular_callback = molecular_callback, reaction_callback = reaction_callback)
        if (isa(result.value,Exception) == true)
            throw(result.value)
        end
        metabolic_section_results_tuple = result.value
        # ------------------------------------------------------------------------------------------------ #

        # -- GRN SECTION --------------------------------------------------------------------------------- #
        # ------------------------------------------------------------------------------------------------ #

        # -- SPECIES BOUNDS SECTION ---------------------------------------------------------------------- #
        species_bound_result = parse_vff_species_bounds_section(vff_file_buffer,metabolic_section_results_tuple)
        if (isa(species_bound_result.value, Exception) == true)
            throw(species_bound_result.value)
        end
        species_bound_table = species_bound_result.value
        # ------------------------------------------------------------------------------------------------ #

        # ok, put stuff in the IR dictionary -
        intermediate_representation_dictionary[ir_master_reaction_table_key] = metabolic_section_results_tuple.reaction_table
        intermediate_representation_dictionary[ir_list_of_molecular_species_key] = metabolic_section_results_tuple.molecular_symbol_array
        intermediate_representation_dictionary[ir_list_of_reaction_tags_key] = metabolic_section_results_tuple.reaction_tag_array
        intermediate_representation_dictionary[ir_master_species_bounds_table_key] = species_bound_table
        intermediate_representation_dictionary[ir_sequence_section_table_key] = sequence_data_table

        # return -
        return VLResult(intermediate_representation_dictionary)
    catch error
        throw(error)
    end
end