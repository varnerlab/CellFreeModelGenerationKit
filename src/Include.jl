# using statement for external packages -
using DataFrames
using CSV

# include package codes -
include("./base/Types.jl")
include("./base/Factory.jl")
include("./base/Checks.jl")
include("./base/Extensions.jl")
include("./base/Files.jl")
include("./base/Parser.jl")

# language specific codes -
include("MakeJuliaModel.jl")

# IR dictionary keys -
const ir_master_reaction_table_key = "_master_reaction_table_key"
const ir_list_of_molecular_species_key = "_list_of_molecular_species_key"