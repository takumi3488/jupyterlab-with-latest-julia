FROM python:3.12.4-bookworm

# Set environment variables
ENV TZ Asia/Tokyo

# Install JuptyerLab
RUN pip install jupyterlab

# Install Julia
RUN curl -fsSL https://install.julialang.org | sh -s -- --yes && \
    ~/.juliaup/bin/juliaup update && \
    ~/.juliaup/bin/julia -e 'using Pkg; Pkg.add("IJulia"); precompile;' && \
    ~/.juliaup/bin/julia -e 'using IJulia; IJulia.installkernel("Julia", env=Dict("JULIA_NUM_THREADS"=>"'"$JULIA_NUM_THREADS"'"))'

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Make work directory
RUN mkdir -p /work

CMD jupyter lab --ip=0.0.0.0 --allow-root --LabApp.token="$LAB_APP_TOKEN" --no-browser --notebook-dir="/work"
