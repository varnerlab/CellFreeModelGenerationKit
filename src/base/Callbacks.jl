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

"""
    reorder_molecular_symbol_array(symbol_array::Array{String,1}; 
        callback::Union{Function,Nothing} = nothing)::Array{String,1}
"""
function reorder_molecular_symbol_array(symbol_array::Array{String,1}; callback::Union{Function,Nothing} = nothing)::Array{String,1}
    return _reorder_logic_with_callback(symbol_array; callback = callback)
end

"""
    reorder_reaction_symbol_array(symbol_array::Array{String,1}; 
        callback::Union{Function,Nothing} = nothing)::Array{String,1}
"""
function reorder_reaction_symbol_array(symbol_array::Array{String,1}; callback::Union{Function,Nothing} = nothing)::Array{String,1}
    return return _reorder_logic_with_callback(symbol_array; callback = callback)
end