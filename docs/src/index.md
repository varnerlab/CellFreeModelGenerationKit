## CellFreeModelGenerationKit.jl
A package for building cell-free models in [Julia language](9https://julialang.org). The purpose of this package is to generate model code for performing constraint-based modeling like flux balance anlaysis (FBA).
## Getting Started: Installation and Requirements
`CellFreeModelGenerationKit.jl` is open source, available under a MIT software license. You can download this repository as a zip file, clone or pull it by using the command (from the command-line):
```@example
$ git clone https://github.com/varnerlab/CellFreeModelGenerationKit.git
```
`CellFreeModelGenerationKit.jl` is organized as a Julia package which can be installed in the `package mode` of Julia.
Open the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/index.html) and enter the `package mode` using the `]` key. Then, at the prompt enter:
```@example
(@v1.5) pkg> add https://github.com/varnerlab/CellFreeModelGenerationKit.git
```
This will install the `CellFreeModelGenerationKit.jl` package and the other required packages. `CellFreeModelGenerationKit.jl` requires Julia 1.5.x and above.
There are several other packages that are required to run the model. However, these should be installed automatically the first time you run your code. The linear programming problem is solved using the [GLPK solver](https://juliapackages.com/p/glpk), which is freely available for a variety of platforms. The following dependencies are installed: [DataFrames](https://dataframes.juliadata.org/stable/), [CSV](https://csv.juliadata.org/stable/), [Dates](https://docs.julialang.org/en/v1/stdlib/Dates/), [Logging](https://docs.julialang.org/en/v1/stdlib/Logging/), [WordTokenizers](https://github.com/JuliaText/WordTokenizers.jl), [DelimitedFiles](https://docs.julialang.org/en/v1/stdlib/DelimitedFiles/) and [SQLite](https://juliadatabases.org/SQLite.jl/stable/).
## Methods
```@autodocs
Modules = [CellFreeModelGenerationKit]
```