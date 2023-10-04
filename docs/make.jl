using Documenter

dir = @__DIR__() * "/.."
cp(joinpath(dir, "README.md"), joinpath(dir, "docs", "src", "index.md"), force = true)

makedocs(sitename = "SciML Style Guide for Julia",
         authors = "Chris Rackauckas",
         modules = Module[],
         clean = true, doctest = false, linkcheck = true,
         linkcheck_ignore = ["https://docs.julialang.org/en/v1/base/math/#Base.:^-Tuple{Number,%20Number}"],
         format = Documenter.HTML(assets = ["assets/favicon.ico"],
                                  canonical = "https://docs.sciml.ai/SciMLStyle/stable/"),
         pages = [
             "SciML Style Guide for Julia" => "index.md",
         ])

deploydocs(;
           repo = "github.com/SciML/SciMLStyle",
           devbranch = "main")
