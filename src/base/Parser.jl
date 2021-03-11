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

# -- PUBLIC FUNCTIONS THAT ARE EXPORTED ---------------------------------------------------------- #
"""
    parse_vff_sequence_section(buffer::Array{String,1})::VLResult
"""
function parse_vff_sequence_section(buffer::Array{String,1})::VLResult

    # initialize -
    operation_type_array = Array{Symbol,1}()
    molecular_symbol_array = Array{String,1}()
    molecular_species_type_array = Array{Symbol,1}()
    sequence_array = Array{String,1}()

    # what are the alphabets for the sequences?
    dna_sequence_alphabet = ["a","t","g","c"]
    protein_sequence_alphabet = ["G","A","L","M","F","W","K","Q","E","S","P","V","I","C","Y","H","R","N","D","T"]

    try

        # extract the sequence section -
        sequence_section_buffer = _extract_section(buffer, "#TXTL-SEQUENCE::START", "#TXTL-SEQUENCE::STOP")
        if (isempty(sequence_section_buffer) == true)
            @warn "Hmmm. No SEQUENCE section was found. That's ok. We'll skip to the next section ..."
            return VLResult(nothing)
        end

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
        [push!(molecular_symbol_array,line) for line in df_tmp[!,:Column1]]
        [push!(sequence_array,line) for line in df_tmp[!,:Column2]]

        # ok, so we need to do some additional logic for this next bit -
        # what type is the molecular symbol?
        for sequence_record in sequence_array
            
            # grab the first element -
            first_sequence_element = string(first(sequence_record))

            # if this in the dna alphabet?
            if (in(first_sequence_element, dna_sequence_alphabet) == true)
                
                push!(molecular_species_type_array,:DNA)
            
            elseif (in(first_sequence_element, protein_sequence_alphabet) == true)
                
                push!(molecular_species_type_array,:PROTEIN)
            else
                
                # we don't know what this is ... put type as missing for now 
                push!(molecular_species_type_array, :UNKOWN)
            end   
        end

        # Finally, add everything to new data frame -
        new_sequence_df = DataFrame(
            sequence_type=molecular_species_type_array,
            molecular_symbol=molecular_symbol_array,
            sequence=sequence_array)

        # return the new_df -
        return VLResult(new_sequence_df)
    catch error
        return VLResult(error)
    end
end

"""
parse_vff_metabolic_section(buffer::Array{String,1})::VLResult
"""
function parse_vff_metabolic_section(buffer::Array{String,1})::VLResult

    try 
        # extract the metabolic section -
        metabolic_section_buffer = _extract_section(buffer, "#METABOLISM::START", "#METABOLISM::STOP")
        if (isempty(metabolic_section_buffer) == true)
            @warn "Hmmm. No METABOLISM section was found. That's ok. We'll skip to the next section ..."
            return VLResult(nothing)
        end

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
        molecular_symbol_array = reorder_molecular_symbol_array(molecular_symbol_array; callback = nothing)

        # put the reactions in order -
        reaction_tag_array = df_tmp[!,:reaction_tag]
        reaction_tag_array = reorder_reaction_symbol_array(reaction_tag_array; callback = nothing)

        # ok, so let's build a NamedTuple and return to the caller =
        results_tuple = (reaction_table=df_tmp, molecular_symbol_array=molecular_symbol_array, reaction_tag_array=reaction_tag_array)

        # return the data frame -
        return VLResult(results_tuple)
    catch error
        return VLResult(error)
    end
end

"""
parse_grn_section(buffer::Array{String,1})::VLResult
"""
function parse_vff_grn_section(buffer::Array{String,1})::VLResult

    # initialize -
    original_record_buffer_dictionary = Dict{Int64,Any}()

    try 

        # get the grn section -
        grn_section_buffer = _extract_section(buffer, "#GRN::START", "#GRN::STOP")
        if (isempty(grn_section_buffer) == true)
            @warn "Hmmm. No GRN section was found. That's ok. We'll skip to the next section ..."
            return VLResult(nothing)
        end        

        # initial tokenize by spaces -
        for (index,grn_record) in enumerate(grn_section_buffer)
            
            # split -
            fragment_array = split(grn_record, " ")
            
            # grab -
            original_record_buffer_dictionary[index] = string.(fragment_array)
        end

        # scan the original record buffer -> to produce the cannonical_reduced_array
        scan_result = minerva_scanner(original_record_buffer_dictionary, grn_scan_function)
        cannonical_reduced_array = check(scan_result)

        # for now - the cannonical_reduced_array -
        return VLResult(cannonical_reduced_array)
    catch error
        return VLResult(error)
    end
end

