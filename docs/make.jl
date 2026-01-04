using Documenter

dir = @__DIR__() * "/.."

# Copy README.md to index.md and prepend @meta block for correct EditURL
readme_content = read(joinpath(dir, "README.md"), String)
index_content = """
    ```@meta
    EditURL = "https://github.com/SciML/SciMLStyle/blob/main/README.md"
    ```

    """ * readme_content
write(joinpath(dir, "docs", "src", "index.md"), index_content)

makedocs(
    sitename = "SciML Style Guide for Julia",
    authors = "Chris Rackauckas",
    modules = Module[],
    clean = true, doctest = false, linkcheck = true,
    linkcheck_ignore = [
        "https://docs.julialang.org/en/v1/base/math/#Base.:^-Tuple{Number,%20Number}",
        "https://github.com/SciML/OrdinaryDiffEq.jl/blob/v6.10.0/test/runtests.jl",
        "https://documenter.juliadocs.org/stable/man/doctests/",
    ],
    format = Documenter.HTML(
        assets = ["assets/favicon.ico"],
        canonical = "https://docs.sciml.ai/SciMLStyle/stable/"
    ),
    pages = [
        "SciML Style Guide for Julia" => "index.md",
    ]
)

deploydocs(;
    repo = "github.com/SciML/SciMLStyle",
    devbranch = "main"
)
