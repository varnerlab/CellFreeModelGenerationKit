# VFF format
VFF format is designed to be the standard input format of `CFMG.jl`.
Aside from comments marked by preceding two slashes '//', each VFF file contains three parts: TXTL-SEQUENCE, metabolism, and gene regulatory network.
Each part has its start and end marks, and specific syntactic format for describing biological information.


## Genetic sequence section 
The `TXTL-SEQUENCE` section is used to incorporate genetic and protein sequence into the flux calculation. 

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

## Metabolism section
Put example here

item | des
---: | :---
Start| \#METABOLISM::START
End | {\#METABOLISM::STOP}
Format | {name, [ECs],reactant,product,is\_reversible}
Argument | Description
name | {unique string denoting reaction name}
ECs | {';' delimited set of ec numbers, use '[]' if no EC}
reactant | {reactant symbols connected by '+', metabolite symbols can not have special chars or spaces, stochiometric coefficients are pre-pended to metabolite symbol}
product | {product symbols connected by '+', metabolite symbols can not have special chars or spaces, stochiometric coefficients are pre-pended to metabolite symbol}
is\_reversible | {true|false}
Example | {R\_A\_syn\_2,[6.3.4.13],M\_atp\_c+M\_5pbdra+M\_gly\_L\_c,M\_adp\_c+M\_pi\_c+M\_gar\_c,false} {R\_adhE,[1.2.1.10;1.1.1.1],M\_accoa\_c+2*M\_h\_c+2*M\_nadh\_c,M\_etoh\_c+2*M\_nad\_c,true}
{M\_h2s\_c\_exchange,[],[],M\_h2s\_c,true}


## Gene regulatory network

item | des
---: | :---
Start | {\#GRN::START}
 End | {\#GRN::STOP}
Format | {actors action target}
Argument | Description
actors | {comma ',' delimited list of actors}
action | {activate, activates, activated, induce, induces, induced, inhibit, inhibits, inhibited, repress, represses, represses}
target | {the target}
Example | {cI\_ssrA inhibits deGFP\_ssrA} {s70 activates deGFP\_ssrA}
