## Introduction 
Cell free biology is an emerging technology for research, and the point of care manufacturing of a wide array of macromolecular and small molecule products. A distinctive feature of cell free systems is the absence of cellular growth and maintenance, thereby allowing the direct allocation of carbon and energy resources toward a product of interest. Moreover, cell free systems are more amenable than living systems to observation and manipulation, hence allowing rapid tuning of reaction conditions. Recent advances in cell free extract preparation and energy regeneration mechanisms have increased the versatility and range of applications that can be produced cell free.
Thus, the cell free platform has transformed from merely an investigative research tool to become a promising alternative to traditionally used living systems for biomanufacturing as well as biological research. In combination with the rise of synthetic biology, cell free systems today have not only taken on a new role as a promising technology for just in time manufacturing of therapeutically important biologics and high-value small molecules,
but have also been utilized for applications such as biosensing, prototyping genetic parts, and metabolic engineering.


## CellFreeModelGenerationKit.jl
A package for building cell-free models in [Julia language](9https://julialang.org). The purpose of this package is to generate model code for performing constraint-based modeling like flux balance anlaysis (FBA).

## Installation and Requirements
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
## Methods (why here?)
```@autodocs
Modules = [CellFreeModelGenerationKit]
```
