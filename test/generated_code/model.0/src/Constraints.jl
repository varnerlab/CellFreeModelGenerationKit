# ----------------------------------------------------------------------------------- #
# Copyright (c) 2021 Varnerlab
# Robert Frederick School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #

"""
    update_is_minimum_flag(data_dictionary, vargs...)

    Updates where the problem is setup as either a min (is_minimum_flag = true) or max (is_minimum_flag = false)
"""
function update_is_minimum_flag(data_dictionary::Dict{String,Any}, vargs...)::Bool
    @warn("Ooops! You've called an autoegenerated dummy implementation that uses the default problem parameters and setup. Replace this implementation with your code to customize")

    # return the default -
    return true
end

"""
    update_species_bounds_array(data_dictionary, vargs...)

    Update the species bounds array with current state or measurements
"""
function update_species_bounds_array(data_dictionary::Dict{String,Any}, vargs...)::Array{Float64,2}
    @warn("Ooops! You've called an autoegenerated dummy implementation that uses the default problem parameters and setup. Replace this implementation with your code to customize")

    # return the default -
    return data_dictionary["species_bounds_array"]
end

"""
    update_flux_bounds_array(data_dictionary, vargs...)
"""
function update_flux_bounds_array(data_dictionary::Dict{String,Any}, vargs...)::Array{Float64,2}
    @warn("Ooops! You've called an autoegenerated dummy implementation that uses the default problem parameters and setup. Replace this implementation with your code to customize")

    # return the default -
    return data_dictionary["flux_bounds_array"]
end

"""
    update_objective_coefficient_array(data_dictionary, vargs...)
"""
function update_objective_coefficient_array(data_dictionary::Dict{String,Any}, vargs...)::Array{Float64,1}
    @warn("Ooops! You've called an autoegenerated dummy implementation that uses the default problem parameters and setup. Replace this implementation with your code to customize")

    # return the default -
    return data_dictionary["objective_coefficient_array"]
end

"""
    update_species_concentration_array(data_dictionary, vargs...)
"""
function update_species_concentration_array(data_dictionary::Dict{String,Any}, vargs...)::(Union{T, Nothing} where T<:Any)
    @warn("Ooops! You've called an autoegenerated dummy implementation that uses the default problem parameters and setup. Replace this implementation with your code to customize")

    # return the default -
    return data_dictionary["species_concentration_array"]
end
