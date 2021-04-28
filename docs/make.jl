using Documenter
using CellFreeModelGenerationKit

makedocs(
    sitename = "CellFreeModelGenerationKit",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    ),
    modules = [CellFreeModelGenerationKit],
    doctest = true,
    pages = [
        "Home" => "index.md",
        "Model Generation" => "model_generation.md",
        "Model Files" => "generated_files.md",
        "Parser" => "parser.md"
    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/varnerlab/CellFreeModelGenerationKit.jl.git",
    devbranch = "main",
    devurl = "dev",
)
