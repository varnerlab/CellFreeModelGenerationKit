using CellFreeModelGenerationKit

# path to test metabolism file -
path_to_test_metabolism_file = "./test/data/Test.vff"

# load the file -
file_buffer = read_model_document(path_to_test_metabolism_file)

# parse the metabolism section of the file_buffer -
result = parse_vff_grn_section(file_buffer)
original_record_buffer_dictionary = check(result)

# now, lets scan this mofo -
scan_result = minerva_scanner(original_record_buffer_dictionary, grn_scan_function)
cannonical_reduced_array = check(scan_result)