## Quick start guide

### Obtain metabolism file

Create your own metabolism file that describes the system in consideration with the corresponding TXTL sequence, metabolism and the GRN section. This file should be structured in a VFF format as mentioned here (redirect to VFF format). Note the path to this metabolism file.

### Generate Model Code

To generate cell free model code, first load the `CellFreeModelGenerationKit.jl` package, then build a Julia model object from the REPL using the command `build_julia_model_object`.

```@docs
build_julia_model_object
```
Note that path where files will be written should be different from where model file is.

```@example
julia> using CellFreeModelGenerationKit
julia> build_result = build_julia_model_object(path_to_test_metabolism_file, path_to_output_dir)
julia> julia_model_object = build_result.value
```

The `build_julia_model_object` reads the model file and a defaults TOML file (if it exists) at the user specified path. If a defaults file is not provided by the user, a `Defaults.toml` file is generated. Additionally, the user can modify the contents of `Defaults.toml`. 

For writing generated code, if a directory already exists at the user specified location, it can be backed-up before new code is written (based on prompted user input). After building a Julia model object, issue the command `generate` from the REPL.

```@docs
generate
```

```@example
julia> generate(julia_model_object)
```

The model files will now be available at the user specified output directory. 

### Modify the constraints

Navigate to the user specified output path and locate the `src` directory.

Modify the constraints of the linear programming problem according to your need. Otherwise the code runs with default flux and species bounds.

Update the objective function by updating the objective coefficient array. By default, the problem is set up as a minimization problem (min_flag = true) which can be updated as well, according to the objective.

### Run `Static.jl`

Finally, to run the static FBA problem, issue the following command in the Julia REPL  -

```@example
julia> include("Static.jl")
```