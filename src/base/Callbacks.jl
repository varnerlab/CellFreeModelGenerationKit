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

Reorder species symbol names alphabetically (default implementation) unless a callback function is passed, in which case sorting is done based on the user-defined routine.

Input arguments:
`symbol_array::Array{String,1}` - array holding symbol names for all molecular species in the network.
`callback::Union{Function,Nothing}` - user-defined function to reorder species symbol names (optional).

Output arguments:
`symbol_array::Array{String,1}` - sorted molecular species symbol array.

"""
function reorder_molecular_symbol_array(symbol_array::Array{String,1}; callback::Union{Function,Nothing} = nothing)::Array{String,1}
    return _reorder_logic_with_callback(symbol_array; callback = callback)
end

"""
    reorder_reaction_symbol_array(symbol_array::Array{String,1};
          callback::Union{Function,Nothing} = nothing)::Array{String,1}

Reorder reaction symbol names alphabetically (default implementation) unless a callback function is passed, in which case sorting is done based on the user-defined routine.

Input arguments:
`symbol_array::Array{String,1}` - array holding symbol names for all reactions in the network.
`callback::Union{Function,Nothing}` - user-defined function to reorder reaction names (optional).

Output arguments:
`symbol_array::Array{String,1}` - sorted reaction symbol array.

"""
function reorder_reaction_symbol_array(symbol_array::Array{String,1}; callback::Union{Function,Nothing} = nothing)::Array{String,1}
    return return _reorder_logic_with_callback(symbol_array; callback = callback)
end
