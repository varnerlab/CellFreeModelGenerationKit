# ----------------------------------------------------------------------------------- #
# Copyright (c) 2020 Varnerlab
# Robert Frederick School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850

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

# where are we installed?
_PATH_TO_ROOT = pwd()
_PATH_TO_SRC = joinpath(_PATH_TO_ROOT,"src")

# import pkg -
import Pkg
Pkg.activate(_PATH_TO_ROOT)
Pkg.instantiate()

# system packages - these are required to be installed to solve the modeling problem
using LinearAlgebra # pre-installed w/Julia
using Statistics    # pre-installed w/Julia
using GLPK
using DelimitedFiles
using TOML
using CSV
using DataFrames
using Logging

# load my model files -
my_model_files_array = [
    "Checks.jl"         ;
    "Types.jl"          ;
    "Data.jl"           ;
    "Kinetics.jl"       ;
    "Control.jl"        ;
    "Solver.jl"         ;
    "Utility.jl"        ;
    "Flux.jl"           ;
    "Constraints.jl"    ;    
]

# process my model files -
for file_name in my_model_files_array
    path_to_my_file = joinpath(_PATH_TO_SRC,file_name)
    include("$(path_to_my_file)")
end

