# CellFreeModelGenerationKit.jl

A package for building cell-free model code in Julia.

```@contents
```
```@index
```

## General methods
```@docs
generate
```
```@docs
generate_default_project_file
```
```@docs
generate_stoichiometric_matrix
```
```@docs
build_julia_model_object
```
```@docs
read_model_document
```

## Code strategy methods
```@docs
build_data_dictionary_program_component
```
```@docs
build_control_program_component
```
```@docs
build_kinetics_program_component
```

## Parser methods
```@docs
parse_vff_model_document
```
```@docs
parse_vff_metabolic_section
```
```@docs
parse_vff_sequence_section
```
```@docs
parse_vff_bio_types_section
```
```@docs
parse_vff_species_bounds_section
```
```@docs
parse_vff_grn_section
```

## Other Methods
```@docs
reorder_molecular_symbol_array
```
```@docs
reorder_reaction_symbol_array
```



