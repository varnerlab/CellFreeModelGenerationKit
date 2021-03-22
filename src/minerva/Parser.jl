# -- PRIVATE METHODS ------------------------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------- #

# -- PUBLIC METHODS ------------------------------------------------------------------------------------------- #
function minerva_parser(records::Dict{Int64,Array{MinervaToken,1}}, parseFunction::Function;
    logger::Union{Nothing,SimpleLogger} = nothing)::VLResult

    # initialize -
    try
    

    catch error
        return VLResult(error)
    end
end

function grn_record_parse_parser(sentence::Array{MinervaToken,1})::VLResult
    return VLResult(nothing)
end

function species_bounds_record_parser(sentence::Array{MinervaToken,1})::VLResult

    try 
    
        # ok - here we go -


    catch error
        return VLResult(error)
    end
end
# ------------------------------------------------------------------------------------------------------------- #