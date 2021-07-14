# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny:latest

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libmariadbd-dev \
    libpq-dev \
    libssh2-1-dev \
    unixodbc-dev \
    libcurl4-openssl-dev \
    libssl-dev \
	build-essential \
	zlib1g-dev \
	libncurses5-dev \
	libgdbm-dev \
	libnss3-dev \
	libssl-dev \
	libsqlite3-dev \
	libffi-dev \
	curl \
	libbz2-dev

# Python dependencies

# RUN curl -O 'https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz' && tar -xf Python-3.8.2.tar.xz && cd Python-3.8.2 && ./configure --enable-optimizations --enable-shared && make -j 4 && make install && cd -

# RUN export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
# ENV LD_LIBRARY_PATH="/usr/local/lib:${LD_LIBRARY_PATH}"

# RUN python3.8 -m ensurepip --upgrade

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# hadolint ignore=DL3008
RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        mercurial \
        openssh-client \
        subversion \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]

# Leave these args here to better use the Docker build cache
ARG CONDA_VERSION=py38_4.9.2

RUN set -x && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh"; \
        SHA256SUM="1314b90489f154602fd794accfc90446111514a5a72fe1f71ab83e07de9504a7"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-s390x.sh"; \
        SHA256SUM="4e6ace66b732170689fd2a7d86559f674f2de0a0a0fbaefd86ef597d52b89d16"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-aarch64.sh"; \
        SHA256SUM="b6fbba97d7cef35ebee8739536752cd8b8b414f88e237146b11ebf081c44618f"; \
    elif [ "${UNAME_M}" = "ppc64le" ]; then \
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-ppc64le.sh"; \
        SHA256SUM="2b111dab4b72a34c969188aa7a91eca927a034b14a87f725fa8d295955364e71"; \
    fi && \
    wget "${MINICONDA_URL}" -O miniconda.sh -q && \
    echo "${SHA256SUM} miniconda.sh" > shasum && \
    if [ "${CONDA_VERSION}" != "latest" ]; then sha256sum --check --status shasum; fi && \
    mkdir -p /opt && \
    sh miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

ENV PATH="/opt/conda/envs/r-reticulate/bin:${PATH}"

# RUN python3.8 -m pip install --no-cache-dir --upgrade pip && \
#    python3.8 -m pip install --no-cache-dir keras tensorflow
# copy necessary files
## app folder
COPY /CapstoneShiny ./app
COPY /Scripts ./Scripts
## renv.lock file
# COPY /CapstoneShiny/renv.lock ./renv.lock

# install renv & restore packages
RUN Rscript -e 'install.packages("reticulate")'
RUN Rscript -e 'reticulate::conda_create(envname = "r-reticulate")'
RUN Rscript -e 'reticulate::use_python("/opt/conda/envs/r-reticulate/bin/python3")'
RUN Rscript -e 'reticulate::use_condaenv("/opt/conda/envs/r-reticulate/")'
RUN Rscript -e 'install.packages("devtools")'
RUN Rscript -e 'install.packages("keras")'
RUN Rscript -e 'install.packages("tensorflow")'
RUN Rscript -e 'devtools::install_github("Ferryistaken/ezstocks")'

RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::consent(provided = TRUE)'
RUN Rscript -e 'renv::restore()'

RUN Rscript -e 'keras::install_keras(method = "conda", envname = "r-reticulate")'
RUN Rscript -e 'tensorflow::install_tensorflow(method = "conda", envname = "r-reticulate")'

RUN Rscript -e 'install.packages("dplyr")'
RUN Rscript -e 'install.packages("plyr")'

# expose port
EXPOSE 3838

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]
