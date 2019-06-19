using Distributed
using DelimitedFiles
using Printf

@everywhere using RAFF


# This script runs the parallel version of RAFF

"""

    run_praff()

Load and run the parallel/distributed version of RAFF. It assumes that
there is a problem file `/tmp/output.txt`.

"""
function run_praff(maxms=1, initguess=nothing)
    
    n, model, modelstr = RAFF.model_list["logistic"]

    open("/tmp/output.txt") do fp
        
        global N = parse(Int, readline(fp))
        
        global data = readdlm(fp)
        
    end

    if initguess == nothing

        initguess = zeros(Float64, n)

    end

    rsol = praff(model, data[:, 1:end - 1], n; MAXMS=maxms, initguess=initguess)
    
    @printf("Solution found:
            fbest = %f
            p     = %d\n", rsol.f, rsol.p)
    println(rsol.solution)

    return rsol

end