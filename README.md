# SciML Style Guide for Julia

[![SciML Code Style](https://img.shields.io/static/v1?label=code%20style&message=SciML&color=9558b2&labelColor=389826)](https://github.com/SciML/SciMLStyle)
[![Global Docs](https://img.shields.io/badge/docs-SciML-blue.svg)](https://docs.sciml.ai/SciMLStyle/stable/)

The SciML Style Guide is a style guide for the Julia programming language. It is used by the
[SciML Open Source Scientific Machine Learning Organization](https://sciml.ai/). It covers proper 
styles to allow for easily high-quality, readable, robust, safety, and fast code that is easy to 
maintain for production and deployment.

It is open to discussion with the community. Please file an issue or open a PR to discuss changes to
the style guide.

**Table of Contents**
- [SciML Style Guide for Julia](#sciml-style-guide-for-julia)
  - [Code Style Badge](#code-style-badge)
  - [Overarching Dogmas of the SciML Style](#overarching-dogmas-of-the-sciml-style)
    - [Consistency vs Adherence](#consistency-vs-adherence)
    - [Community Contribution Guidelines](#community-contribution-guidelines)
    - [Open source contributions are allowed to start small and grow over time](#open-source-contributions-are-allowed-to-start-small-and-grow-over-time)
    - [Generic code is preferred unless code is known to be specific](#generic-code-is-preferred-unless-code-is-known-to-be-specific)
    - [Internal types should match the types used by users when possible](#internal-types-should-match-the-types-used-by-users-when-possible)
    - [Trait definition and adherence to generic interface is preferred when possible](#trait-definition-and-adherence-to-generic-interface-is-preferred-when-possible)
    - [Macros should be limited and only be used for syntactic sugar](#macros-should-be-limited-and-only-be-used-for-syntactic-sugar)
    - [Errors should be caught as high as possible, and error messages should be contextualized for newcomers](#errors-should-be-caught-as-high-as-possible-and-error-messages-should-be-contextualized-for-newcomers)
    - [Subpackaging and interface packages is preferred over conditional modules via Requires.jl](#subpackaging-and-interface-packages-is-preferred-over-conditional-modules-via-requiresjl)
    - [Functions should either attempt to be non-allocating and reuse caches, or treat inputs as immutable](#functions-should-either-attempt-to-be-non-allocating-and-reuse-caches-or-treat-inputs-as-immutable)
    - [Out-Of-Place and Immutability is preferred when sufficient performant](#out-of-place-and-immutability-is-preferred-when-sufficient-performant)
    - [Tests should attempt to cover a wide gamut of input types](#tests-should-attempt-to-cover-a-wide-gamut-of-input-types)
    - [When in doubt, a submodule should become a subpackage or separate package](#when-in-doubt-a-submodule-should-become-a-subpackage-or-separate-package)
    - [Globals should be avoided whenever possible](#globals-should-be-avoided-whenever-possible)
    - [Type-stable and Type-grounded code is preferred wherever possible](#type-stable-and-type-grounded-code-is-preferred-wherever-possible)
    - [Closures should be avoided whenever possible](#closures-should-be-avoided-whenever-possible)
    - [Numerical functionality should use the appropriate generic numerical interfaces](#numerical-functionality-should-use-the-appropriate-generic-numerical-interfaces)
    - [Functions should capture one underlying principle](#functions-should-capture-one-underlying-principle)
    - [Internal choices should be exposed as options whenever possible](#internal-choices-should-be-exposed-as-options-whenever-possible)
    - [Prefer code reuse over rewrites whenever possible](#prefer-code-reuse-over-rewrites-whenever-possible)
    - [Prefer to not shadow functions](#prefer-to-not-shadow-functions)
    - [Avoid unmaintained dependencies](#avoid-unmaintained-dependencies)
    - [Avoid unsafe operations](#avoid-unsafe-operations)
    - [Avoid non public operations in Julia Base and packages](#avoid-non-public-operations-in-julia-base-and-packages)
    - [Always default to constructs which initialize data](#always-default-to-constructs-which-initialize-data)
    - [Use extra precaution when running external processes](#use-extra-precaution-when-running-external-processes)
    - [Avoid eval whenever possible](#avoid-eval-whenever-possible)
    - [Avoid bounds check removal, and if done, add appropriate manual checks](#avoid-bounds-check-removal-and-if-done-add-appropriate-manual-checks)
    - [Avoid ccall unless necessary, and use safe ccall practices when required](#avoid-ccall-unless-necessary-and-use-safe-ccall-practices-when-required)
    - [Validate all user inputs to avoid code injection](#validate-all-user-inputs-to-avoid-code-injection)
    - [Ensure secure random number generators are used when required](#ensure-secure-random-number-generators-are-used-when-required)
    - [Be aware of distributed computing encryption principles](#be-aware-of-distributed-computing-encryption-principles)
    - [Always immediately flush secret data after handling](#always-immediately-flush-secret-data-after-handling)
  - [Specific Rules](#specific-rules)
    - [High Level Rules](#high-level-rules)
    - [General Naming Principles](#general-naming-principles)
    - [Comments](#comments)
    - [Modules](#modules)
    - [Functions](#functions)
    - [Function Argument Precedence](#function-argument-precedence)
    - [Tests and Continuous Integration](#tests-and-continuous-integration)
    - [Whitespace](#whitespace)
    - [NamedTuples](#namedtuples)
    - [Numbers](#numbers)
    - [Ternary Operator](#ternary-operator)
    - [For loops](#for-loops)
    - [Function Type Annotations](#function-type-annotations)
    - [Struct Type Annotations](#struct-type-annotations)
    - [Macros](#macros)
    - [Types and Type Annotations](#types-and-type-annotations)
    - [Package version specifications](#package-version-specifications)
    - [Documentation](#documentation)
    - [Error Handling](#error-handling)
    - [Arrays](#arrays)
    - [Line Endings](#line-endings)
    - [VS-Code Settings](#vs-code-settings)
    - [JuliaFormatter](#juliaformatter)
- [References](#references)


## Code Style Badge

Let contributors know your project is following the SciML Style Guide by adding the badge to your `README.md`.

```md
[![SciML Code Style](https://img.shields.io/static/v1?label=code%20style&message=SciML&color=9558b2&labelColor=389826)](https://github.com/SciML/SciMLStyle)
```

## Overarching Dogmas of the SciML Style

### Consistency vs Adherence

According to PEP8:

> A style guide is about consistency. Consistency with this style guide is important.
> Consistency within a project is more important. Consistency within one module or function is the most important.

> But most importantly: know when to be inconsistent -- sometimes the style guide just doesn't apply.
> When in doubt, use your best judgment. Look at other examples and decide what looks best. And don't hesitate to ask!

Some code within the SciML organization is old, on life support, donated by researchers to be maintained.
Consistency is the number one goal, so updating to match the style guide should happen on a repo-by-repo
basis, i.e. do not update one file to match the style guide (leaving all other files behind).

### Community Contribution Guidelines

For a comprehensive set of community contribution guidelines, refer to [ColPrac](https://github.com/SciML/ColPrac).
A relevant point to highlight PRs should do one thing. In the context of style, this means that PRs that update
the style of a package's code should not be mixed with fundamental code contributions. This separation makes it
easier to ensure that large style improvements are isolated from substantive (and potentially breaking) code changes.

### Open source contributions are allowed to start small and grow over time

If the standard for code contributions is that every PR needs to support every possible input type that anyone can
think of, the barrier would be too high for newcomers. Instead, the principle is to be as correct as possible to
begin with, and grow the generic support over time. All recommended functionality should be tested, and any known
generality issues should be documented in an issue (and with a `@test_broken` test when possible). However, a
function that is known to not be GPU-compatible is not grounds to block merging, rather it is encouraged for a
follow-up PR to improve the general type support!

### Generic code is preferred unless code is known to be specific

For example, the code:

```julia
function f(A, B)
    for i in 1:length(A)
        A[i] = A[i] + B[i]
    end
end
```

would not be preferred for two reasons. One is that it assumes `A` uses one-based indexing, which would fail in cases
like [OffsetArrays](https://github.com/JuliaArrays/OffsetArrays.jl) and [FFTViews](https://github.com/JuliaArrays/FFTViews.jl).
Another issue is that it requires indexing, while not all array types support indexing (for example,
[CuArrays](https://github.com/JuliaGPU/CuArrays.jl)). A more generic and compatible implementation of this function would be
to use broadcast, for example:

```julia
function f(A, B)
    @. A = A + B
end
```

which would allow support for a wider variety of array types.

### Internal types should match the types used by users when possible

If `f(A)` takes the input of some collections and computes an output from those collections, then it should be
expected that if the user gives `A` as an `Array`, the computation should be done via `Array`s. If `A` was a
`CuArray`, then it should be expected that the computation should be internally done using a `CuArray` (or appropriately
error if not supported). For these reasons, constructing arrays via generic methods, like `similar(A)`, is preferred when
writing `f` instead of using non-generic constructors like `Array(undef,size(A))` unless the function is documented as
being non-generic.

### Trait definition and adherence to generic interface is preferred when possible

Julia provides many different interfaces, for example:

- [Iteration](https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-iteration)
- [Indexing](https://docs.julialang.org/en/v1/manual/interfaces/#Indexing)
- [Broadcast](https://docs.julialang.org/en/v1/manual/interfaces/#man-interfaces-broadcasting)

Those interfaces should be followed when possible. For example, when defining broadcast overloads,
one should implement a `BroadcastStyle` as suggested by the documentation instead of simply attempting
to bypass the broadcast system via `copyto!` overloads.

When interface functions are missing, these should be added to Base Julia or an interface package,
like [ArrayInterface.jl](https://github.com/JuliaArrays/ArrayInterface.jl). Such traits should be
declared and used when appropriate. For example, if a line of code requires mutation, the trait
`ArrayInterface.ismutable(A)` should be checked before attempting to mutate, and informative error
messages should be written to capture the immutable case (or, an alternative code that does not
mutate should be given).

One example of this principle is demonstrated in the generation of Jacobian matrices. In many scientific
applications, one may wish to generate a Jacobian cache from the user's input `u0`. A naive way to generate
this Jacobian is `J = similar(u0,length(u0),length(u0))`. However, this will generate a Jacobian `J` such
that `J isa Matrix`.

### Macros should be limited and only be used for syntactic sugar

Macros define new syntax, and for this reason, they tend to be less composable than other coding styles
and require prior familiarity to be easily understood. One principle to keep in mind is, "can the person
reading the code easily picture what code is being generated?". For example, a user of Soss.jl may not know
what code is being generated by:

```julia
@model (x, α) begin
    σ ~ Exponential()
    β ~ Normal()
    y ~ For(x) do xj
        Normal(α + β * xj, σ)
    end
    return y
end
```

and thus using such a macro as the interface is not preferred when possible. However, a macro like
[`@muladd`](https://github.com/SciML/MuladdMacro.jl) is trivial to picture on a code (it recursively
transforms `a*b + c` to `muladd(a,b,c)` for more
[accuracy and efficiency](https://en.wikipedia.org/wiki/Multiply%E2%80%93accumulate_operation)), so using
such a macro, for example:

```julia
julia> @macroexpand(@muladd k3 = f(t + c3 * dt, @. uprev + dt * (a031 * k1 + a032 * k2)))
:(k3 = f((muladd)(c3, dt, t), (muladd).(dt, (muladd).(a032, k2, (*).(a031, k1)), uprev)))
```

is recommended. Some macros in this category are:

- `@inbounds`
- [`@muladd`](https://github.com/SciML/MuladdMacro.jl)
- `@view`
- [`@named`](https://github.com/SciML/ModelingToolkit.jl)
- `@.`
- [`@..`](https://github.com/YingboMa/FastBroadcast.jl)

Some performance macros, like `@simd`, `@threads`, or
[`@turbo` from LoopVectorization.jl](https://github.com/JuliaSIMD/LoopVectorization.jl),
make an exception in that their generated code may be foreign to many users. However, they still are
classified as appropriate uses as they are syntactic sugar since they do (or should) not change the behavior
of the program in measurable ways other than performance.

### Errors should be caught as high as possible, and error messages should be contextualized for newcomers

Whenever possible, defensive programming should be used to check for potential errors before they are encountered
deeper within a package. For example, if one knows that `f(u0,p)` will error unless `u0` is the size of `p`, this
should be caught at the start of the function to throw a domain specific error, for example "parameters and initial
condition should be the same size".

This contextualization should result in error messages that use terminology related to the user facing API (vs.
referencing internal implementation details).  Ideally, such error messages should not only describe the
issue in language that will be familiar to the user but also include suggestions, where possible, of how
to correct the issue.

### Subpackaging and interface packages is preferred over conditional modules via Requires.jl

Requires.jl should be avoided at all costs. If an interface package exists, such as
[ChainRulesCore.jl](https://github.com/JuliaDiff/ChainRulesCore.jl) for defining automatic differentiation
rules without requiring a dependency on the whole ChainRules.jl system, or
[RecipesBase.jl](https://github.com/JuliaPlots/RecipesBase.jl) which allows for defining Plots.jl
plot recipes without a dependency on Plots.jl, a direct dependency on these interface packages is
preferred.

Otherwise, instead of resorting to a conditional dependency using Requires.jl, it is
preferred to create subpackages, i.e. smaller independent packages kept within the same Github repository
with independent versioning and package management. An example of this is seen in
[Optimization.jl](https://github.com/SciML/Optimization.jl) which has subpackages like
[OptimizationBBO.jl](https://github.com/SciML/Optimization.jl/tree/master/lib/OptimizationBBO) for
BlackBoxOptim.jl support.

Some important interface packages to know about are:

- [ChainRulesCore.jl](https://github.com/JuliaDiff/ChainRulesCore.jl)
- [RecipesBase.jl](https://github.com/JuliaPlots/RecipesBase.jl)
- [ArrayInterface.jl](https://github.com/JuliaArrays/ArrayInterface.jl)
- [CommonSolve.jl](https://github.com/SciML/CommonSolve.jl)
- [SciMLBase.jl](https://github.com/SciML/SciMLBase.jl)

### Functions should either attempt to be non-allocating and reuse caches, or treat inputs as immutable

Mutating codes and non-mutating codes fall into different worlds. When a code is fully immutable,
the compiler can better reason about dependencies, optimize the code, and check for correctness.
However, many times a code that makes the fullest use of mutation can outperform even what the best compilers
of today can generate. That said, the worst of all worlds is when code mixes mutation with non-mutating
code. Not only is this a mishmash of coding styles, but it also has the potential non-locality and compiler
proof issues of mutating code while not fully benefiting from the mutation.

### Out-Of-Place and Immutability is preferred when sufficient performant

Mutation is used to get more performance by decreasing the number of heap allocations. However,
if it's not helpful for heap allocations in a given spot, do not use mutation. Mutation is scary
and should be avoided unless it gives an immediate benefit. For example, if
matrices are sufficiently large, then `A*B` is as fast as `mul!(C,A,B)`, and thus writing
`A*B` is preferred (unless the rest of the function is being careful about being fully non-allocating,
in which case this should be `mul!` for consistency).

Similarly, when defining types, using `struct` is preferred to `mutable struct` unless mutating
the struct is a common occurrence. Even if mutating the struct is a common occurrence, see whether
using [Setfield.jl](https://github.com/jw3126/Setfield.jl) is sufficient. The compiler will optimize
the construction of immutable structs, and thus this can be more efficient if it's not too much of a
code hassle.

### Tests should attempt to cover a wide gamut of input types

Code coverage numbers are meaningless if one does not consider the input types. For example, one can
hit all the code with `Array`, but that does not test whether `CuArray` is compatible! Thus it's
always good to think of coverage not in terms of lines of code but in terms of type coverage. A good
list of number types to think about are:

- `Float64`
- `Float32`
- `Complex`
- [`Dual`](https://github.com/JuliaDiff/ForwardDiff.jl)
- `BigFloat`

Array types to think about testing are:

- `Array`
- [`OffsetArray`](https://github.com/JuliaArrays/OffsetArrays.jl)
- [`CuArray`](https://github.com/JuliaGPU/CUDA.jl)

### When in doubt, a submodule should become a subpackage or separate package

Keep packages focused on one core idea. If there's something separate enough to be a submodule, could it
instead be a separate, well-tested and documented package to be used by other packages? Most likely
yes.

### Globals should be avoided whenever possible

Global variables should be avoided whenever possible. When required, global variables should be
constants and have an all uppercase name separated with underscores (e.g. `MY_CONSTANT`). They should be
defined at the top of the file, immediately after imports and exports but before an `__init__` function.
If you truly want mutable global style behavior you may want to look into mutable containers.

### Type-stable and Type-grounded code is preferred wherever possible

Type-stable and type-grounded code helps the compiler create not only more optimized code, but also
faster to compile code. Always keep containers well-typed, functions specializing on the appropriate
arguments, and types concrete.

### Closures should be avoided whenever possible

Closures can cause accidental type instabilities that are difficult to track down and debug; in the
long run, it saves time to always program defensively and avoid writing closures in the first place,
even when a particular closure would not have been problematic. A similar argument applies to reading
code with closures; if someone is looking for type instabilities, this is faster to do when code does
not contain closures.
Furthermore, if you want to update variables in an outer scope, do so explicitly with `Ref`s or self
defined structs.
For example,
```julia
map(Base.Fix2(getindex, i), vector_of_vectors)
```
is preferred over
```julia
map(v -> v[i], vector_of_vectors)
```
or
```julia
[v[i] for v in vector_of_vectors]
```

### Numerical functionality should use the appropriate generic numerical interfaces

While you can use `A\b` to do a linear solve inside a package, that does not mean that you should.
This interface is only sufficient for performing factorizations, and so that limits the scaling
choices, the types of `A` that can be supported, etc. Instead, linear solves within packages should
use LinearSolve.jl. Similarly, nonlinear solves should use NonlinearSolve.jl. Optimization should use
Optimization.jl. Etc. This allows the full generic choice to be given to the user without depending
on every solver package (effectively recreating the generic interfaces within each package).

### Functions should capture one underlying principle

Functions mean one thing. Every dispatch of `+` should be "the meaning of addition on these types".
While in theory you could add dispatches to `+` that mean something different, that will fail in
generic code for which `+` means addition. Thus, for generic code to work, code needs to adhere to
one meaning for each function. Every dispatch should be an instantiation of that meaning.

### Internal choices should be exposed as options whenever possible

Whenever possible, numerical values and choices within scripts should be exposed as options
to the user. This promotes code reusability beyond the few cases the author may have expected.

### Prefer code reuse over rewrites whenever possible

If a package has a function you need, use the package. Add a dependency if you need to. If the
function is missing a feature, prefer to add that feature to said package and then add it as a
dependency. If the dependency is potentially troublesome, for example because it has a high
load time, prefer to spend time helping said package fix these issues and add the dependency.
Only when it does not seem possible to make the package "good enough" should using the package
be abandoned. If it is abandoned, consider building a new package for this functionality as you
need it, and then make it a dependency.

### Prefer to not shadow functions

Two functions can have the same name in Julia by having different namespaces. For example,
`X.f` and `Y.f` can be two different functions, with different dispatches, but the same name.
This should be avoided whenever possible. Instead of creating `MyPackage.sort`, consider
adding dispatches to `Base.sort` for your types if these new dispatches match the underlying
principle of the function. If it doesn't, prefer to use a different name. While using `MyPackage.sort`
is not conflicting, it is going to be confusing for most people unfamiliar with your code,
so `MyPackage.special_sort` would be more helpful to newcomers reading the code.

### Avoid unmaintained dependencies

Packages should only be depended on if they have maintainers who are responsive. Good code requires
good communities. If maintainers do not respond to breakage within 2 weeks with multiple notices,
then all dependencies from that organization should be considered for removal. Note that some issues 
may take a long time to fix, so it may take more time than 2 weeks to fix, it's simply that the 
communication should be open, consistent, and timely. 

### Avoid unsafe operations

Like other high-level languages that provide strong safety guarantees by default, Julia nevertheless has a small 
set of operations that bypass normal checks. These operations are clearly marked with the prefix unsafe_. By using an 
“unsafe” operation, the programmer asserts that they know the operation is valid even though the language cannot 
automatically ensure it. For high reliability these constructs should be avoided or carefully inspected during code 
review. They are:

* unsafe_load 
* unsafe_store! 
* unsafe_read 
* unsafe_write 
* unsafe_string 
* unsafe_wrap
* unsafe_convert
* unsafe_copyto! 
* unsafe_pointer_to_objref 
* ccall 
* @ccall 
* @inbounds

### Avoid non public operations in Julia Base and packages

The Julia standard library and packages developed in the Julia programming language have an intended public API indicated by 
marking symbols with the export keyword or [in v1.11+ with the new `public` keyword](https://github.com/JuliaLang/julia/pull/50105). 
However, it is possible to use non public names via explicit qualification, e.g. Base.foobar. This practice is not necessarily unsafe, 
but should be avoided since non public operations may have unexpected invariants and behaviors, and are subject to changes in future 
releases of the language.

Note that qualified names are commonly used in method definitions to clarify that a function is being extended, e.g. function Base.getindex(...) … end. 
Such uses do not fall under this concern.

### Always default to constructs which initialize data

For certain newly-allocated data structures, such as numeric arrays, the Julia compiler and runtime do not check whether data is accessed before it has been 
initialized. Therefore such data structures can “leak” information from one part of a program to another. Uninitialized structures should be avoided in favor 
of functions like `zeros` and `fill` that create data with well-defined contents. If code does allocate uninitialized memory, it should ensure that this memory 
is fully initialized before being returned from the function in which it is allocated.

Constructs which create uninitialized memory should only be used if there is a demonstrated performance impact and it should ensure that all memory is initialized
in the same function in which the array is intended to be used.

Example:

```julia
function make_array(n::Int)
    A = Vector{Int}(undef, n)
    # function body
    return A
end
```

This function allocates an integer array with undefined initial contents (note the language forces you to request this explicitly). 
A code reviewer should ensure that the function body assigns every element of the array.
One can similarly create structs with undefined fields, and if used this way, one should ensure all fields are initialized:

```julia
struct Foo
  x::Int
  Foo() = new()
end

julia> Foo().x
139736495677280
```

### Use extra precaution when running external processes

The Julia standard library contains a `run` function and other facilities for running external processes. Any program that does this 
is only as safe as the external process it runs. If this cannot be avoided, then best practices for using these features are:

1. Only run fixed, known executables, and do not derive the path of the executable to run from user input or other outside sources.
2. Make sure the executables used have also passed required audit procedures.
3. Make sure to handle process failure (non-zero exit code).
4. If possible, run external processes in a sandbox or “jail” environment with access only to what they need in terms of files, file handles and ports.

When run in a sandbox or jail, external processes can actually improve security since the subprocess is isolated from the rest of the system by the kernel.

### Avoid eval whenever possible

Julia contains an `eval` function that executes program expressions constructed at run time. This is not in itself unsafe, but because the code it will run 
is not textually evident in the surrounding program, it can be difficult to determine what it will do. For example, a Julia program could construct and eval 
an expression that performs an unsafe operation without the operation being clearly evident to a code reviewer or analysis tool.

In general, programs should try to avoid using eval in ways that are influenced by user input because there are many subtle ways this can lead to arbitrary code 
execution. If user input must influence eval, the input should only be used to select from a known list of possible behaviors. Approaches using pattern matching 
to try to validate expressions should be viewed with extreme suspicion because they tend to be brittle and/or exploitable.

Note: it is common for Julia programs to invoke `eval` or `@eval` at the top level, in order to generate global definitions programmatically. Such uses are generally safe.

### Avoid bounds check removal, and if done, add appropriate manual checks

While Julia checks the bounds of all array operations by default, it is possible to manually disable bounds checks in a program using @inbounds.
Note that in early versions of Julia (pre v1.9) this could be used as a performance optimization, but in later versions it can demonstrably
reduce performance and thus one should never immediately default to bounds check removal as a performance habit.

Uses of this construct should be carefully audited during code review. For maximum safety, it should be avoided or programs should be run with the 
command line option --check-bounds=yes to enable all checks regardless of manual annotations.

To check a use of @inbounds for correctness, it suffices to examine all array indexing expressions (e.g. a[i]) within the expression it applies to, 
and ensure that each index will always be within the bounds of the indexed array. For example the following common use pattern is valid:

```julia
@inbounds for i in eachindex(A)
    A[i] = i
end
```

By inspection, the variable `i` will always be a valid index for `A`.

For contrast, the following use is invalid unless A is known to be a specific type (eg: `Vector`)

```julia
@inbounds for i in 1:length(A)
    A[i] = i
end
```

`@inbounds` should be applied to as narrow a region of code as possible. When applied to a large block of code, it can be difficult to identify 
and verify all indexing expressions.

### Avoid ccall unless necessary, and use safe ccall practices when required

Calling C (and Fortran) libraries from Julia is very easy: the ccall syntax (and the more convenient @ccall macro) allow calling C libraries 
without any need for glue files or boilerplate. They do require caution, however: the programmer tells Julia what the signature of each library 
function is and if this is not done correctly, it can be the cause of crashes and thus security vulnerabilities. An exploit is just a crash that 
an attacker has arranged to fail in a worse way than it would have randomly.

Safe use of ccall depends on both automated and manual measures.

What Julia does (automated):

* Julia provides aliases for C types like Cint, Clong, Cchar, Csize_t, etc. It makes sure that these match what the C ABI on the machine that code is running on expects them to be. 
* The Clang.jl package automates the process of turning C header files into valid ccall invocations.
* Pkg+BinaryBuilder.jl allows precise versioning of binary dependencies.
* Julia objects passed directly to ccall are protected from garbage collection (GC) for the duration of the call.

What you must do (manual):
* When writing ccall signatures, programmers should always look at the signature in the C header file and make sure the signature used in Julia matches exactly.
* Use Julia’s C type aliases. For example, if an argument in C is of type int then the corresponding type in Julia is Cint, not Int — on most platforms Int will be the same size as Clong rather than Cint.
* If a raw pointer to memory managed by Julia’s GC is passed to C via ccall, the owning object must be preserved using GC.@preserve around the use of ccall. See the documentation of this macro for more information and examples of proper usage.

### Validate all user inputs to avoid code injection

When writing programs that construct any kind of code based on user input, extra caution is required and the user input must be validated or escaped. 
For example, a common type of attack in web applications written in all programming languages is SQL injection: a user input is spliced into an SQL 
query to construct a customized query based on the user’s input. If raw user input is spliced into an SQL query as a string, it is easy to craft 
inputs that will execute arbitrary SQL commands, including destructive ones or ones that will reveal private data to an attacker. To prevent this, 
the user input should be passed as parameters to SQL prepared statements; a package such as SqlStrings.jl can be used to do this without a syntax burden. 
This protects against malicious input, but also encourages systematic marshaling of Julia types into SQL types. If string interpolation must be used, 
all user input should be either validated to match a strict, safe pattern (e.g. only consists of decimal digits or ASCII letters), or it should be 
escaped to ensure that SQL treats it only as data, not as code (e.g. turn a user input into an escaped string literal).

While we have talked specifically about SQL here, this issue is not limited to SQL. The same concern occurs when executing programs via shells, for example. 
Julia is more secure than most programming languages in this respect because the default mechanism for running external code (see Cmd objects in the Julia manual) 
is carefully designed to not be susceptible to this kind of injection, but programmers may be tempted to use a shell to call external code for convenience sake. 
The fact that a shell must be explicitly invoked in Julia helps catch these kinds of circumstances. Using a shell like this is usually a bad idea and can typically 
be avoided. If an external shell must be used, be certain that any user data used to construct the shell command is carefully validated or escaped to avoid shell 
injection attacks.

## Ensure secure random number generators are used when required

The default pseudo-random number generator in Julia, which can be accessed by calling `rand()` and `randn()`, for example, is intended for simulation purposes and 
not for applications requiring cryptographic security. An attacker can, by observing a series of random values, construct its internal state and predict future pseudo-random values. 
For security-sensitive applications like generating secret values used for authentication, the `RandomDevice()` random-number generator should be used. This produces genuinely 
random numbers which cannot be predicted.

### Be aware of distributed computing encryption principles

Julia’s distributed computing uses unencrypted TCP/IP sockets for communication by default and expects to be running on a fully trusted cluster. If `using Distributed` in your code through 
`@distributed`, `pmap`, etc., be aware that the communication channels are not encrypted. Julia opens ports for communication between processes in a distributed cluster. A pre-generated 
random cookie is necessary to successfully connect (Julia 0.5 onwards), which defeats arbitrary external connections. This mechanism is described in detail in https://github.com/JuliaLang/julia/pull/16292.

For additional security, these communication channels can be encrypted through the use of a custom ClusterManager which enables SSH port forwarding, or uses some other mechanism to encrypt the communication channel.

### Always immediately flush secret data after handling

When it’s necessary to manage secret data (for example, a user’s password) it’s desirable to have this erased from memory immediately after finishing with the data. However, when a normal `String` or `Array` is used as 
a container for such data, the underlying bytes persist after the container is deallocated and in principle could be recovered by an attacker at a later time. There are also situations where a string or array may be 
implicitly copied, for example, if it is assigned to a location with a compatible but different type, it will be converted, thus creating a copy of the original data. Normally this is harmless and convenient, but 
making copies of secrets is obviously bad for security. To prevent this, Julia provides the type `Base.SecretBuffer` and a `shred!` function which should be called immediately after the data is finished with. 
The contents of a `SecretBuffer` must be explicitly extracted — it is never implicitly copied — and its contents will be automatically shredded upon garbage collection of the `SecretBuffer` object if the `shred!` 
function was never called on it, with a warning indicating that the buffer should have been explicitly shredded by the programmer.

## Specific Rules

### High Level Rules

- Use 4 spaces per indentation level, no tabs.
- Try to adhere to a 92 character line length limit.

### General Naming Principles

- All type names should be `CamelCase`.
- All struct names should be `CamelCase`.
- All module names should be `CamelCase`.
- All function names should be `snake_case` (all lowercase).
- All variable names should be `snake_case` (all lowercase).
- All constant names should be `SNAKE_CASE` (all uppercase).
- All abstract type names should begin with `Abstract`.
- All type variable names should be a single capital letter, preferably related to the value being typed.
- Whole words are usually better than abbreviations or single letters.
- Variables meant to be internal or private to a package should be denoted by prepending two underscores, i.e. `__`.
- Single letters can be okay when naming a mathematical entity, i.e. an entity whose purpose or non-mathematical "meaning" is likely only known by downstream callers. For example, `a` and `b` would be appropriate names when implementing `*(a::AbstractMatrix, b::AbstractMatrix)`, since the "meaning" of those arguments (beyond their mathematical meaning as matrices, which is already described by the type) is only known by the caller.
- Unicode is fine within code where it increases legibility, but in no case should Unicode be used in public APIs.
  This is to allow support for terminals that cannot use Unicode: if a keyword argument must be η, then it can be
  exclusionary to uses on clusters which do not support Unicode inputs.

### Comments

- `TODO` to mark todo comments and `XXX` to mark comments about currently broken code
- Quote code in comments using backticks (e.g. `` `variable_name` ``).
- When possible, code should be changed to incorporate information that would have been in
  a comment. For example, instead of commenting `# fx applies the effects to a tree`, simply
  change the function and variable names `apply_effects(tree)`.
- Comments referring to Github issues and PRs should add the URL in the comments.
  Only use inline comments if they fit within the line length limit. If your comment
  cannot be fitted inline, then place the comment above the content to which it refers:

```julia
# Yes:

# Number of nodes to predict. Again, an issue with the workflow order. Should be updated
# after data is fetched.
p = 1

# No:

p = 1  # Number of nodes to predict. Again, an issue with the workflow order. Should be
# updated after data is fetched.
```

- In general, comments above a line of code or function are preferred to inline comments.

### Modules

- Module imports should occur at the top of a file or right after a `module` declaration.
- Module imports in packages should either use `import` or explicitly declare the imported functionality, for example
  `using Dates: Year, Month, Week, Day, Hour, Minute, Second, Millisecond`.
- Import and using statements should be separated, and should be divided by a blank line.

```julia
# Yes:
import A: a
import C

using B
using D: d

# No:
import A: a
using B
import C
using D: d
```

- Large sets of imports are preferred to be written in space filling lines separated by commas.

```julia
# Yes:
using A, B, C, D

# No:
using A
using B
using C
using D

# No:
using A,
      B,
      C,
      D
```

- Exported variables should be considered part of the public API, and changing their interface constitutes a
  breaking change.
- Any exported variables should be sufficiently unique. I.e., do not export `f` as that is very likely to clash with
  something else.
- A file that includes the definition of a module, should not include any other code that runs outside that module.
  i.e. the module should be declared at the top of the file with the `module` keyword and `end` at the bottom of the file.
  No other code before, or after (except for module docstring before).
  In this case, the code within the module block should **not** be indented.
- Sometimes, e.g. for tests, or for namespacing an enumeration, it *is* desirable to declare a submodule midway through a file.
  In this case, the code within the submodule **should** be indented.

### Functions

- Only use short-form function definitions when they fit on a single line:

```julia
# Yes:
foo(x::Int64) = abs(x) + 3

# No:
foobar(array_data::AbstractArray{T}, item::T) where {T <: Int64} = T[
    abs(x) * abs(item) + 3 for x in array_data
]
```

- Inputs should be required unless a default is historically expected or likely to be applicable to >95% of use cases.
  For example, the tolerance of a differential equation solver was set to a default of `abstol=1e-6,reltol=1e-3` as a
  generally correct plot in most cases, and is an expectation from back in the 90's. In that case, using the historically
  expected and most often useful default tolerances is justified. However, if one implements `GradientDescent`, the learning
  rate needs to be adjusted for each application (based on the size of the gradient), and thus a default of
  `GradientDescent(learning_rate = 1)` is not recommended.
- Arguments that do not have defaults should preferably be made into positional arguments. The newer syntax of required
  keyword arguments can be useful, but should not be abused. Notable exceptions are cases where "either or" arguments are
  accepted, for example, if defining `g` or `dgdu` is sufficient, then making them both keyword arguments with `= nothing`
  and checking that either is not `nothing` (and throwing an appropriate error) is recommended if distinct dispatches with
  different types is not possible. 
- When calling a function, always separate your keyword arguments from your positional arguments with a semicolon.
  This avoids mistakes in ambiguous cases (such as splatting a Dict).
- When writing a function that sends a lot of keyword arguments to another function, say sending keyword arguments to a
  differential equation solver, use a named tuple keyword argument instead of splatting the keyword arguments. For example,
  use `diffeq_solver_kwargs = (; abstol=1e-6, reltol=1e-6,)` as the API and use `solve(prob, alg; diffeq_solver_kwargs...)`
  instead of splatting all keyword arguments.
- Functions that mutate arguments should be appended with `!`.
- [Avoid type piracy](https://docs.julialang.org/en/v1/manual/style-guide/#Avoid-type-piracy). I.e., do not add methods
  to functions you don't own on types you don't own. Either own the types or the function.
- Functions should prefer instances instead of types for arguments. For example, for a solver type `Tsit5`, the interface
  should use `solve(prob,Tsit5())`, not `solve(prob,Tsit5)`. The reason for this is multifold. For one, passing a type
  has different specialization rules, so functionality can be slower unless `::Type{Tsit5}` is written in the dispatches
  that use it. Secondly, this allows for default and keyword arguments to extend the choices, which may become useful
  for some types down the line. Using this form allows for adding more options in a non-breaking manner.
- If the number of arguments is too large to fit into a 92 character line, then use as many arguments as possible within
  a line and start each new row with the same indentation, preferably at the same column as the `(` but this can be moved
  left if the function name is very long. For example:

```julia
# Yes
function my_large_function(argument1, argument2,
                           argument3, argument4,
                           argument5, x, y, z)

# No
function my_large_function(argument1,
                           argument2,
                           argument3,
                           argument4,
                           argument5,
                           x,
                           y,
                           z)
```


### Function Argument Precedence

1. **Function argument**.
   Putting a function argument first permits the use of [`do`](https://docs.julialang.org/en/v1/base/base/#do) blocks for passing
   multiline anonymous functions.

2. **I/O stream**.
   Specifying the `IO` object first permits passing the function to functions such as
   [`sprint`](https://docs.julialang.org/en/v1/base/io-network/#Base.sprint), e.g. `sprint(show, x)`.

3. **Input being mutated**.
   For example, in [`fill!(x, v)`](https://docs.julialang.org/en/v1/base/arrays/#Base.fill!), `x` is the object being mutated and it
   appears before the value to be inserted into `x`.

4. **Type**.
   Passing a type typically means that the output will have the given type.
   In [`parse(Int, "1")`](https://docs.julialang.org/en/v1/base/numbers/#Base.parse), the type comes before the string to parse.
   There are many such examples where the type appears first, but it's useful to note that
   in [`read(io, String)`](https://docs.julialang.org/en/v1/base/io-network/#Base.read), the `IO` argument appears before the type, which is
   in keeping with the order outlined here.

5. **Input not being mutated**.
   In `fill!(x, v)`, `v` is *not* being mutated and it comes after `x`.

6. **Key**.
   For associative collections, this is the key of the key-value pair(s).
   For other indexed collections, this is the index.

7. **Value**.
   For associative collections, this is the value of the key-value pair(s).
   In cases like [`fill!(x, v)`](https://docs.julialang.org/en/v1/base/arrays/#Base.fill!), this is `v`.

8. **Everything else**.
   Any other arguments.

9. **Varargs**.
   This refers to arguments that can be listed indefinitely at the end of a function call.
   For example, in `Matrix{T}(undef, dims)`, the dimensions can be given as a
   [`Tuple`](https://docs.julialang.org/en/v1/base/base/#Core.Tuple), e.g. `Matrix{T}(undef, (1,2))`, or as [`Vararg`](https://docs.julialang.org/en/v1/base/base/#Core.Vararg)s,
   e.g. `Matrix{T}(undef, 1, 2)`.

10. **Keyword arguments**.
   In Julia keyword arguments have to come last anyway in function definitions; they're
   listed here for the sake of completeness.

The vast majority of functions will not take every kind of argument listed above; the
numbers merely denote the precedence that should be used for any applicable arguments
to a function.

### Tests and Continuous Integration

- The high level `runtests.jl` file should only be used to shuttle to other test files.
- Every set of tests should be included into a [`@safetestset`](https://github.com/YingboMa/SafeTestsets.jl).
  A standard `@testset` does not fully enclose all defined values, such as functions defined in a `@testset`, and
  thus can "leak".
- Test includes should be written in one line, for example:

```julia
@time @safetestset "Jacobian Tests" include("interface/jacobian_tests.jl")
```

- Every test script should be fully reproducible in isolation. I.e., one should be able to copy paste that script
  and receive the results.
- Test scripts should be grouped based on categories, for example tests of the interface vs tests for numerical
  convergence. Grouped tests should be kept in the same folder.
- A `GROUP` environment variable should be used to specify test groups for parallel testing in continuous integration.
  A fallback group `All` should be used to specify all the tests that should be run when a developer runs `]test Package`
  locally. As an example, see the
  [OrdinaryDiffEq.jl test structure](https://github.com/SciML/OrdinaryDiffEq.jl/blob/v6.10.0/test/runtests.jl)
- Tests should include downstream tests to major packages which use the functionality, to ensure continued support.
  Any update that breaks the downstream tests should follow with a notification to the downstream package of why the
  support was broken (preferably in the form of a PR that fixes support), and the package should be given a major
  version bump in the next release if the changed functionality was part of the public API.
- CI scripts should use the default settings unless required.
- CI scripts should test the Long-Term Support (LTS) release and the current stable release. Nightly tests are only
  necessary for packages with a heavy reliance on specific compiler details.
- Any package supporting GPUs should include continuous integration for GPUs.
- [Doctests](https://juliadocs.github.io/Documenter.jl/stable/man/doctests/) should be enabled except for the examples
  that are computationally-prohibitive to have as part of continuous integration.

### Whitespace

- Avoid extraneous whitespace immediately inside parentheses, square brackets or braces.

    ```julia
    # Yes:
    spam(ham[1], [eggs])

    # No:
    spam( ham[ 1 ], [ eggs ] )
    ```

- Avoid extraneous whitespace immediately before a comma or semicolon:

    ```julia
    # Yes:
    if x == 4 @show(x, y); x, y = y, x end

    # No:
    if x == 4 @show(x , y) ; x , y = y , x end
    ```

- Avoid whitespace around `:` in ranges. Use brackets to clarify expressions on either side.

    ```julia
    # Yes:
    ham[1:9]
    ham[9:-3:0]
    ham[1:step:end]
    ham[lower:upper-1]
    ham[lower:upper - 1]
    ham[lower:(upper + offset)]
    ham[(lower + offset):(upper + offset)]

    # No:
    ham[1: 9]
    ham[9 : -3: 1]
    ham[lower : upper - 1]
    ham[lower + offset:upper + offset]  # Avoid as it is easy to read as `ham[lower + (offset:upper) + offset]`
    ```

- Avoid using more than one space around an assignment (or other) operator to align it with another:

    ```julia
    # Yes:
    x = 1
    y = 2
    long_variable = 3

    # No:
    x             = 1
    y             = 2
    long_variable = 3
    ```

- Surround most binary operators with a single space on either side: assignment (`=`), [updating operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Updating-operators-1) (`+=`, `-=`, etc.), [numeric comparisons operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Numeric-Comparisons-1) (`==`, `<`, `>`, `!=`, etc.), [lambda operator](https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions-1) (`->`). Binary operators may be excluded from this guideline include: the [range operator](https://docs.julialang.org/en/v1/base/math/#Base.::) (`:`), [rational operator](https://docs.julialang.org/en/v1/base/math/#Base.://) (`//`), [exponentiation operator](https://docs.julialang.org/en/v1/base/math/#Base.:^-Tuple{Number,%20Number}) (`^`), [optional arguments/keywords](https://docs.julialang.org/en/v1/manual/functions/#Optional-Arguments-1) (e.g. `f(x = 1; y = 2)`).

    ```julia
    # Yes:
    i = j + 1
    submitted += 1
    x^2 < y

    # No:
    i=j+1
    submitted +=1
    x^2<y
    ```

- Avoid using whitespace between unary operands and the expression:

    ```julia
    # Yes:
    -1
    [1 0 -1]

    # No:
    - 1
    [1 0 - 1]  # Note: evaluates to `[1 -1]`
    ```

- Avoid extraneous empty lines. Avoid empty lines between single line method definitions
    and otherwise separate functions with one empty line, plus a comment if required:

    ```julia
    # Yes:
    # Note: an empty line before the first long-form `domaths` method is optional.
    domaths(x::Number) = x + 5
    domaths(x::Int) = x + 10
    function domaths(x::String)
        return "A string is a one-dimensional extended object postulated in string theory."
    end

    dophilosophy() = "Why?"

    # No:
    domath(x::Number) = x + 5

    domath(x::Int) = x + 10



    function domath(x::String)
        return "A string is a one-dimensional extended object postulated in string theory."
    end


    dophilosophy() = "Why?"
    ```

- Function calls that cannot fit on a single line within the line limit should be broken up such that the lines containing the opening and closing brackets are indented to the same level while the parameters of the function are indented one level further.
  In most cases, the arguments and/or keywords should each be placed on separate lines.
  Note that this rule conflicts with the typical Julia convention of indenting the next line to align with the open bracket in which the parameter is contained.
  If working in a package with a different convention, follow the convention used in the package over using this guideline.

    ```julia
    # Yes:
    f(a, b)
    constraint = conic_form!(SOCElemConstraint(temp2 + temp3, temp2 - temp3, 2 * temp1),
                             unique_conic_forms)

    # No:
    # Note: `f` call is short enough to be on a single line
    f(
        a,
        b,
    )
    constraint = conic_form!(SOCElemConstraint(temp2 + temp3,
                                               temp2 - temp3, 2 * temp1),
                             unique_conic_forms)
    ```

- Group similar one line statements together.

    ```julia
    # Yes:
    foo = 1
    bar = 2
    baz = 3

    # No:
    foo = 1

    bar = 2

    baz = 3
    ```

- Use blank-lines to separate different multi-line blocks.

    ```julia
    # Yes:
    if foo
        println("Hi")
    end

    for i in 1:10
        println(i)
    end

    # No:
    if foo
        println("Hi")
    end
    for i in 1:10
        println(i)
    end
    ```
- After a function definition, and before an end statement do not include a blank line.

    ```julia
    # Yes:
    function foo(bar::Int64, baz::Int64)
        return bar + baz
    end

    # No:
    function foo(bar::Int64, baz::Int64)

        return bar + baz
    end

    # No:
    function foo(bar::In64, baz::Int64)
        return bar + baz

    end
    ```

- Use line breaks between control flow statements and returns.

    ```julia
    # Yes:
    function foo(bar; verbose = false)
        if verbose
            println("baz")
        end

        return bar
    end

    # Ok:
    function foo(bar; verbose = false)
        if verbose
            println("baz")
        end
        return bar
    end
    ```

### NamedTuples

The `=` character in `NamedTuple`s should be spaced as in keyword arguments.
Space should be put between the name and its value.
The empty `NamedTuple` should be written `NamedTuple()` not `(;)`

```julia
# Yes:
xy = (x = 1, y = 2)
x = (x = 1,)  # Trailing comma required for correctness.
x = (; kwargs...)  # Semicolon required to splat correctly.

# No:
xy = (x=1, y=2)
xy = (;x=1,y=2)
```

### Numbers

- Floating-point numbers should always include a leading and/or trailing zero:

```julia
# Yes:
0.1
2.0
3.0f0

# No:
.1
2.
3.f0
```

- Always prefer the type `Int` to `Int32` or `Int64` unless one has a specific reason
  to choose the bit size.

### Ternary Operator

Ternary operators (`?:`) should generally only consume a single line.
Do not chain multiple ternary operators.
If chaining many conditions, consider using an `if`-`elseif`-`else` conditional, dispatch, or a dictionary.

```julia
# Yes:
foobar = foo == 2 ? bar : baz

# No:
foobar = foo == 2 ?
    bar :
    baz
foobar = foo == 2 ? bar : foo == 3 ? qux : baz
```

As an alternative, you can use a compound boolean expression:

```julia
# Yes:
foobar = if foo == 2
    bar
else
    baz
end

foobar = if foo == 2
    bar
elseif foo == 3
    qux
else
    baz
end
```

### For loops

For loops should always use `in`, never `=` or `∈`.
This also applies to list and generator comprehensions

```julia
# Yes
for i in 1:10
    #...
end

[foo(x) for x in xs]

# No:
for i = 1:10
    #...
end

[foo(x) for x ∈ xs]
```

### Function Type Annotations

Annotations for function definitions should be as general as possible.

```julia
# Yes:
splicer(arr::AbstractArray, step::Integer) = arr[begin:step:end]

# No:
splicer(arr::Array{Int}, step::Int) = arr[begin:step:end]
```

Using as many generic types as possible allows for a variety of inputs and allows your code to be more general:

```julia
julia> splicer(1:10, 2)
1:2:9

julia> splicer([3.0, 5, 7, 9], 2)
2-element Array{Float64,1}:
 3.0
 7.0
```

### Struct Type Annotations

Annotations on type fields need to be given a little more thought, since field access is not concrete unless
the compiler can infer the type (see [type-dispatch design](https://www.stochasticlifestyle.com/type-dispatch-design-post-object-oriented-programming-julia/) for details). Since well-inferred code is
preferred, abstract type annotations, i.e.

```julia
mutable struct MySubString <: AbstractString
    string::AbstractString
    offset::Integer
    endof::Integer
end
```

are not recommended. Instead a concretely-typed struct:

```julia
mutable struct MySubString <: AbstractString
    string::String
    offset::Int
    endof::Int
end
```

is preferred. If generality is required, then parametric typing is preferred, i.e.:

```julia
mutable struct MySubString{T<:Integer} <: AbstractString
    string::String
    offset::T
    endof::T
end
```

Untyped fields should be explicitly typed `Any`, i.e.:

```julia
struct StructA
    a::Any
end
```

### Macros

- Do not add spaces between assignments when there are multiple assignments.

```julia
Yes:
@parameters a = b
@parameters a=b c=d

No:
@parameters a = b c = d
```

### Types and Type Annotations

- Avoid elaborate union types. `Vector{Union{Int,AbstractString,Tuple,Array}}` should probably
  be `Vector{Any}`. This will reduce the amount of extra strain on compilation checking many
  branches.
- Unions should be kept to two or three types only for branch splitting. Unions of three types
  should be kept to a minimum for compile times.
- Do not use `===` to compare types. Use `isa` or `<:` instead.

### Package version specifications

- Use [Semantic Versioning](https://semver.org/)
- For simplicity, avoid including the default caret specifier when specifying package version requirements.

```julia
# Yes:
DataFrames = "0.17"

# No:
DataFrames = "^0.17"
```

- For accuracy, do not use constructs like `>=` to avoid upper bounds.
- Every dependency should have a bound.
- All packages should use [CompatHelper](https://github.com/JuliaRegistries/CompatHelper.jl) and attempt to
  stay up to date with the dependencies.
- The lower bound on dependencies should be the last tested version.

### Documentation

- Documentation should always attempt to be at the highest level possible. I.e., documentation of an interface that
  all methods follow is preferred to documenting every method, and documenting the interface of an abstract type is
  preferred to documenting all the subtypes individually. All instances should then refer to the higher level
  documentation.
- Documentation should use [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/).
- Tutorials should come before reference materials.
- Every package should have a starting tutorial that covers "the 90% use case", i.e. the ways that most people will
  want to use the package.
- The tutorial should show a complete workflow and be opinionated about said workflow. For example, when writing a tutorial
  about a simulator, pick a plotting package and show how to plot it.
- Variable names in tutorials are important. If you use `u0`, then all other codes will copy that naming scheme.
  Show potential users the right way to use your code with the right naming.
- When applicable, tutorials on how to use the "high performance advanced features" should be separated from the beginning tutorial.
- All documentation should summarize the contents before going into specifics of API docstrings.
- Most modules, types and functions should have [docstrings](http://docs.julialang.org/en/v1/manual/documentation/).
- Prefer documenting accessor functions instead of fields when possible. Documented fields are part of the public API
  and changing their contents/name constitutes a breaking change.
- Only exported functions are required to be documented.
- Avoid documenting commonly overloaded methods, such as `==`.
- Try to document a function and not individual methods where possible, as typically all methods will have similar docstrings.
- If you are adding a method to a function that already has a docstring only add a docstring if the
  behavior of your function deviates from the existing docstring.
- Docstrings are written in [Markdown](https://en.wikipedia.org/wiki/Markdown) and should be concise.
- Docstring lines should be wrapped at 92 characters.

```julia
"""
    bar(x[, y])

Compute the Bar index between `x` and `y`. If `y` is missing, compute the Bar index between
all pairs of columns of `x`.
"""
function bar(x, y) ...
```

- It is recommended that you have a blank line between the headings and the content when the content is of sufficient length.
- Try to be consistent within a docstring whether you use this additional whitespace.
- Follow one of the following templates for types and functions when possible:

Type Template (should be skipped if it is redundant with the constructor(s) docstring):

```julia
"""
    MyArray{T, N}

My super awesome array wrapper!

# Fields
- `data::AbstractArray{T, N}`: stores the array being wrapped
- `metadata::Dict`: stores metadata about the array
"""
struct MyArray{T, N} <: AbstractArray{T, N}
    data::AbstractArray{T, N}
    metadata::Dict
end
```

Function Template (only required for exported functions):

```julia
"""
    mysearch(array::MyArray{T}, val::T; verbose = true) where {T} -> Int

Searches the `array` for the `val`. For some reason we don't want to use Julia's
builtin search :)

# Arguments
- `array::MyArray{T}`: the array to search
- `val::T`: the value to search for

# Keywords
- `verbose::Bool = true`: print out progress details

# Returns
- `Int`: the index where `val` is located in the `array`

# Throws
- `NotFoundError`: I guess we could throw an error if `val` isn't found.
"""
function mysearch(array::AbstractArray{T}, val::T) where {T}
    ...
end
```

- The `@doc doc""" """` formulation from the Markdown standard library should be used whenever
  there is LaTeX.
- Only public fields of types must be documented. Undocumented fields are considered non-public internals.
- If your method contains lots of arguments or keywords, you may want to exclude them from the method
  signature on the first line and instead use `args...` and/or `kwargs...`.

```julia
"""
    Manager(args...; kwargs...) -> Manager

A cluster manager which spawns workers.

# Arguments

- `min_workers::Integer`: The minimum number of workers to spawn or an exception is thrown
- `max_workers::Integer`: The requested number of workers to spawn

# Keywords

- `definition::AbstractString`: Name of the job definition to use. Defaults to the
    definition used within the current instance.
- `name::AbstractString`: ...
- `queue::AbstractString`: ...
"""
function Manager(...)
    ...
end
```

- Feel free to document multiple methods for a function within the same docstring. Be careful to only do this for functions you have defined.

```julia
"""
    Manager(max_workers; kwargs...)
    Manager(min_workers:max_workers; kwargs...)
    Manager(min_workers, max_workers; kwargs...)

A cluster manager which spawns workers.

# Arguments

- `min_workers::Int`: The minimum number of workers to spawn or an exception is thrown
- `max_workers::Int`: The requested number of workers to spawn

# Keywords

- `definition::AbstractString`: Name of the job definition to use. Defaults to the
    definition used within the current instance.
- `name::AbstractString`: ...
- `queue::AbstractString`: ...
"""
function Manager end

```

- If the documentation for bullet-point exceeds 92 characters, the line should be wrapped and slightly indented.
  Avoid aligning the text to the `:`.

```julia
"""
...

# Keywords
- `definition::AbstractString`: Name of the job definition to use. Defaults to the
    definition used within the current instance.
"""
```

### Error Handling

- `error("string")` should be avoided. Defining and throwing exception types is preferred. See the
  [manual on exceptions for more details](https://docs.julialang.org/en/v1/manual/control-flow/#Exception-Handling).
- Try to avoid `try/catch`. Use it as minimally as possible. Attempt to catch potential issues before running
  code, not after.

### Arrays

- Avoid splatting (`...`) whenever possible. Prefer iterators such as `collect`, `vcat`, `hcat`, etc. instead.

### Line Endings

Always use Unix style `\n` line ending.

### VS-Code Settings

If you are a user of VS Code we recommend that you have the following options in your Julia syntax specific settings.
To modify these settings, open your VS Code Settings with <kbd>CMD</kbd>+<kbd>,</kbd> (Mac OS) or <kbd>CTRL</kbd>+<kbd>,</kbd> (other OS), and add to your `settings.json`:

```json
{
    "[julia]": {
        "editor.detectIndentation": false,
        "editor.insertSpaces": true,
        "editor.tabSize": 4,
        "files.insertFinalNewline": true,
        "files.trimFinalNewlines": true,
        "files.trimTrailingWhitespace": true,
        "editor.rulers": [92],
        "files.eol": "\n"
    },
}
```
Additionally, you may find the [Julia VS-Code plugin](https://github.com/julia-vscode/julia-vscode) useful.

### JuliaFormatter

**Note: the** `sciml` **style is only available in** `JuliaFormatter v1.0` **or later**

One can add `.JuliaFormatter.toml` with the content
```toml
style = "sciml"
```
in the root of a repository, and run
```julia
using JuliaFormatter, SomePackage
format(joinpath(dirname(pathof(SomePackage)), ".."))
```
to format the package automatically.

Add [FormatCheck.yml](https://github.com/SciML/ModelingToolkit.jl/blob/master/.github/workflows/FormatCheck.yml) to enable the formatting CI. The CI will fail if the repository needs additional formatting. Thus, one should run `format` before committing.

# References

Many of these style choices were derived from the [Julia style guide](https://docs.julialang.org/en/v1/manual/style-guide/),
the [YASGuide](https://github.com/jrevels/YASGuide), and the [Blue style guide](https://github.com/invenia/BlueStyle#module-imports).
Additionally, many tips and requirements from the [JuliaHub Secure Coding Practices](https://juliahub.com/company/resources/white-papers/secure-julia-coding-practices/index.html)
manual were incorporated into this style.
