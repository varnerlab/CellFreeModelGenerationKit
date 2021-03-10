# -- PRIVATE METHODS ------------------------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------- #

# -- PUBLIC METHODS ------------------------------------------------------------------------------------------- #
function grn_parse(records::Dict{Int64,Array{MinervaToken,1}}; 
    logger::Union{Nothing,SimpleLogger} = nothing)::VLResult

    # initialize -
    try
    

    catch error
        return VLResult(error)
    end
end

function grn_parse(record::Array{MinervaToken,1})::VLResult
end
# ------------------------------------------------------------------------------------------------------------- #