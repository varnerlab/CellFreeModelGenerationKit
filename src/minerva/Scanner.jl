function scanner(records::Dict{Int64,Any}, scanFunction::Function; logger::Union{Nothing,SimpleLogger} = nothing)::VLResult
    
    # initialize -
    scanned_records_dictionary = Dict{Int64,Array{MinervaToken,1}}()

    try

        # connect to the database -
        path_to_database_file = joinpath(_PATH_TO_DATABASE,"Database.db")
        CFGM_DB_CONNECTION = SQLite.DB(path_to_database_file) 

        # load the synonym table -
        data_op_result = load_synonym_table(CFGM_DB_CONNECTION; logger=logger)
        synonym_dictionary = check(data_op_result; logger=logger)

        # so for each record in my records array, lets scan -
        for (key, record) in records
            scan_result = scanFunction(record, synonym_dictionary; logger=logger)
            scanned_record = check(scan_result; logger=logger)
            scanned_records_dictionary[key] = scanned_record
        end

        # return -
        return VLResult(scanned_records_dictionary)
    catch error
        return VLResult(error)
    end

end

function bound_type_assignment_scan_function(record::Array{String,1}, synonym_dictionary::Union{Nothing,Dict{String,String}} = nothing; 
    logger::Union{Nothing,SimpleLogger})::VLResult

    # initialize -
    canonical_record_array = Array{String,1}()
    canonical_token_array = Array{MinervaToken,1}()
    token_type_dictionary = Dict{String,MinervaToken}()

    # hardcode the token type dictionary -
    token_type_dictionary[string(hash("("))] = MinervaToken("(",LPAREN())
    token_type_dictionary[string(hash(")"))] = MinervaToken(")",RPAREN())
    token_type_dictionary[string(hash("SOURCE"))] = MinervaToken("source",SOURCE())
    token_type_dictionary[string(hash("SINK"))] = MinervaToken("sink",SINK())
    token_type_dictionary[string(hash("BOUND"))] = MinervaToken("bound",BOUND())
    token_type_dictionary[string(hash("UNBOUND"))] = MinervaToken("unbound",UNBOUND())
    token_type_dictionary[string(hash("is"))] = MinervaToken("is",IS())
    token_type_dictionary[string(hash("a"))] = MinervaToken("a",A())
    token_type_dictionary[string(hash("type"))] = MinervaToken("TYPE",TYPE())

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
        # first, lets string match -
        reverse_canonical_record_array_copy = reverse(copy(canonical_record_array))
        while (isempty(reverse_canonical_record_array_copy) == false)
            
            # item -
            item_to_classify = pop!(reverse_canonical_record_array_copy)

            # check: do we have this item in the token dictionary -
            test_key = string(hash(item_to_classify))
            if (haskey(token_type_dictionary, test_key) == true)
                token_item = token_type_dictionary[test_key]
                push!(canonical_token_array, token_item)
            else
                minerva_token = MinervaToken(item_to_classify, UNKNOWN())
                push!(canonical_token_array,minerva_token)
            end
        end 
        
        # return -
        return VLResult(canonical_token_array)

    catch error
        return VLResult(error)
    end
end

function biological_type_assignment_scan_function(record::Array{String,1}, synonym_dictionary::Union{Nothing,Dict{String,String}} = nothing; 
    logger::Union{Nothing,SimpleLogger})::VLResult

    # initialize -
    canonical_record_array = Array{String,1}()
    canonical_token_array = Array{MinervaToken,1}()
    token_type_dictionary = Dict{String,MinervaToken}()

    # hardcode the token type dictionary -
    token_type_dictionary[string(hash("("))] = MinervaToken("(",LPAREN())
    token_type_dictionary[string(hash(")"))] = MinervaToken(")",RPAREN())
    token_type_dictionary[string(hash("SOURCE"))] = MinervaToken("source",SOURCE())
    token_type_dictionary[string(hash("SINK"))] = MinervaToken("sink",SINK())
    token_type_dictionary[string(hash("BOUND"))] = MinervaToken("bound",BOUND())
    token_type_dictionary[string(hash("UNBOUND"))] = MinervaToken("unbound",UNBOUND())
    token_type_dictionary[string(hash("is"))] = MinervaToken("is",IS())
    token_type_dictionary[string(hash("a"))] = MinervaToken("a",A())
    token_type_dictionary[string(hash("type"))] = MinervaToken("TYPE",TYPE())
    token_type_dictionary[string(hash("GENE"))] = MinervaToken("GENE",GENE_TYPE_SYMBOL())
    token_type_dictionary[string(hash("MESSENGER-RNA"))] = MinervaToken("MESSENGER-RNA",mRNA_TYPE_SYMBOL())
    token_type_dictionary[string(hash("TRANSFER-RNA"))] = MinervaToken("TRANSFER-RNA",tRNA_TYPE_SYMBOL())
    token_type_dictionary[string(hash("REGULATORY-RNA"))] = MinervaToken("REGULATORY-RNA",regRNA_TYPE_SYMBOL())
    token_type_dictionary[string(hash("PROTEIN"))] = MinervaToken("PROTEIN",PROTEIN_TYPE_SYMBOL())
    token_type_dictionary[string(hash("METABOLITE"))] = MinervaToken("METABOLITE",METABOLITE_TYPE_SYMBOL())

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
        # first, lets string match -
        reverse_canonical_record_array_copy = reverse(copy(canonical_record_array))
        while (isempty(reverse_canonical_record_array_copy) == false)
            
            # item -
            item_to_classify = pop!(reverse_canonical_record_array_copy)

            # check: do we have this item in the token dictionary -
            test_key = string(hash(item_to_classify))
            if (haskey(token_type_dictionary, test_key) == true)
                token_item = token_type_dictionary[test_key]
                push!(canonical_token_array, token_item)
            else
                minerva_token = MinervaToken(item_to_classify, BIOLOGICAL_TYPE_PREFIX())
                push!(canonical_token_array,minerva_token)
            end
        end 
        
        # return -
        return VLResult(canonical_token_array)
    catch error
        return VLResult(error)
    end

