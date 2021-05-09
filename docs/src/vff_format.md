## VFF File Structure

`CellFreeModelGenerationKit.jl` transforms a structured text file into cell free model code. `CellFreeModelGenerationKit.jl` text files consist of delimited record types organized into five sections BIO-TYPE-PREFIXES, TXTL-SEQUENCE, METABOLISM, SPECIES-BOUNDS and GRN. Lines beginning with `//` are comments which are excluded by default. This can be modified by passing `strip_comments = false` to the `read_model_document` method.

### BIO-TYPE-PREFIXES section

Bio-type prefixes records are used to identify and declare the types of species.

#### Example
```
#BIO-TYPE-PREFIXES::START

// Declare type prefixes -
g is a GENE type
p is a PROTEIN type
mRNA is a MESSENGER-RNA type
tRNA is a TRANSFER-RNA type
regRNA is a REGULATORY-RNA type
M is a METABOLITE type

#BIO-TYPE-PREFIXES::STOP
```

### TXTL-SEQUENCE section

TXTL-SEQUENCE records

TXTL-SEQUENCE records are used to generate sequence specific transcription and translation reactions which are appended to the end of the metabolic reactions encoded in the METABOLISM section. TXTL-SEQUENCE records take the form:

{gene_symbol|protein_symbol}, sequence;
where:

{gene_symbol|protein_symbol}: species symbol used in the model. The species symbol is a user specified identifier that is used in the model. No spaces or special chars, _ are acceptable, but +,- etc are not acceptable.
sequence: nucleotide (X record) or protein (L) sequence in plain format.

TXTL-SEQUENCE records are terminated by a ; character.

#### Example
```
#TXTL-SEQUENCE::START

// -- deGFP-ssrA gene and protein -------------------------------------------- //
g_deGFP-ssrA,atggagcttttcactggcgttgttcccatcctggtcgagctggacggcgacgtaaacggccacaagttcagcgtgtccggc
gagggcgagggcgatgccacctacggcaagctgaccctgaagttcatctgcaccaccggcaagctgcccgtgccctggccc
accctcgtgaccaccctgacctacggcgtgcagtgcttcagccgctaccccgaccacatgaagcagcacgacttcttcaag
tccgccatgcccgaaggctacgtccaggagcgcaccatcttcttcaaggacgacggcaactacaagacccgcgccgaggtg
aagttcgagggcgacaccctggtgaaccgcatcgagctgaagggcatcgacttcaaggaggacggcaacatcctggggcac
aagctggagtacaactacaacagccacaacgtctatatcatggccgacaagcagaagaacggcatcaaggtgaacttcaag
atccgccacaacatcgaggacggcagcgtgcagctcgccgaccactaccagcagaacacccccatcggcgacggccccgtg
ctgctgcccgacaaccactacctgagcacccagtccgccctgagcaaagaccccaacgagaagcgcgatcacatggtcctg
ctggagttcgtgaccgccgccgggatcgcagcaaacgacgaaaactacgctttagctgcttaa;

p_deGFP-ssrA,MELFTGVVPILVELDGDVNG
HKFSVSGEGEGDATYGKLTL
KFICTTGKLPVPWPTLVTTL
TYGVQCFSRYPDHMKQHDFF
KSAMPEGYVQERTIFFKDDG
NYKTRAEVKFEGDTLVNRIE
LKGIDFKEDGNILGHKLEYN
YNSHNVYIMADKQKNGIKVN
FKIRHNIEDGSVQLADHYQQ
NTPIGDGPVLLPDNHYLSTQ
SALSKDPNEKRDHMVLLEFV
TAAGIAANDENYALAA;

#TXTL-SEQUENCE::STOP
```

### METABOLISM section

METABOLISM records are used to encode metabolic reactions. METABOLISM records consist of five fields.

reaction_name, [{; delimited set of ec numbers | []}], reactant_string, product_string, reversible tag;
where:

reaction_name is a unique identifier for the reaction.
reactant_string includes all the reactants participating the reaction.
product_string includes all products of the reaction. 
reversible tag is true if the reactions is reversible, otherwise it is false.

#### Example
```
#METABOLISM::START

// ======================================================================
// GLYCOLYSIS/ GLUCONEOGENESIS
// ======================================================================
// Glycogen phosphorylate (gP) 2.4.1.1
R_gp_1,[2.4.1.1],M_maltodextrin6_c+M_pi_c,M_maltodextrin5_c+M_g1p_c,false
R_gp_2,[2.4.1.1],M_maltodextrin5_c+M_pi_c,M_maltodextrin4_c+M_g1p_c,false
R_gp_3,[2.4.1.1],M_maltodextrin4_c+M_pi_c,M_maltodextrin3_c+M_g1p_c,false
R_gp_4,[2.4.1.1],M_maltodextrin3_c+M_pi_c,M_maltose_c+M_g1p_c,false
R_gp,[2.4.1.1],M_maltose_c+M_pi_c,M_glc_D_c+M_g1p_c,false

// Phosphoglucomutase (pgm) 5.4.2.2
R_pgm,[5.4.2.2],M_g1p_c,M_g6p_c,false

// Glucokinase (glk) EC 2.7.1.2
R_glk_atp,[2.7.1.2],M_atp_c+M_glc_D_c,M_adp_c+M_g6p_c,false

// Phosphoglucose isomerase (pgi) 5.3.1.9
R_pgi,[5.3.1.9],M_g6p_c,M_f6p_c,true

#METABOLISM::STOP
```

#### SPECIES_BOUNDS section

#### Example

```
#SPECIES_BOUNDS::START

M_o2_e is a SOURCE
M_co2_e is a SINK
M_h_e is UNBOUNDED

#SPECIES_BOUNDS::STOP
```

#### GRN section

GRN records are used to define the biology of the model being generated. In this section, define various types of species (promoters, genes and polymerases) involved in the regulatory circuit and their regulatory action.

#### Example

```
#GRN::START

// What are my promoters, genes and polymerases in the circuit?
P70 is a promoter
P28 is a promoter
g_deGFP-ssrA is a gene
g_cI-ssrA is a gene
g_s28 is a gene
RNAP is a RNA_POLYMERASE_II_SYMBOL
RIBOSOME is a RIBOSOME_SYMBOL

// formation of s70_RNAP and s28_RNAP -
p_s70 binds to RNAP and forms s70_RNAP
p_s28 binds to RNAP and forms s28_RNAP

// P70 promoter TX/TL activity -
s70_RNAP binds to P70 and activates g_deGFP-ssrA expression to form mRNA_deGFP-ssrA
mRNA_deGFP-ssrA is translated by RIBOSOME to form p_deGFP_ssrA
s70_RNAP binds to P70 and activates g_s28 expression to form mRNA_s28
mRNA_s28 is translated by RIBOSOME to form p_s28

// P28 promoter activity -
s28_RNAP binds to P28 and activates g_cI-ssrA expression to form mRNA_cI-ssrA

// p_cI-ssrA action -
p_cI-ssrA binds to P70 and inhibits g_s28 expression
p_cI-ssrA binds to P70 and inhibits g_deGFP-ssrA expression

#GRN::STOP
```

