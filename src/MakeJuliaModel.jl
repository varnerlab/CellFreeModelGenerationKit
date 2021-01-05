function generate(model::VLJuliaModelObject)

    try

        # parse the vff file -
        parse_result = parse_vff_model_file(model)
        if (isa(parse_result.value,Exception) == true)
            throw(parse_result.value)
        end
        problem_dictionary = parse_result.value



    catch error
        # what do we do here?
    end
end