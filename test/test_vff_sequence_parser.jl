using CellFreeModelGenerationKit

# path to test metabolism file -
path_to_test_metabolism_file = "./test/data/Metabolism.vff"

# load the file -
file_buffer = read_model_document(path_to_test_metabolism_file)

# parse the metabolism section of the file_buffer -
result = parse_vff_sequence_section(file_buffer)
if (isa(result.value,Exception) == true)
    throw(result.value)
end
df = result.value