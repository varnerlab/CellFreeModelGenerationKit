function _extract_reaction_phrase_table(phrase::String)::Dict{String,Float64}

    # initialize -
    reaction_phrase_table = Dict{String,Float64}()
    molecular_symbol_array = Array{String,1}()

    # compnents -
    if (occursin("+",phrase) == true)
            
        # ok, so we have some +'s
        component_array = split(phrase,"+")
        for component in component_array
            
            # split around the * -
            inner_component_array = split(component,"*")

            # if len(inner_component_array) == 1, then no *
            # if len(inner_component_array) == 2, then we have a st coeff -
            if (length(inner_component_array) == 1)
                
            elseif (length(inner_component_array) == 2)
            
            else
                # error state:
            end

            push!(molecular_symbol_array, string(last(inner_component_array)))
        end
    else
    end
    
    # return -
    return reaction_phrase_table
end

function _extract_stoichiometric_coefficient(phrase::String, speciesSymbol::String)::Float64
    
    # initialize -
    stoichiometric_coefficient = 0.0 # default is 0, species in NOT involved 
    
    # get the reaction phrase table -
    reaction_phrase_table = _extract_reaction_phrase_table(phrase)

    # ok, look up the species in the phrase table, if its there we have a match - no = 0
    if (haskey(reaction_phrase_table,speciesSymbol) == true)
        return reaction_phrase_table[speciesSymbol]
    end

    # return -
    return stoichiometric_coefficient
end

"""
    generate_stoichiometric_matrix(intermediate_dictionary::Dict{String,Any})::VLResult
"""
function generate_stoichiometric_matrix(intermediate_dictionary::Dict{String,Any})::VLResult

    # initialize -


    try

        # check: do we have the ir_master_reaction_table_key?
        if (haskey(intermediate_dictionary, ir_master_reaction_table_key) == false)
            throw(ArgumentError("intermediate_dictionary is missing the ir_master_reaction_table_key"))
        end

        # check: do we have the ir_list_of_molecular_species_key?
        if (haskey(intermediate_dictionary, ir_list_of_molecular_species_key) == false)
            throw(ArgumentError("intermediate_dictionary is missing the ir_list_of_molecular_species_key"))
        end

        # get reaction data frame, and species list -
        reaction_data_frame = intermediate_dictionary[ir_master_reaction_table_key]
        list_of_species = intermediate_dictionary[ir_list_of_molecular_species_key]

        # ok, so we need to initialize some space for the stm -
        number_of_species = length(list_of_species)
        number_of_reactions = size(reaction_data_frame,1)
        stoichiometric_matrix = Array{Float64,2}(undef, number_of_species, number_of_reactions)

        # process each species -
        for (species_index,species_symbol) in enumerate(list_of_species)

            # process each reaction -
            for reaction_index = 1:number_of_reactions
                
                # get the left and right phrases -
                left_phrase = reaction_data_frame[reaction_index,:left_phrase]
                right_phrase = reaction_data_frame[reaction_index,:right_phrase]

                # check: is this species symbol in the left or right phrase?
                left_st_coeff = _extract_stoichiometric_coefficient(left_phrase, species_symbol)
                right_st_coeff = _extract_stoichiometric_coefficient(right_phrase, species_symbol)

                # overall coeff -
                overall_st_coeff = right_st_coeff - left_st_coeff

                # grab -
                stoichiometric_matrix[species_index,reaction_index] = overall_st_coeff
            end
        end

        # return -
        return VLResult(stoichiometric_matrix)
    catch error
        return VLResult(error)
    end
end