"""
parse_vff_species_bounds_section(buffer::Array{String,1}, metabolic_results_tuple::NamedTuple)::VLResult
"""
function parse_vff_species_bounds_section(buffer::Array{String,1}, metabolic_results_tuple::NamedTuple)::VLResult

    # initialize -
    # ...

    try 

        # extract the species bounds section -
        species_bounds_section_buffer = _extract_section(buffer, "#SPECIES_BOUNDS::START", "#SPECIES_BOUNDS::STOP")
        if (isempty(species_bounds_section_buffer) == true)
            @warn "Hmmm. No SPECIES_BOUNDS section was found. That's ok. We'll skip to the next section ..."
            return VLResult(nothing)
        end        

        # initial tokenize by spaces -
        for (index, species_bound_record) in enumerate(species_bounds_section_buffer)
            
            # split -
            fragment_array = split(species_bound_record, " ")
            
            # grab -
            original_record_buffer_dictionary[index] = string.(fragment_array)
        end

        # scan the original record buffer -> to produce the cannonical_reduced_array
        scan_result = minerva_scanner(original_record_buffer_dictionary, bound_type_assignment_scan_function)
        cannonical_reduced_array = check(scan_result)

        # for now - the cannonical_reduced_array -
        return VLResult(cannonical_reduced_array)
    catch error
        return VLResult(error)
    end
end

"""
parse_vff_bio_types_section(buffer::Array{String,1})::VLResult
"""
function parse_vff_bio_types_section(buffer::Array{String,1})::VLResult

    # initialize -
    original_record_buffer_dictionary = Dict{Int64,Any}()

    try
        
        # load the types section buffer -
        types_section_buffer = _extract_section(buffer, "BIO-TYPE-PREFIXES::START", "BIO-TYPE-PREFIXES::STOP")
        if (isempty(types_section_buffer) == true)
            @warn "Hmmm. No BIO-TYPES-PREFIXES section was found. That's ok. We'll skip to the next section ..."
            return VLResult(nothing)
        end        
        
        # ok, lets see how this tokenizes -
        for (index,type_record) in enumerate(types_section_buffer)
            
            # tokenize -
            token_array = tokenize(type_record)
            
            # grab -
            original_record_buffer_dictionary[index] = token_array
        end

         # scan the original record buffer -> to produce the cannonical_reduced_array
         scan_result = minerva_scanner(original_record_buffer_dictionary, biological_type_assignment_scan_function)
         cannonical_reduced_array = check(scan_result)
 
         # for now - the cannonical_reduced_array -
         return VLResult(cannonical_reduced_array)
    catch error
        return VLResult(error)
    end
end

"""
parse_vff_model_document(model::VLAbstractModelObject)::VLResult    
"""
function parse_vff_model_document(model::VLAbstractModelObject)::VLResult

    # initialize -
    intermediate_representation_dictionary = Dict{String,Any}()

    try 
    
         # get the path to the vff model -
        vff_model_file_path = model.path_to_model_file

        # load the vff buffer -
        vff_file_buffer = read_model_document(vff_model_file_path)

        # -- TYPES SECTION ------------------------------------------------------------------------------- #
        types_parse_result = parse_vff_bio_types_section(vff_file_buffer)

        # ------------------------------------------------------------------------------------------------ #

        # -- SEQ SECTION --------------------------------------------------------------------------------- #
        result = parse_vff_sequence_section(vff_file_buffer)
        if (isa(result.value, Exception) == true)
            throw(result.value)    
        end
        sequence_data_table = result.value
        # ------------------------------------------------------------------------------------------------ #

        # -- METABOLISM SECTION -------------------------------------------------------------------------- #
        result = parse_vff_metabolic_section(vff_file_buffer)
        if (isa(result.value,Exception) == true)
            throw(result.value)
        end
        metabolic_section_results_tuple = result.value
        # ------------------------------------------------------------------------------------------------ #

        # -- GRN SECTION --------------------------------------------------------------------------------- #
        grn_section_result = parse_vff_grn_section(vff_file_buffer)
        grn_scanned_dictionary = check(grn_section_result)
        # ------------------------------------------------------------------------------------------------ #

        # -- SPECIES BOUNDS SECTION ---------------------------------------------------------------------- #
        species_bound_result = parse_vff_species_bounds_section(vff_file_buffer,metabolic_section_results_tuple)
        species_scanner_dictionary = check(species_bound_result)
        # ------------------------------------------------------------------------------------------------ #

        # ok, put stuff in the IR dictionary -
        intermediate_representation_dictionary[ir_master_reaction_table_key] = metabolic_section_results_tuple.reaction_table
        intermediate_representation_dictionary[ir_list_of_molecular_species_key] = metabolic_section_results_tuple.molecular_symbol_array
        intermediate_representation_dictionary[ir_list_of_reaction_tags_key] = metabolic_section_results_tuple.reaction_tag_array
        intermediate_representation_dictionary[ir_master_species_bounds_table_key] = species_scanner_dictionary
        intermediate_representation_dictionary[ir_sequence_section_table_key] = sequence_data_table

        # return -
        return VLResult(intermediate_representation_dictionary)
    catch error
        throw(error)
    end
end
# ------------------------------------------------------------------------------------------------ #