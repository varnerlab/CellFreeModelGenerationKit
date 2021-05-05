![CI](https://github.com/varnerlab/CellFreeModelGenerationKit.jl/workflows/CI/badge.svg)
![Documentation](https://github.com/varnerlab/CellFreeModelGenerationKit.jl/workflows/Documentation/badge.svg)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://varnerlab.github.io/CellFreeModelGenerationKit.jl/dev)

# CellFreeModelGenerationKit
This package generates constraint based models of genetic circuits in cell free systems. 
The cell free models are written in the [Julia programming language](9https://julialang.org).  

## Installation and Requirements
`CellFreeModelGenerationKit.jl` is open source, available under a MIT software license. 
You can download this repository as a zip file, clone or pull it by using the command (from the command-line):
```@example
$ git clone https://github.com/varnerlab/CellFreeModelGenerationKit.git
```
`CellFreeModelGenerationKit.jl` is organized as a Julia package which can be installed in the `package mode` of Julia.
Open the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/index.html) and enter the `package mode` using the `]` key. Then, at the prompt enter:
```@example
(@v1.6) pkg> add https://github.com/varnerlab/CellFreeModelGenerationKit.git
```
