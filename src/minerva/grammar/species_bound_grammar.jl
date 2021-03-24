function _minerva_parse_species_bound_type_sentence(sentence::Array{MinervaToken,1}; 
    logger::Union{Nothing, SimpleLogger} = nothing)::VLResult

    # flat sentence in case of error -
    flat_sentence_buffer = ""
    number_of_tokens = length(sentence)
    for (index,token) in enumerate(sentence)
        
        # lexeme -
        lexeme = token.lexeme
        flat_sentence_buffer *= "$(lexeme)"
        if (index<number_of_tokens)
            flat_sentence_buffer *=" " 
        end
    end

    # grab the a token -
    first_token = pop!(sentence)
    if (isa(first_token.type, BIOLOGICAL_SYMBOL) == true)
        return _start_bound_assignment_recursive_descent(sentence)
    else
        
        # formulate and throw error excpetion -
        error_message = "Error in sentence: $(flat_sentence_buffer). Expected biological symbol but found $(first_token.lexeme)"
        error_object = ErrorException(error_message)
        return VLResult(error_object)
    end
end

# --- PRIVATE RECURSIVE DESCENT METHODS BELOW ----------------------------------------------------------------------------------- #
function _start_bound_assignment_recursive_descent(sentence::Array{MinervaToken,1})::VLResult

    # flat sentence in case of error -
    flat_sentence_buffer = ""
    number_of_tokens = length(sentence)
    for (index,token) in enumerate(sentence)
        
        # lexeme -
        lexeme = token.lexeme
        flat_sentence_buffer *= "$(lexeme)"
        if (index<number_of_tokens)
            flat_sentence_buffer *=" " 
        end
    end

    # grab the a token -
    next_token = pop!(sentence)
    if (isa(next_token.type,IS) == true)
        return _is_token_species_bound(sentence)
    elseif (isa(next_token.type, BOUND) == true || isa(next_token.type, UNBOUND) == true || isa(next_token.type, SOURCE) == true || isa(next_token.type, SINK) == true)
        return _bound_type_token_species_bound(sentence)
    else
    
        # formulate and throw error excpetion -
        error_message = "Error in sentence: $(flat_sentence_buffer). Expected a species bound type or 'is' but found $(next_token.lexeme) instead"
        error_object = ErrorException(error_message)
        return VLResult(error_object)
    end
end

function _is_token_species_bound(sentence::Array{MinervaToken,1})::VLResult

    # flat sentence in case of error -
    flat_sentence_buffer = ""
    number_of_tokens = length(sentence)
    for (index,token) in enumerate(sentence)
        
        # lexeme -
        lexeme = token.lexeme
        flat_sentence_buffer *= "$(lexeme)"
        if (index<number_of_tokens)
            flat_sentence_buffer *=" " 
        end
    end
    
    # grab the next token -
    next_token = pop!(sentence)
    if (isa(next_token.type, A) == true)
        return _a_token_species_bound(sentence)
    elseif (isa(next_token.type, BOUND) == true || isa(next_token.type, UNBOUND) == true || 
        isa(next_token.type, SOURCE) == true || isa(next_token.type, SINK) == true)
        return _bound_type_token_species_bound(sentence)
    else
        # formulate and throw error excpetion -
        error_message = "Error in sentence: $(flat_sentence_buffer). Expected a species bound type or 'a' but found $(next_token.lexeme) instead"
        error_object = ErrorException(error_message)
        return VLResult(error_object)
    end
end

function _bound_type_token_species_bound(sentence::Array{MinervaToken,1})::VLResult

    # flat sentence in case of error -
    flat_sentence_buffer = ""
    number_of_tokens = length(sentence)
    for (index,token) in enumerate(sentence)
        
        # lexeme -
        lexeme = token.lexeme
        flat_sentence_buffer *= "$(lexeme)"
        if (index<number_of_tokens)
            flat_sentence_buffer *=" " 
        end
    end

    # grab the a token -
    next_token = pop!(sentence)
    if (isa(next_token.type, SEMICOLON) == true)
        return VLResult(nothing)
    else
        # formulate and throw error excpetion -
        error_message = "Error in sentence: $(flat_sentence_buffer). Expected a ';' but found '$(next_token.lexeme)'"
        error_object = ErrorException(error_message)
        return VLResult(error_object)
    end
end

function _a_token_species_bound(sentence::Array{MinervaToken,1})::VLResult

    # flat sentence in case of error -
    flat_sentence_buffer = ""
    number_of_tokens = length(sentence)
    for (index,token) in enumerate(sentence)
        
        # lexeme -
        lexeme = token.lexeme
        flat_sentence_buffer *= "$(lexeme)"
        if (index<number_of_tokens)
            flat_sentence_buffer *=" " 
        end
    end

    # grab the next token -
    next_token = pop!(sentence)
    if (isa(next_token.type, BOUND) == true || isa(next_token.type, UNBOUND) == true || 
        isa(next_token.type, SOURCE) == true || isa(next_token.type, SINK) == true)
        return _bound_type_token_species_bound(sentence)
    else
    
        # formulate and throw error excpetion -
        error_message = "Error in sentence: $(flat_sentence_buffer). Expected a bount type but found '$(next_token.lexeme)'"
        error_object = ErrorException(error_message)
        return VLResult(error_object)
    end
end
# --- PRIVATE RECURSIVE DESCENT METHODS ABOVE ----------------------------------------------------------------------------------- #