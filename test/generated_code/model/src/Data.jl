# ----------------------------------------------------------------------------------- #
# Copyright (c) 2021 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
function generate_default_data_dictionary()::Union{Dict{String,Any},Exception}

	# initialize data storage - 
	data_dictionary = Dict{String,Any}()

	try
		# load the stoichiometric_matrix - 
		stoichiometric_matrix = readdlm("Network.dat")
		(number_of_species, number_of_reactions) = size(stoichiometric_matrix)

		# initialize objective coefficient array - 
		objective_coefficient_array = zeros(number_of_reactions)

		# setup the flux bounds array - 
		flux_bounds_array = [
			0.0 DEFAULT_UPPER_BOUND	;	#	1	R_gp_1
			0.0 DEFAULT_UPPER_BOUND	;	#	2	R_gp_2
			0.0 DEFAULT_UPPER_BOUND	;	#	3	R_gp_3
			0.0 DEFAULT_UPPER_BOUND	;	#	4	R_gp_4
			0.0 DEFAULT_UPPER_BOUND	;	#	5	R_gp
			0.0 DEFAULT_UPPER_BOUND	;	#	6	R_pgm
			0.0 DEFAULT_UPPER_BOUND	;	#	7	R_glk_atp
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	8	R_pgi
			0.0 DEFAULT_UPPER_BOUND	;	#	9	R_pfk
			0.0 DEFAULT_UPPER_BOUND	;	#	10	R_fdp
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	11	R_fbaA
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	12	R_tpiA
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	13	R_gpsA
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	14	R_gapA
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	15	R_pgk
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	16	R_gpm
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	17	R_eno
			0.0 DEFAULT_UPPER_BOUND	;	#	18	R_pyk
			0.0 DEFAULT_UPPER_BOUND	;	#	19	R_pck
			0.0 DEFAULT_UPPER_BOUND	;	#	20	R_ppc
			0.0 DEFAULT_UPPER_BOUND	;	#	21	R_pdh
			0.0 DEFAULT_UPPER_BOUND	;	#	22	R_pps
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	23	R_zwf
			0.0 DEFAULT_UPPER_BOUND	;	#	24	R_pgl
			0.0 DEFAULT_UPPER_BOUND	;	#	25	R_gnd
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	26	R_rpe
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	27	R_rpi
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	28	R_talAB
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	29	R_tkt1
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	30	R_tkt2
			0.0 DEFAULT_UPPER_BOUND	;	#	31	R_edd
			0.0 DEFAULT_UPPER_BOUND	;	#	32	R_eda
			0.0 DEFAULT_UPPER_BOUND	;	#	33	R_gltA
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	34	R_acn
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	35	R_icd
			0.0 DEFAULT_UPPER_BOUND	;	#	36	R_sucAB
			0.0 DEFAULT_UPPER_BOUND	;	#	37	R_sucCD
			0.0 DEFAULT_UPPER_BOUND	;	#	38	R_sdh
			0.0 DEFAULT_UPPER_BOUND	;	#	39	R_frd
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	40	R_fum
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	41	R_mdh
			0.0 DEFAULT_UPPER_BOUND	;	#	42	R_cyd
			0.0 DEFAULT_UPPER_BOUND	;	#	43	R_cyo
			0.0 DEFAULT_UPPER_BOUND	;	#	44	R_app
			0.0 DEFAULT_UPPER_BOUND	;	#	45	R_atp
			0.0 DEFAULT_UPPER_BOUND	;	#	46	R_DNP_leak
			0.0 DEFAULT_UPPER_BOUND	;	#	47	R_nuo
			0.0 DEFAULT_UPPER_BOUND	;	#	48	R_pnt1
			0.0 DEFAULT_UPPER_BOUND	;	#	49	R_pnt2
			0.0 DEFAULT_UPPER_BOUND	;	#	50	R_ndh1
			0.0 DEFAULT_UPPER_BOUND	;	#	51	R_ndh2
			0.0 DEFAULT_UPPER_BOUND	;	#	52	R_ppa
			0.0 DEFAULT_UPPER_BOUND	;	#	53	R_aceA
			0.0 DEFAULT_UPPER_BOUND	;	#	54	R_aceB
			0.0 DEFAULT_UPPER_BOUND	;	#	55	R_maeA
			0.0 DEFAULT_UPPER_BOUND	;	#	56	R_maeB
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	57	R_pta
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	58	R_ackA
			0.0 DEFAULT_UPPER_BOUND	;	#	59	R_acs
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	60	R_adhE
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	61	R_ldh
			0.0 DEFAULT_UPPER_BOUND	;	#	62	R_pflAB
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	63	R_alaAC
			0.0 DEFAULT_UPPER_BOUND	;	#	64	R_arg
			0.0 DEFAULT_UPPER_BOUND	;	#	65	R_aspC
			0.0 DEFAULT_UPPER_BOUND	;	#	66	R_asnB
			0.0 DEFAULT_UPPER_BOUND	;	#	67	R_asnA
			0.0 DEFAULT_UPPER_BOUND	;	#	68	R_cysEMK
			0.0 DEFAULT_UPPER_BOUND	;	#	69	R_gltBD
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	70	R_gdhA
			0.0 DEFAULT_UPPER_BOUND	;	#	71	R_glnA
			0.0 DEFAULT_UPPER_BOUND	;	#	72	R_glyA
			0.0 DEFAULT_UPPER_BOUND	;	#	73	R_his
			0.0 DEFAULT_UPPER_BOUND	;	#	74	R_ile
			0.0 DEFAULT_UPPER_BOUND	;	#	75	R_leu
			0.0 DEFAULT_UPPER_BOUND	;	#	76	R_lys
			0.0 DEFAULT_UPPER_BOUND	;	#	77	R_met
			0.0 DEFAULT_UPPER_BOUND	;	#	78	R_phe
			0.0 DEFAULT_UPPER_BOUND	;	#	79	R_pro
			0.0 DEFAULT_UPPER_BOUND	;	#	80	R_serABC
			0.0 DEFAULT_UPPER_BOUND	;	#	81	R_thr
			0.0 DEFAULT_UPPER_BOUND	;	#	82	R_trp
			0.0 DEFAULT_UPPER_BOUND	;	#	83	R_tyr
			0.0 DEFAULT_UPPER_BOUND	;	#	84	R_val
			0.0 DEFAULT_UPPER_BOUND	;	#	85	R_arg_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	86	R_asp_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	87	R_asn_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	88	R_gly_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	89	R_mglx_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	90	R_ser_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	91	R_pro_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	92	R_thr_deg1
			0.0 DEFAULT_UPPER_BOUND	;	#	93	R_thr_deg2
			0.0 DEFAULT_UPPER_BOUND	;	#	94	R_thr_deg3
			0.0 DEFAULT_UPPER_BOUND	;	#	95	R_trp_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	96	R_cys_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	97	R_lys_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	98	R_gln_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	99	R_glu_deg
			0.0 DEFAULT_UPPER_BOUND	;	#	100	R_gaba_deg1
			0.0 DEFAULT_UPPER_BOUND	;	#	101	R_gaba_deg2
			0.0 DEFAULT_UPPER_BOUND	;	#	102	R_chor
			0.0 DEFAULT_UPPER_BOUND	;	#	103	R_fol_e
			0.0 DEFAULT_UPPER_BOUND	;	#	104	R_fol_1
			0.0 DEFAULT_UPPER_BOUND	;	#	105	R_fol_2a
			0.0 DEFAULT_UPPER_BOUND	;	#	106	R_fol_2b
			0.0 DEFAULT_UPPER_BOUND	;	#	107	R_fol_3
			0.0 DEFAULT_UPPER_BOUND	;	#	108	R_fol_4
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	109	R_gly_fol
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	110	R_mthfd
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	111	R_mthfc
			0.0 DEFAULT_UPPER_BOUND	;	#	112	R_mthfr2a
			0.0 DEFAULT_UPPER_BOUND	;	#	113	R_mthfr2b
			0.0 DEFAULT_UPPER_BOUND	;	#	114	R_prpp_syn
			0.0 DEFAULT_UPPER_BOUND	;	#	115	R_or_syn_1
			0.0 DEFAULT_UPPER_BOUND	;	#	116	R_or_syn_2
			0.0 DEFAULT_UPPER_BOUND	;	#	117	R_omp_syn
			0.0 DEFAULT_UPPER_BOUND	;	#	118	R_ump_syn
			0.0 DEFAULT_UPPER_BOUND	;	#	119	R_ctp_1
			0.0 DEFAULT_UPPER_BOUND	;	#	120	R_ctp_2
			0.0 DEFAULT_UPPER_BOUND	;	#	121	R_A_syn_1
			0.0 DEFAULT_UPPER_BOUND	;	#	122	R_A_syn_2
			0.0 DEFAULT_UPPER_BOUND	;	#	123	R_A_syn_3
			0.0 DEFAULT_UPPER_BOUND	;	#	124	R_A_syn_4
			0.0 DEFAULT_UPPER_BOUND	;	#	125	R_A_syn_5
			0.0 DEFAULT_UPPER_BOUND	;	#	126	R_A_syn_6
			0.0 DEFAULT_UPPER_BOUND	;	#	127	R_A_syn_7
			0.0 DEFAULT_UPPER_BOUND	;	#	128	R_A_syn_8
			0.0 DEFAULT_UPPER_BOUND	;	#	129	R_A_syn_9
			0.0 DEFAULT_UPPER_BOUND	;	#	130	R_A_syn_10
			0.0 DEFAULT_UPPER_BOUND	;	#	131	R_A_syn_12
			0.0 DEFAULT_UPPER_BOUND	;	#	132	R_xmp_syn
			0.0 DEFAULT_UPPER_BOUND	;	#	133	R_gmp_syn
			0.0 DEFAULT_UPPER_BOUND	;	#	134	R_atp_amp
			0.0 DEFAULT_UPPER_BOUND	;	#	135	R_utp_ump
			0.0 DEFAULT_UPPER_BOUND	;	#	136	R_ctp_cmp
			0.0 DEFAULT_UPPER_BOUND	;	#	137	R_gtp_gmp
			0.0 DEFAULT_UPPER_BOUND	;	#	138	R_atp_adp
			0.0 DEFAULT_UPPER_BOUND	;	#	139	R_utp_adp
			0.0 DEFAULT_UPPER_BOUND	;	#	140	R_ctp_adp
			0.0 DEFAULT_UPPER_BOUND	;	#	141	R_gtp_adp
			0.0 DEFAULT_UPPER_BOUND	;	#	142	R_udp_utp
			0.0 DEFAULT_UPPER_BOUND	;	#	143	R_cdp_ctp
			0.0 DEFAULT_UPPER_BOUND	;	#	144	R_gdp_gtp
			0.0 DEFAULT_UPPER_BOUND	;	#	145	R_atp_ump
			0.0 DEFAULT_UPPER_BOUND	;	#	146	R_atp_cmp
			0.0 DEFAULT_UPPER_BOUND	;	#	147	R_atp_gmp
			0.0 DEFAULT_UPPER_BOUND	;	#	148	R_adk_atp
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	149	M_h2s_c_exchange
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	150	M_h2o_c_exchange
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	151	M_pi_c_exchange
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	152	M_nh3_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	153	M_hco3_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	154	M_etoh_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	155	M_mglx_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	156	M_prop_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	157	M_indole_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	158	M_cadav_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	159	M_gaba_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	160	M_glycoA_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	161	M_o2_c_exchange
			0.0 DEFAULT_UPPER_BOUND	;	#	162	M_co2_c_exchange
			DEFAULT_LOWER_BOUND DEFAULT_UPPER_BOUND	;	#	163	M_h_c_exchange
		]

		# setup the species bounds array - 
		species_bounds_array = zeros(number_of_species,2)

		# ----------------------------------------------------------------------------------- # 
		data_dictionary["flux_bounds_array"] = flux_bounds_array
		data_dictionary["stoichiometric_matrix"] = stoichiometric_matrix
		data_dictionary["objective_coefficient_array"] = objective_coefficient_array
		data_dictionary["species_bounds_array"] = species_bounds_array
		data_dictionary["number_of_species"] = number_of_species
		data_dictionary["number_of_reactions"] = number_of_reactions
		# ----------------------------------------------------------------------------------- # 

		# return -
		return data_dictionary
	catch error
		rethrow(error)
	end
end
