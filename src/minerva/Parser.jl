# -- PRIVATE METHODS ------------------------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------- #

# -- PUBLIC METHODS ------------------------------------------------------------------------------------------- #
function minerva_parser(records::Dict{Int64,Array{MinervaToken,1}}, parseFunction::Function;
    logger::Union{Nothing,SimpleLogger} = nothing)::VLResult

    # initialize -
    parsed_records_dictionary = Dict{Int64,NamedTuple}()

    try
    
        # so for each record in my records array, lets scan -
        for (key, record) in records
            parse_result = parseFunction(record; logger=logger)
            parsed_record_results_tuple = check(parse_result; logger=logger)
            complete_results_tuple = merge(parsed_record_results_tuple, (original_record=record,)) 
            parsed_records_dictionary[key] = complete_results_tuple
        end

        # return -
        return VLResult(parsed_records_dictionary)

    catch error
        return VLResult(error)
    end
end

function grn_record_parse_parser(sentence::Array{MinervaToken,1})::VLResult
    return VLResult(nothing)
end

function minerva_species_bounds_record_parser(sentence::Array{MinervaToken,1}; 
    logger::Union{Nothing,SimpleLogger} = nothing)::VLResult

    try 
    
        # lets make a copy of the sentence, and reverse it -
        sentence_to_check = reverse(deepcopy(sentence))

        # ok - here we go -
        recursive_descent_result = _minerva_parse_species_bound_type_sentence(sentence_to_check)
        if (isnothing(recursive_descent_result.value) == true)
            
            # setup named tuple for results -
            results_tuple = (did_parse_ok=true,error=nothing)
            return VLResult(results_tuple)
        else

            # setup named tuple for results -
            results_tuple = (did_parse_ok=false,error=recursive_descent_result.value)
            return VLResult(results_tuple)
        end

    catch error
        return VLResult(error)
    end
end
# ------------------------------------------------------------------------------------------------------------- #