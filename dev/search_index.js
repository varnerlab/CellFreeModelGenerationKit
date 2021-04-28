var documenterSearchIndex = {"docs":
[{"location":"model_generation/#VFF-File-Structure","page":"-","title":"VFF File Structure","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"CellFreeModelGenerationKitjl transforms a structured text file into cell free model code. CellFreeModelGenerationKitjl text files consist of delimited record types organized into five sections BIO-TYPE-PREFIXES, TXTL-SEQUENCE, METABOLISM, SPECIESBOUNDS and GRN. Lines beginning with  are excluded by default. This can be modified by passing ``stripcomments = falseto thereadmodeldocument`` method.","category":"page"},{"location":"model_generation/#BIO-TYPE-PREFIXES-section","page":"-","title":"BIO-TYPE-PREFIXES section","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"Bio-type prefixes records are used to identify and declare the types of species.","category":"page"},{"location":"model_generation/#Example","page":"-","title":"Example","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"#BIO-TYPE-PREFIXES::START\n\n// Declare type prefixes -\ng is a GENE type\np is a PROTEIN type\nmRNA is a MESSENGER-RNA type\ntRNA is a TRANSFER-RNA type\nregRNA is a REGULATORY-RNA type\nM is a METABOLITE type\n\n#BIO-TYPE-PREFIXES::STOP","category":"page"},{"location":"model_generation/#TXTL-SEQUENCE-section","page":"-","title":"TXTL-SEQUENCE section","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"TXTL-SEQUENCE records","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"TXTL-SEQUENCE records are used to generate sequence specific transcription and translation reactions which are appended to the end of the metabolic reactions encoded in the METABOLISM section. TXTL-SEQUENCE records take the form:","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"{genesymbol|proteinsymbol}, sequence; where:","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"{genesymbol|proteinsymbol}: species symbol used in the model. The species symbol is a user specified identifier that is used in the model. No spaces or special chars, _ are acceptable, but +,- etc are not acceptable. sequence: nucleotide (X record) or protein (L) sequence in plain format.","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"TXTL-SEQUENCE records are terminated by a ; character.","category":"page"},{"location":"model_generation/#Example-2","page":"-","title":"Example","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"#TXTL-SEQUENCE::START\n\n// -- deGFP-ssrA gene and protein -------------------------------------------- //\ng_deGFP-ssrA,atggagcttttcactggcgttgttcccatcctggtcgagctggacggcgacgtaaacggccacaagttcagcgtgtccggc\ngagggcgagggcgatgccacctacggcaagctgaccctgaagttcatctgcaccaccggcaagctgcccgtgccctggccc\naccctcgtgaccaccctgacctacggcgtgcagtgcttcagccgctaccccgaccacatgaagcagcacgacttcttcaag\ntccgccatgcccgaaggctacgtccaggagcgcaccatcttcttcaaggacgacggcaactacaagacccgcgccgaggtg\naagttcgagggcgacaccctggtgaaccgcatcgagctgaagggcatcgacttcaaggaggacggcaacatcctggggcac\naagctggagtacaactacaacagccacaacgtctatatcatggccgacaagcagaagaacggcatcaaggtgaacttcaag\natccgccacaacatcgaggacggcagcgtgcagctcgccgaccactaccagcagaacacccccatcggcgacggccccgtg\nctgctgcccgacaaccactacctgagcacccagtccgccctgagcaaagaccccaacgagaagcgcgatcacatggtcctg\nctggagttcgtgaccgccgccgggatcgcagcaaacgacgaaaactacgctttagctgcttaa;\n\np_deGFP-ssrA,MELFTGVVPILVELDGDVNG\nHKFSVSGEGEGDATYGKLTL\nKFICTTGKLPVPWPTLVTTL\nTYGVQCFSRYPDHMKQHDFF\nKSAMPEGYVQERTIFFKDDG\nNYKTRAEVKFEGDTLVNRIE\nLKGIDFKEDGNILGHKLEYN\nYNSHNVYIMADKQKNGIKVN\nFKIRHNIEDGSVQLADHYQQ\nNTPIGDGPVLLPDNHYLSTQ\nSALSKDPNEKRDHMVLLEFV\nTAAGIAANDENYALAA;\n\n#TXTL-SEQUENCE::STOP","category":"page"},{"location":"model_generation/#METABOLISM-section","page":"-","title":"METABOLISM section","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"METABOLISM records are used to encode metabolic reactions. METABOLISM records consist of five fields.","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"reactionname, [{; delimited set of ec numbers | []}], reactantstring, product_string, reversible tag; where:","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"reactionname is a unique identifier for the reaction. reactantstring includes all the reactants participating the reaction. product_string includes all products of the reaction.  reversible tag is true if the reactions is reversible, otherwise it is false.","category":"page"},{"location":"model_generation/#Example-3","page":"-","title":"Example","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"#METABOLISM::START\n\n// ======================================================================\n// GLYCOLYSIS/ GLUCONEOGENESIS\n// ======================================================================\n// Glycogen phosphorylate (gP) 2.4.1.1\nR_gp_1,[2.4.1.1],M_maltodextrin6_c+M_pi_c,M_maltodextrin5_c+M_g1p_c,false\nR_gp_2,[2.4.1.1],M_maltodextrin5_c+M_pi_c,M_maltodextrin4_c+M_g1p_c,false\nR_gp_3,[2.4.1.1],M_maltodextrin4_c+M_pi_c,M_maltodextrin3_c+M_g1p_c,false\nR_gp_4,[2.4.1.1],M_maltodextrin3_c+M_pi_c,M_maltose_c+M_g1p_c,false\nR_gp,[2.4.1.1],M_maltose_c+M_pi_c,M_glc_D_c+M_g1p_c,false\n\n// Phosphoglucomutase (pgm) 5.4.2.2\nR_pgm,[5.4.2.2],M_g1p_c,M_g6p_c,false\n\n// Glucokinase (glk) EC 2.7.1.2\nR_glk_atp,[2.7.1.2],M_atp_c+M_glc_D_c,M_adp_c+M_g6p_c,false\n\n// Phosphoglucose isomerase (pgi) 5.3.1.9\nR_pgi,[5.3.1.9],M_g6p_c,M_f6p_c,true\n\n#METABOLISM::STOP","category":"page"},{"location":"model_generation/#SPECIES_BOUNDS-section","page":"-","title":"SPECIES_BOUNDS section","text":"","category":"section"},{"location":"model_generation/#Example-4","page":"-","title":"Example","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"#SPECIES_BOUNDS::START\n\nM_o2_e is a SOURCE\nM_co2_e is a SINK\nM_h_e is UNBOUNDED\n\n#SPECIES_BOUNDS::STOP","category":"page"},{"location":"model_generation/#GRN-section","page":"-","title":"GRN section","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"GRN records are used to define the biology of the model being generated. In this section, define various types of species (promoters, genes and polymerases) involved in the regulatory circuit and their regulatory action.","category":"page"},{"location":"model_generation/#Example-5","page":"-","title":"Example","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"#GRN::START\n\n// What are my promoters, genes and polymerases in the circuit?\nP70 is a promoter\nP28 is a promoter\ng_deGFP-ssrA is a gene\ng_cI-ssrA is a gene\ng_s28 is a gene\nRNAP is a RNA_POLYMERASE_II_SYMBOL\nRIBOSOME is a RIBOSOME_SYMBOL\n\n// formation of s70_RNAP and s28_RNAP -\np_s70 binds to RNAP and forms s70_RNAP\np_s28 binds to RNAP and forms s28_RNAP\n\n// P70 promoter TX/TL activity -\ns70_RNAP binds to P70 and activates g_deGFP-ssrA expression to form mRNA_deGFP-ssrA\nmRNA_deGFP-ssrA is translated by RIBOSOME to form p_deGFP_ssrA\ns70_RNAP binds to P70 and activates g_s28 expression to form mRNA_s28\nmRNA_s28 is translated by RIBOSOME to form p_s28\n\n// P28 promoter activity -\ns28_RNAP binds to P28 and activates g_cI-ssrA expression to form mRNA_cI-ssrA\n\n// p_cI-ssrA action -\np_cI-ssrA binds to P70 and inhibits g_s28 expression\np_cI-ssrA binds to P70 and inhibits g_deGFP-ssrA expression\n\n#GRN::STOP","category":"page"},{"location":"model_generation/#Generating-Model-Code","page":"-","title":"Generating Model Code","text":"","category":"section"},{"location":"model_generation/","page":"-","title":"-","text":"To generate cell free model code, first load the CellFreeModelGenerationKitjl package, then build a Julia model object from the REPL using the command build_julia_model_object.","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"build_julia_model_object","category":"page"},{"location":"model_generation/#CellFreeModelGenerationKit.build_julia_model_object","page":"-","title":"CellFreeModelGenerationKit.build_julia_model_object","text":"build_julia_model_object(path_to_model_file::String, path_to_output_dir::String; \n    defaults_file_name::String=\"Defaults.toml\", model_type::Symbol=:static)::VLResult\n\n\n\n\n\n","category":"function"},{"location":"model_generation/","page":"-","title":"-","text":"Note that path where files will be written should be different from where model file is.","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"julia> using CellFreeModelGenerationKit\njulia> build_result = build_julia_model_object(path_to_test_metabolism_file, path_to_output_dir)\njulia> julia_model_object = build_result.value","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"The buildjuliamodel_object reads the model file and a defaults TOML file (if it exists) at the user specified path. If a defaults file is not provided by the user, a Defaultstoml file is generated. Additionally, the user can modify the contents of Defaultstoml. ","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"For writing generated code, if a directory already exists at the user specified location, it can be backed-up before new code is written (based on prompted user input). After building a Julia model object, issue the command generate from the REPL.","category":"page"},{"location":"model_generation/","page":"-","title":"-","text":"generate","category":"page"},{"location":"model_generation/#CellFreeModelGenerationKit.generate","page":"-","title":"CellFreeModelGenerationKit.generate","text":"generate(julia_model_object::VLJuliaModelObject; \n    intermediate_representation_dictionary::Union{Nothing,Dict{String,Any}} = nothing, \n    logger::Union{Nothing,SimpleLogger} = nothing)\n\n\n\n\n\n","category":"function"},{"location":"model_generation/","page":"-","title":"-","text":"julia> generate(julia_model_object)","category":"page"},{"location":"generated_files/#Generated-files","page":"-","title":"Generated files","text":"","category":"section"},{"location":"generated_files/","page":"-","title":"-","text":"CellFreeModelGenerationKitjl generates the following files for a Static probelm:","category":"page"},{"location":"generated_files/","page":"-","title":"-","text":"Filename Description\nIncludejl Includes all the generated files into the current workspace\nStaticjl Solves the static Flux Balance Analysis (FBA) problem\nChecksjl Checks whether or not a file with the given name exists in the current directory\nConstraintsjl Encodes the bounds for the fluxes as well as the species for the FBA problem. Also generates the objective function for maximization or minimization in the Linear Programming Problem\nControljl Encodes the control logic described in your GRN network file\nDatajl Encodes the model parameters e.g., initial conditions or promoter function parameters in a Julia dictionary\nFluxjl Computes the optimal metabolic flux distribution given the constraints using GLPK.jl\nKineticsjl Encodes the rate of transcription, translation and degradation for mRNA and protein species\nNetworkdat Stoichiometric array for the metabolism as well as transcription and translation reactions\nSolverjl Contains the functions required for solving a static or dynamic FBA problem\nTypesjl Contains abstract and concrete data types used for model generation and calculation\nUtilityjl Encodes utility functions required for model calculation (e.g., computation of the Jacobian)","category":"page"},{"location":"generated_files/","page":"-","title":"-","text":"```","category":"page"},{"location":"#CellFreeModelGenerationKit.jl","page":"Home","title":"CellFreeModelGenerationKit.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A package for building cell-free models in Julia language. The purpose of this package is to generate model code for performing constraint-based modeling like flux balance anlaysis (FBA).","category":"page"},{"location":"#Getting-Started:-Installation-and-Requirements","page":"Home","title":"Getting Started: Installation and Requirements","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"CellFreeModelGenerationKitjl is open source, available under a MIT software license. You can download this repository as a zip file, clone or pull it by using the command (from the command-line):","category":"page"},{"location":"","page":"Home","title":"Home","text":"$ git clone https://github.com/varnerlab/CFMG.git","category":"page"},{"location":"","page":"Home","title":"Home","text":"CellFreeModelGenerationKitjl is organized as a Julia package which can be installed in the package mode of Julia.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Open the Julia REPL and enter the package mode using the  key. Then, at the prompt enter:","category":"page"},{"location":"","page":"Home","title":"Home","text":"(@v1.5) pkg> add https://github.com/varnerlab/CFMG.git","category":"page"},{"location":"","page":"Home","title":"Home","text":"This will install the CellFreeModelGenerationKitjl package and the other required packages. CellFreeModelGenerationKitjl requires Julia 1.5.x and above.","category":"page"},{"location":"","page":"Home","title":"Home","text":"There are several other packages that are required to run the model. However, these should be installed automatically the first time you run your code. The linear programming problem is solved using the GLPK solver, which is freely available for a variety of platforms. The following dependencies are installed: DataFrames, CSV, Dates, Logging, WordTokenizers, DelimitedFiles and SQLite.","category":"page"},{"location":"#Methods","page":"Home","title":"Methods","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_sequence_section","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_sequence_section","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_sequence_section","text":"parse_vff_sequence_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"function"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_metabolic_section","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_metabolic_section","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_metabolic_section","text":"parse_vff_metabolic_section(buffer::Array{String,1})::VLResult\n\n\n\n\n\n","category":"function"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_species_bounds_section","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_species_bounds_section","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_species_bounds_section","text":"parse_vff_species_bounds_section(buffer::Array{String,1}, metabolic_results_tuple::NamedTuple)::VLResult\n\n\n\n\n\n","category":"function"},{"location":"parser/","page":"Parser","title":"Parser","text":"parse_vff_model_document","category":"page"},{"location":"parser/#CellFreeModelGenerationKit.parse_vff_model_document","page":"Parser","title":"CellFreeModelGenerationKit.parse_vff_model_document","text":"parse_vff_model_document(model::VLAbstractModelObject)::VLResult\n\n\n\n\n\n","category":"function"}]
}