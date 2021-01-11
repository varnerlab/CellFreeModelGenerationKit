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

# import pkg -
import Pkg
Pkg.activate(_PATH_TO_ROOT)
Pkg.instantiate()

# system packages - these are required to be installed to solve the modeling problem
# check: - are these are installed? 
# y => all is good with the world.
# n => Ooops, we need to install them
using LinearAlgebra # pre-installed w/Julia
using Statistics    # pre-installed w/Julia
using GLPK
using DelimitedFiles
using TOML
using CSV
using DataFrames
using Logging

# load my model files -
include("./src/Checks.jl")
include("./src/Types.jl")
include("./src/Data.jl")
include("./src/Kinetics.jl")
include("./src/Control.jl")
include("./src/Solver.jl")
include("./src/Utility.jl")
include("./src/Flux.jl")
include("./src/Constraints.jl")

