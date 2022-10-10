using Documenter

dir = @__DIR__() * "/.."
cp(joinpath(dir, "README.md"), joinpath(dir, "docs", "src", "index.md"), force = true)

makedocs(sitename = "SciML Style Guide for Julia",
         authors = "Chris Rackauckas",
         modules = Module[],
         clean = true, doctest = false,
         strict = [
             :doctest,
             :linkcheck,
             :parse_error,
             :example_block,
             # Other available options are
             # :autodocs_block, :cross_references, :docs_block, :eval_block, :example_block, :footnote, :meta_block, :missing_docs, :setup_block
         ],
         format = Documenter.HTML(analytics = "UA-90474609-3",
                                  assets = ["assets/favicon.ico"],
                                  canonical = "https://scimlstyle.sciml.ai/stable/"),
         pages = [
             "SciML Style Guide for Julia" => "index.md",
         ])

deploydocs(;
           repo = "github.com/SciML/SciMLStyle",
           devbranch = "main")
