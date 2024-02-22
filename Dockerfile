FROM jupyter/minimal-notebook
USER root

RUN curl -fsSL https://install.julialang.org | sh -s -- --yes && \
    ~/.juliaup/bin/juliaup update && \
    ~/.juliaup/bin/julia -e 'using Pkg; Pkg.add("IJulia"); precompile;' && \
    ~/.juliaup/bin/julia -e 'using IJulia; IJulia.installkernel("Julia", env=Dict("JULIA_NUM_THREADS"=>"'"$JULIA_NUM_THREADS"'"))'

CMD jupyter lab --ip=0.0.0.0 --allow-root --LabApp.token=''
