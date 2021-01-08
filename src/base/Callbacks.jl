# -- PRIVATE FUNCTIONS NOT EXPORTED -------------------------------------------------------------- #
function _reorder_logic_with_callback(symbol_array::Array{String,1}; callback::Union{Function,Nothing} = nothing)

    # if there is callback logic -> use it ...
    if (isnothing(callback) == false)
        return callback(symbol_array)
    end

    # otherwise - alphabetical 
    return sort(symbol_array)
end
# ------------------------------------------------------------------------------------------------ #

function reorder_molecular_symbol_array(symbol_array::Array{String,1}; callback::Union{Function,Nothing} = nothing)
    return _reorder_logic_with_callback(symbol_array; callback = callback)
end

function reorder_reaction_symbol_array(symbol_array::Array{String,1}; callback::Union{Function,Nothing} = nothing)
    return return _reorder_logic_with_callback(symbol_array; callback = callback)
end