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

function grn_parse_function(record::Array{MinervaToken,1})::VLResult
end
# ------------------------------------------------------------------------------------------------------------- #