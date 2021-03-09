function scan(records::Dict{Int64,Any}; logger::Union{Nothing,SimpleLogger} = nothing)::VLResult

    # initialize -
    scanned_records_dictionary = Dict{Int64,Any}()

    try

        # connect to the database -
        path_to_database_file = joinpath(_PATH_TO_DATABASE,"Database.db")
        CFGM_DB_CONNECTION = SQLite.DB(path_to_database_file) 

        # load the synonym table -
        data_op_result = load_synonym_table(CFGM_DB_CONNECTION; logger=logger)
        synonym_dictionary = check(data_op_result; logger=logger)

        # so for each record in my records array, lets scan -
        for (key, record) in records
            scan_result = scan(record, synonym_dictionary; logger=logger)
            scanned_record = check(scan_result; logger=logger)
            scanned_records_dictionary[key] = scanned_record
        end

        # return -
        return VLResult(scanned_records_dictionary)
    catch error
        return VLResult(error)
    end
end

function scan(record::Array{String,1}, synonym_dictionary::Union{Nothing,Dict{String,String}} = nothing; 
    logger::Union{Nothing,SimpleLogger})::VLResult

    # initialize -
    canonical_record_array = Array{String,1}()
    
    try

        # First = remove all synonyms and reduce the sentence to canonical form -
        tmp_record_array = reverse(copy(record))
        while (isempty(tmp_record_array) == false)
            
            # check: pop the component, check against the syn data table -
            record_component = pop!(tmp_record_array)

            # do we have this component as a key?
            if (haskey(synonym_dictionary,record_component) == true)
                # we have a synonym -
                new_record_component = synonym_dictionary[record_component]
                push!(canonical_record_array, new_record_component)
            else
                push!(canonical_record_array,record_component)
            end
        end

        # ok, so now we have a canonical forms - lets tokenize the cononical elements -
        

        # return -
        return VLResult(canonical_record_array)
    catch error
        return VLResult(error)
    end
end