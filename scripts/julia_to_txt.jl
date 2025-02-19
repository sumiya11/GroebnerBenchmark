using AbstractAlgebra

function julia_to_txt(sys)
    R = parent(sys[1])
    k = base_ring(R)
    char = characteristic(k)
    vars = join(map(string, gens(R)), ", ")
    equations = join(map(string, sys), ",\n")
    """
    $vars
    $char
    $equations
    """
end

skip = ["siwr"]

ranges = Dict(
    "katsura" => 2:15,
    "cyclic" => 2:15,
    "noon" => 2:15,
    "eco" => 2:15
)

function generate_many_txt()
    prefix = (@__DIR__) * "/../systems"
    for dir in readdir(prefix)
        for file in readdir(prefix * "/" * dir)
            root = prefix * "/" * dir
            if endswith(file, ".txt")
                # rm(root * "/txt/" * file, recursive=true)
            end
            if endswith(file, ".jl")
                name = chopsuffix(file, ".jl")
                if name in skip
                    continue
                end
                mkpath(root * "/" * "txt")
                filepath = root * "/" * file
                @info "Reading $filepath"
                func = include(filepath)
                needs_n = false
                if haskey(ranges, chopsuffix(file, ".jl"))
                    range = ranges[chopsuffix(file, ".jl")]
                else
                    range = 5:5
                end
                for n in range
                    sys = nothing
                    try
                        sys = func()
                    catch e
                        if isa(e, MethodError)
                            try
                                sys = func(n)
                                needs_n = true
                            catch
                            end
                        else
                        end
                    end
                    sys === nothing && continue
                    txt = julia_to_txt(sys)
                    if needs_n
                        txt_filepath = root * "/txt/" * chopsuffix(file, ".jl") * "_$n" * ".txt"
                    else
                        txt_filepath = root * "/txt/" * chopsuffix(file, ".jl") * ".txt"
                    end
                    open(txt_filepath, "w") do fout
                        println("  Writing: $txt_filepath")
                        write(fout, txt)
                    end
                    !needs_n && break
                end
                if needs_n
                    print("$name:--------\n")
                    print(join(["[$(name)_$(n).txt](./systems/$(name)/txt/$(name)_$(n).txt)" for n in range], ", "))
                    print("\n--------\n")
                end
            end
        end
    end
end

generate_many_txt()
