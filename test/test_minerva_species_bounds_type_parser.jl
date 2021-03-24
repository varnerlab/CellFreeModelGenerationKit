using CellFreeModelGenerationKit

# path to test metabolism file -
path_to_test_metabolism_file = "./test/data/Test.vff"

# load the file -
file_buffer = read_model_document(path_to_test_metabolism_file)

# parse the metabolism section of the file_buffer -
result = parse_vff_species_bounds_section(file_buffer)
original_record_buffer_dictionary = check(result)

# now, lets scan this mofo -
parser_result = minerva_parser(original_record_buffer_dictionary, minerva_species_bounds_record_parser)
did_parse_struct = check(parser_result)