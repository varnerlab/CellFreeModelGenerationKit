function load_synonym_table(db::SQLite.DB; logger::Union{Nothing,SimpleLogger} = nothing)::VLResult

    # initialize -
    synonym_dictionary = Dict{String,String}()

    try 

        # load the synonym table -
        sql_string = "SELECT * FROM LEXEME_SYNONYM_TABLE;"

        # execute the call -
        query_result = DBInterface.execute(db, sql_string)

        # turn the result into a table (and return for now so we can see what gets returned)
        df = DataFrame(query_result)

        # populate the synonym table -
        number_of_rows = size(df,1)
        for row_index = 1:number_of_rows
            key = df[row_index,:general_lexeme]
            value = df[row_index,:canonical_lexeme]
            synonym_dictionary[key] = value
        end

        # return -
        return VLResult(synonym_dictionary)
    catch error
        return VLResult(error)
    end
end