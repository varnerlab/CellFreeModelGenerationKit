var documenterSearchIndex = {"docs":
[{"location":"#CellFreeModelGenerationKit.jl-Documentation","page":"Home","title":"CellFreeModelGenerationKit.jl Documentation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"#Index","page":"Home","title":"Index","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [CellFreeModelGenerationKit]","category":"page"},{"location":"#CellFreeModelGenerationKit.build_control_program_component-Tuple{Dict{String,Any}}","page":"Home","title":"CellFreeModelGenerationKit.build_control_program_component","text":"build_control_program_component(intermediate_dictionary::Dict{String,Any})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.build_data_dictionary_program_component-Tuple{Dict{String,Any}}","page":"Home","title":"CellFreeModelGenerationKit.build_data_dictionary_program_component","text":"build_data_dictionary_program_component(intermediate_dictionary::Dict{String,Any})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.build_julia_model_object-Tuple{String,String}","page":"Home","title":"CellFreeModelGenerationKit.build_julia_model_object","text":"build_julia_model_object(path_to_model_file::String, path_to_output_dir::String; \n    defaults_file_name::String=\"Defaults.toml\", model_type::Symbol=:static)::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.build_kinetics_program_component-Tuple{Dict{String,Any}}","page":"Home","title":"CellFreeModelGenerationKit.build_kinetics_program_component","text":"build_kinetics_program_component(intermediate_dictionary::Dict{String,Any})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.generate-Tuple{VLJuliaModelObject}","page":"Home","title":"CellFreeModelGenerationKit.generate","text":"generate(julia_model_object::VLJuliaModelObject; \n    intermediate_representation_dictionary::Union{Nothing,Dict{String,Any}} = nothing, \n    logger::Union{Nothing,SimpleLogger} = nothing)\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.generate_default_project_file-Tuple{String}","page":"Home","title":"CellFreeModelGenerationKit.generate_default_project_file","text":"generate_default_project(path_to_project_dir::String)\n\nGenerates a default project structure which contains an empty model file and Defaults.toml file.\n\nInputs:\npath_to_project_dir = path to where you want model code to be generated\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.generate_stoichiometric_matrix-Tuple{Dict{String,Any}}","page":"Home","title":"CellFreeModelGenerationKit.generate_stoichiometric_matrix","text":"generate_stoichiometric_matrix(intermediate_dictionary::Dict{String,Any})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.parse_vff_bio_types_section-Tuple{Array{String,1}}","page":"Home","title":"CellFreeModelGenerationKit.parse_vff_bio_types_section","text":"parse_vff_bio_types_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.parse_vff_grn_section-Tuple{Array{String,1}}","page":"Home","title":"CellFreeModelGenerationKit.parse_vff_grn_section","text":"parse_grn_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.parse_vff_metabolic_section-Tuple{Array{String,1}}","page":"Home","title":"CellFreeModelGenerationKit.parse_vff_metabolic_section","text":"parse_vff_metabolic_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.parse_vff_model_document-Tuple{CellFreeModelGenerationKit.VLAbstractModelObject}","page":"Home","title":"CellFreeModelGenerationKit.parse_vff_model_document","text":"parse_vff_model_document(model::VLAbstractModelObject)::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.parse_vff_sequence_section-Tuple{Array{String,1}}","page":"Home","title":"CellFreeModelGenerationKit.parse_vff_sequence_section","text":"parse_vff_sequence_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.parse_vff_species_bounds_section-Tuple{Array{String,1}}","page":"Home","title":"CellFreeModelGenerationKit.parse_vff_species_bounds_section","text":"parse_vff_species_bounds_section(buffer::Array{String,1}, metabolic_results_tuple::NamedTuple)::VLResult\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.read_model_document-Tuple{String}","page":"Home","title":"CellFreeModelGenerationKit.read_model_document","text":"read_model_document(path_to_file::String; \n    strip_comments::Bool = true)::Array{String,1}\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.reorder_molecular_symbol_array-Tuple{Array{String,1}}","page":"Home","title":"CellFreeModelGenerationKit.reorder_molecular_symbol_array","text":"reorder_molecular_symbol_array(symbol_array::Array{String,1}; \n    callback::Union{Function,Nothing} = nothing)::Array{String,1}\n\n\n\n\n\n","category":"method"},{"location":"#CellFreeModelGenerationKit.reorder_reaction_symbol_array-Tuple{Array{String,1}}","page":"Home","title":"CellFreeModelGenerationKit.reorder_reaction_symbol_array","text":"reorder_reaction_symbol_array(symbol_array::Array{String,1}; \n    callback::Union{Function,Nothing} = nothing)::Array{String,1}\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_sequence_section","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_sequence_section","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_sequence_section","text":"parse_vff_sequence_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"function"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_metabolic_section","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_metabolic_section","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_metabolic_section","text":"parse_vff_metabolic_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"function"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_species_bounds_section","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_species_bounds_section","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_species_bounds_section","text":"parse_vff_species_bounds_section(buffer::Array{String,1}, metabolic_results_tuple::NamedTuple)::VLResult\n\n\n\n\n\n","category":"function"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_model_document","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_model_document","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_model_document","text":"parse_vff_model_document(model::VLAbstractModelObject)::VLResult\n\n\n\n\n\n","category":"function"}]
}