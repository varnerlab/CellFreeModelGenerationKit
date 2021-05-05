## Generated files

`CellFreeModelGenerationKit.jl` generates the following files for a `Static` probelm:

Filename | Description
-- | :--
`Include.jl` | Includes all the generated files into the current workspace
`Static.jl` | Solves the static Flux Balance Analysis (FBA) problem
`Checks.jl` | Checks whether or not a file with the given name exists in the current directory
`Constraints.jl` | Encodes the bounds for the fluxes as well as the species for the FBA problem. Also generates the objective function for maximization or minimization in the Linear Programming Problem
`Control.jl` | Encodes the control logic described in your GRN network file
`Data.jl` | Encodes the model parameters e.g., initial conditions or promoter function parameters in a [Julia dictionary](https://docs.julialang.org/en/stable/stdlib/collections/#Base.Dict)
`Flux.jl` | Computes the optimal metabolic flux distribution given the constraints using [GLPK.jl](https://juliapackages.com/p/glpk)
`Kinetics.jl` | Encodes the rate of transcription, translation and degradation for mRNA and protein species
`Network.dat` | Stoichiometric array for the metabolism as well as transcription and translation reactions
`Solver.jl` | Contains the functions required for solving a static or dynamic FBA problem
`Types.jl` | Contains abstract and concrete data types used for model generation and calculation
`Utility.jl` | Encodes utility functions required for model calculation (e.g., computation of the Jacobian)
