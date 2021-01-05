
function parse_vff_model_file(model::VLAbstractModelObject)::VLResult

    # initialize -
    problem_dictionary = Dict{String,Any}()

    # get the path to the vff model -
    vff_model_file_path = model.path_to_model_file

    # load the vff buffer -
    vff_file_buffer = read_file_from_path(vff_model_file_path)

    # -- SEQ SECTION --------------------------------------------------------------------------------- #
    # ------------------------------------------------------------------------------------------------ #

    # -- METABOLISM SECTION -------------------------------------------------------------------------- #
    # ------------------------------------------------------------------------------------------------ #

    # -- GRN SECTION --------------------------------------------------------------------------------- #
    # ------------------------------------------------------------------------------------------------ #

    # return -
    return VLResult(problem_dictionary)
end