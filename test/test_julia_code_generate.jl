using CellFreeModelGenerationKit

# path to test metabolism file -
path_to_test_metabolism_file = "./test/data/Metabolism.vff"
path_to_output_dir = "./test/model_generated/model/"

# need to build a model object -
build_result = build_julia_model_object(path_to_test_metabolism_file, path_to_output_dir)
if (isa(build_result.value, Exception) == true)
    @show build_result.value
end
julia_model_object = build_result.value

# generate code -
generate(julia_model_object)

