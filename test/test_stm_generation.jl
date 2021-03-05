using CellFreeModelGenerationKit

# path to test metabolism file -
path_to_test_metabolism_file = "./test/data/Test-2.vff"

# need to build a model object -
build_result = build_julia_model_object(path_to_test_metabolism_file,"blank_for_now")
if (isa(build_result.value, Exception) == true)
    @show build_result.value
end
julia_model_object = build_result.value

# parse -
result = parse_vff_model_document(julia_model_object)
if (isa(result.value,Exception) == true)
    @show result.value
end
ir_dictionary = result.value

# now that we have the ir_dictionary - generate the stm
stm_gen_result = generate_stoichiometric_matrix(ir_dictionary)