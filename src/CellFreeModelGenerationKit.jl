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

# advanced: API call back methods -
export reorder_reaction_symbol_array
export reorder_molecular_symbol_array

# export keys -
export ir_master_reaction_table_key
export ir_list_of_molecular_species_key
export ir_list_of_reaction_tags_key
export path_to_package

end # module
