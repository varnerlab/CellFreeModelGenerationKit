abstract type AbstractTokenType end
abstract type AbstractToken end

# Biological symbol is *any* biological symbol
struct BIOLOGICAL_SYMBOL <: AbstractTokenType end

# Biological type prefix is *any* type prefix
struct BIOLOGICAL_TYPE_PREFIX <: AbstractTokenType end

# Keywords used in the various sentences -
struct LPAREN <: AbstractTokenType end
struct RPAREN <: AbstractTokenType end
struct TRANSCRIPTION <: AbstractTokenType end
struct TRANSLATION <: AbstractTokenType end
struct CATALYZE <: AbstractTokenType end
struct BIND <: AbstractTokenType end
struct AND <: AbstractTokenType end
struct OR <: AbstractTokenType end
struct SPACE <: AbstractTokenType end
struct ARE <: AbstractTokenType end
struct IS <: AbstractTokenType end
struct A <: AbstractTokenType end
struct TO <: AbstractTokenType end
struct IN <: AbstractTokenType end
struct MODEL <: AbstractTokenType end
struct THE <: AbstractTokenType end
struct GENE_TYPE_SYMBOL <: AbstractTokenType end
struct mRNA_TYPE_SYMBOL <: AbstractTokenType end
struct tRNA_TYPE_SYMBOL <: AbstractTokenType end
struct regRNA_TYPE_SYMBOL <: AbstractTokenType end
struct PROTEIN_TYPE_SYMBOL <: AbstractTokenType end
struct METABOLITE_TYPE_SYMBOL <: AbstractTokenType end
struct RNA_POLYMERASE_II_SYMBOL <: AbstractTokenType end
struct RIBOSOME_SYMBOL <: AbstractTokenType end
struct TYPE <: AbstractTokenType end
struct OF <: AbstractTokenType end
struct PHOSPHORYLATE <: AbstractTokenType end
struct DEPHOSPHORYLATE <: AbstractTokenType end
struct COMPLEX <: AbstractTokenType end
struct FORM <: AbstractTokenType end
struct AT <: AbstractTokenType end
struct PROMOTER <: AbstractTokenType end
struct GENE <: AbstractTokenType end
struct POSITIVE <: AbstractTokenType end
struct NEGATIVE <: AbstractTokenType end
struct UNKNOWN <: AbstractTokenType end

# Bounds types -
struct SOURCE <: AbstractTokenType end
struct SINK <: AbstractTokenType end
struct BOUND <: AbstractTokenType end
struct UNBOUND <: AbstractTokenType end

# endpoint -
struct SEMICOLON <: AbstractTokenType end

# type that we will build -
struct MinervaToken <: AbstractToken
  lexeme::String
  type::AbstractTokenType
end

struct MinervaSentence
    sentence::Array{MinervaToken,1}
end
