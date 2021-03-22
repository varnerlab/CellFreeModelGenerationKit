# where is the package installed?
const _PATH_TO_SRC = dirname(pathof(@__MODULE__))
const _PATH_TO_DATABASE = joinpath(_PATH_TO_SRC, "database")

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
using SQLite

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

# Minerva lite -
include("./minerva/Types.jl")
include("./minerva/Scanner.jl")
include("./minerva/Parser.jl")
include("./minerva/Database.jl")
include("./minerva/grammar/type_assignment_grammar.jl")
include("./minerva/grammar/species_bound_grammar.jl")