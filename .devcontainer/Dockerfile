# Dockerfile para uso com docker-compose local.
# O devcontainer.json usa image + features — NÃO referencia este arquivo.
FROM mcr.microsoft.com/devcontainers/dotnet:8.0-bookworm

# Atualizar pacotes e instalar dependências base
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    git \
    python3.11 \
    python3-pip \
    python3-venv \
    nodejs \
    npm \
    build-essential \
    curl \
    wget \
    jq \
    zip \
    unzip \
    nano \
    vim \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configurar Python 3.11 como padrão e instalar uv
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 \
    && pip3 install --no-cache-dir uv

# Verifica ferramentas base (o Specify CLI é instalado pelo post-create.sh)
RUN dotnet --version && python3 --version && node --version && npm --version && uv --version

WORKDIR /workspaces
CMD ["/bin/bash"]
