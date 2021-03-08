abstract type AbstractTokenType end
abstract type AbstractToken end

# Biological symbol is *any* biological symbol
abstract type BIOLOGICAL_SYMBOL <: AbstractTokenType end

# Keywords used in the various sentences -
abstract type LPAREN <: AbstractTokenType end
abstract type RPAREN <: AbstractTokenType end
abstract type TRANSCRIPTION <: AbstractTokenType end
abstract type TRANSLATION <: AbstractTokenType end
abstract type CATALYZE <: AbstractTokenType end
abstract type BIND <: AbstractTokenType end
abstract type AND <: AbstractTokenType end
abstract type OR <: AbstractTokenType end
abstract type SPACE <: AbstractTokenType end
abstract type ARE <: AbstractTokenType end
abstract type IS <: AbstractTokenType end
abstract type A <: AbstractTokenType end
abstract type TO <: AbstractTokenType end
abstract type IN <: AbstractTokenType end
abstract type MODEL <: AbstractTokenType end
abstract type THE <: AbstractTokenType end
abstract type GENE_SYMBOL <: AbstractTokenType end
abstract type mRNA_SYMBOL <: AbstractTokenType end
abstract type tRNA_SYMBOL <: AbstractTokenType end
abstract type regRNA_SYMBOL <: AbstractTokenType end
abstract type PROTEIN_SYMBOL <: AbstractTokenType end
abstract type METABOLITE_SYMBOL <: AbstractTokenType end
abstract type TYPE <: AbstractTokenType end
abstract type OF <: AbstractTokenType end
abstract type SEMICOLON <: AbstractTokenType end
abstract type INHIBIT <: AbstractTokenType end
abstract type REPRESS <: AbstractTokenType end
abstract type ACTIVATE <: AbstractTokenType end
abstract type PHOSPHORYLATE <: AbstractTokenType end
abstract type DEPHOSPHORYLATE <: AbstractTokenType end
abstract type COMPLEX <: AbstractTokenType end
abstract type FORM <: AbstractTokenType end
abstract type AT <: AbstractTokenType end

# Bounds types -
abstract type SOURCE <: AbstractTokenType end
abstract type SINK <: AbstractTokenType end
abstract type BOUND <: AbstractTokenType end
abstract type UNBOUND <: AbstractTokenType end

# type that we will build -
struct MinervaToken <: AbstractToken
  lexeme::String
  type::AbstractTokenType
end

struct MinervaSentence
    sentence::Array{MinervaToken,1}
end
