module CellFreeModelGenerationKit

# include -
include("Include.jl")

# export types -
export VLJuliaModelObject

# parser methods -
export parse_vff_model_document
export parse_vff_metabolic_section
export read_model_document

# export methods -
export build_julia_model_object
export generate

# IR dictionary keys -
const ir_master_reaction_table_key = "_master_reaction_table_key"

end # module