end

function grn_scan_function(record::Array{String,1}, synonym_dictionary::Union{Nothing,Dict{String,String}} = nothing; 
    logger::Union{Nothing,SimpleLogger})::VLResult

    # initialize -
    canonical_record_array = Array{String,1}()
    canonical_token_array = Array{MinervaToken,1}()
    token_type_dictionary = Dict{String,MinervaToken}()

    # stuff -
    token_type_dictionary[string(hash("("))] = MinervaToken("(",LPAREN())
    token_type_dictionary[string(hash(")"))] = MinervaToken(")",RPAREN())
    token_type_dictionary[string(hash("transcription"))] = MinervaToken("transcription",TRANSCRIPTION())
    token_type_dictionary[string(hash("translation"))] = MinervaToken("translation",TRANSLATION())
    token_type_dictionary[string(hash("inhibit"))] = MinervaToken("inhibit",INHIBIT())
    token_type_dictionary[string(hash("catalyze"))] = MinervaToken("catalyze",CATALYZE())
    token_type_dictionary[string(hash("bind"))] = MinervaToken("bind",BIND())
    token_type_dictionary[string(hash("repress"))] = MinervaToken("repress",REPRESS())
    token_type_dictionary[string(hash("inhibit"))] = MinervaToken("inhibit",INHIBIT())
    token_type_dictionary[string(hash("activate"))] = MinervaToken("activate",ACTIVATE())
    token_type_dictionary[string(hash("phosphorylate"))] = MinervaToken("phosphorylate",PHOSPHORYLATE())
    token_type_dictionary[string(hash("dephosphorylate"))] = MinervaToken("dephosphorylate",DEPHOSPHORYLATE())
    token_type_dictionary[string(hash("induce"))] = MinervaToken("induce",INDUCE())
    token_type_dictionary[string(hash("complex"))] = MinervaToken("complex",COMPLEX())
    token_type_dictionary[string(hash("form"))] = MinervaToken("form",FORM())
    token_type_dictionary[string(hash("and"))] = MinervaToken("and",AND())
    token_type_dictionary[string(hash(","))] = MinervaToken(",",AND())
    token_type_dictionary[string(hash("|"))] = MinervaToken("|",OR())
    token_type_dictionary[string(hash("or"))] = MinervaToken("or",OR())
    token_type_dictionary[string(hash(" "))] = MinervaToken(" ",SPACE())
    token_type_dictionary[string(hash("to"))] = MinervaToken("to",TO())
    token_type_dictionary[string(hash("->"))] = MinervaToken("to",TO())
    token_type_dictionary[string(hash("are"))] = MinervaToken("are",ARE())
    token_type_dictionary[string(hash("="))] = MinervaToken("=",ARE())
    token_type_dictionary[string(hash("is"))] = MinervaToken("is",IS())
    token_type_dictionary[string(hash("a"))] = MinervaToken("a",A())
    token_type_dictionary[string(hash("type"))] = MinervaToken("TYPE",TYPE())
    token_type_dictionary[string(hash("of"))] = MinervaToken("of",OF())
    token_type_dictionary[string(hash("the"))] = MinervaToken("the",THE())
    token_type_dictionary[string(hash("at"))] = MinervaToken("at",AT())
    token_type_dictionary[string(hash("in"))] = MinervaToken("in",IN())    
    

    # token_type_dictionary[string(hash("GENE_TYPE_SYMBOL"))] = MinervaToken("GENE_SYMBOL",GENE_SYMBOL())
    # token_type_dictionary[string(hash("mRNA_TYPE_SYMBOL"))] = MinervaToken("mRNA_SYMBOL",mRNA_SYMBOL())
    # token_type_dictionary[string(hash("tRNA_TYPE_SYMBOL"))] = MinervaToken("tRNA_SYMBOL",tRNA_SYMBOL())
    # token_type_dictionary[string(hash("regRNA_TYPE_SYMBOL"))] = MinervaToken("regRNA_SYMBOL",regRNA_SYMBOL())
    # token_type_dictionary[string(hash("PROTEIN_TYPE_SYMBOL"))] = MinervaToken("PROTEIN_SYMBOL",PROTEIN_SYMBOL())
    # token_type_dictionary[string(hash("METABOLITE_TYPE_SYMBOL"))] = MinervaToken("METABOLITE_SYMBOL",METABOLITE_SYMBOL()) 
    
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
        # first, lets string match -
        reverse_canonical_record_array_copy = reverse(copy(canonical_record_array))
        while (isempty(reverse_canonical_record_array_copy) == false)
            
            # item -
            item_to_classify = pop!(reverse_canonical_record_array_copy)

            # check: do we have this item in the token dictionary -
            test_key = string(hash(item_to_classify))
            if (haskey(token_type_dictionary, test_key) == true)
                token_item = token_type_dictionary[test_key]
                push!(canonical_token_array, token_item)
            else
                minerva_token = MinervaToken(item_to_classify, BIOLOGICAL_SYMBOL())
                push!(canonical_token_array,minerva_token)
            end
        end

        # return -
        return VLResult(canonical_token_array)
    catch error
        return VLResult(error)
    end
end