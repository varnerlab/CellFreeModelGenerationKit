# where is the package installed?
const path_to_package = dirname(pathof(@__MODULE__))

# IR dictionary keys -
const ir_master_reaction_table_key = "_master_reaction_table_key"
const ir_list_of_molecular_species_key = "_list_of_molecular_species_key"
const ir_list_of_reaction_tags_key = "_list_of_reaction_tags_key"
const ir_master_species_bounds_table_key = "_master_species_bounds_table_key"
const ir_sequence_section_table_key = "_sequence_section_table_key"

# using statement for external packages -
using DataFrames
using CSV
using Dates
using Logging
using WordTokenizers
using DelimitedFiles

# include package codes -
include("./base/Types.jl")
include("./base/Extensions.jl")
include("./base/Factory.jl")
include("./base/Checks.jl")
include("./base/Files.jl")
include("./base/Parser.jl")
include("./base/Callbacks.jl")
include("./base/Sequence.jl")
include("./strategy/General.jl")

# language specific codes -
include("MakeJuliaModel.jl")