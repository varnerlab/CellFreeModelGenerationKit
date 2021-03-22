function _parser_species_bound_type_sentence(sentence::Array{MinervaToken,1})::VLResult

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
    if (isa(next_token.type,BIOLOGICAL_SYMBOL) == true)

        # ok, so if we have a biological symbol, then let's go to the next level -
        peek_one_token_ahead = first(sentence)
        if (isa(peek_one_token_ahead.type, IS) == true)
            return _is_token_species_bound(sentence)
        else
            return _type_token_species_bound(sentence)
        end
    else
        
        # formulate and throw error excpetion -
        error_message = "Error in sentence: $(flat_sentence_buffer). Expected biological symbol but found $(next_token.lexeme)"
        throw(ErrorException(error_message))
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
    
    # grab the a token -
    next_token = pop!(sentence)

end

function _type_token_species_bound(sentence::Array{MinervaToken,1})::VLResult

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

    # grab the a token -
    next_token = pop!(sentence)
end