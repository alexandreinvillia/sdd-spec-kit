# 🐳 Dev Container - GitHub Spec Kit RSS Reader

Este diretório contém a configuração do **Dev Container** para o projeto de Leitor de Feed RSS usando GitHub Spec Kit com ASP.NET Core e Blazor WebAssembly.

## 📋 O que é Dev Container?

Um Dev Container encapsula todo o ambiente de desenvolvimento em um container Docker. Isso garante que:

- ✅ Todos os desenvolvedores trabalhem no mesmo ambiente
- ✅ Nenhuma instalação local de dependências seja necessária
- ✅ A configuração seja reproduzível e versionada no Git
- ✅ O desenvolvimento seja isolado do sistema local

## 🚀 Início Rápido

### Opção A: GitHub Codespaces

1. Abra o repositório no Codespaces.
2. Aguarde a criação do ambiente.
3. O workspace será aberto automaticamente na pasta padrão do repositório em `/workspaces/<repositorio>`.
4. Valide o ambiente com `dotnet --version`, `uv --version` e `specify version`.

### Pré-requisitos

1. **Docker Desktop** instalado ([download](https://www.docker.com/products/docker-desktop))
2. **Visual Studio Code** instalado ([download](https://code.visualstudio.com/))
3. **Remote - Containers extension** para VS Code

### Instalando a Extensão Remote - Containers

1. Abra VS Code
2. Vá para a aba Extensions (Ctrl+Shift+X)
3. Procure por "Remote - Containers"
4. Instale a extensão `ms-vscode-remote.remote-containers`

### Abrindo o Projeto no Dev Container

#### Opção 1: Command Palette (Recomendado)

1. Abra a pasta do projeto em VS Code: `code .`
2. Pressione `Ctrl+Shift+P` (ou `Cmd+Shift+P` no macOS)
3. Digite: `Dev Containers: Reopen in Container`
4. Pressione Enter
5. Aguarde o container ser construído (primeira vez leva 3-5 minutos)

#### Opção 2: Prompt ao Abrir a Pasta

1. Abra a pasta em VS Code
2. Um prompt "Reopen in Container?" aparecerá
3. Clique em "Reopen in Container"

#### Opção 3: Command Line

```bash
# Clone e acesse o repositório
git clone <seu-repositorio>
cd github-spec-kit-starter

# Abra no VS Code com Dev Container
code . --profile devcontainer
```

## 📁 Estrutura dos Arquivos

```
.devcontainer/
├── Dockerfile              # Define a imagem Docker do container
├── devcontainer.json       # Configurações do VS Code Dev Container
├── post-create.sh          # Script executado após criar o container
└── WELCOME.txt             # Mensagem de boas-vindas
```

## 🛠️ Configurações Incluídas

### Dockerfile

- **Base Image**: `mcr.microsoft.com/devcontainers/dotnet:8.0-bookworm`
- **Ferramentas**: .NET SDK 8.0, Python 3.11, Node.js e Git
- **Pacotes**: uv, Specify CLI, build-essential e utilitários essenciais

### devcontainer.json

**Extensões instaladas automaticamente:**
- C# Dev Kit (`ms-dotnettools.csharp`)
- Blazor WebAssembly Companion (`ms-dotnettools.blazorwasm-companion`)
- GitHub Copilot + Chat
- GitLens, ESLint, Prettier
- E mais...

**Portas expostas:**
- `5000` - Backend API (HTTP)
- `5001` - Backend API (HTTPS)
- `7000` - Frontend Blazor (HTTP)
- `7001` - Frontend Blazor (HTTPS)

**Configurações VS Code:**
- Format on save (Prettier)
- Rulers em 80 e 120 caracteres
- Exclusões para bin/, obj/, node_modules/
- Analyzers Roslyn habilitados

### post-create.sh

Script executado automaticamente que:

1. ✓ Valida todas as ferramentas instaladas
2. ✓ Verifica/Instala Specify CLI
3. ✓ Cria diretório `StakeholderDocuments/`
4. ✓ Inicializa GitHub Spec Kit se necessário
5. ✓ Restaura dependências .NET
6. ✓ Configura Git (email/nome)
7. ✓ Atualiza .gitignore com padrões .NET

No Codespaces, o script também garante que a inicialização rode a partir da pasta correta do repositório e usa `specify init --here --force --ai copilot --script sh` para evitar prompts interativos durante o bootstrap.

## 🎯 Fluxo de Trabalho Típico

### 1. Primeira Vez - Inicializar o Projeto

```bash
# Dentro do container

# O GitHub Spec Kit já deve estar inicializado pelo post-create.sh
# Se não estiver:
specify init --here --force --ai copilot --script sh

# Gerar documentação com Spec Kit
/speckit.constitution
/speckit.spec
/speckit.plan
/speckit.tasks
```

### 2. Criar Projetos .NET

```bash
# Criar estrutura base
dotnet new globaljson --sdk-version 8.0.0
dotnet new solution -n RSSFeedReader

# Criar projetos
dotnet new webapi -n RSSFeedReader.Api -na RSSFeedReader.Api --no-https
dotnet new blazorwasm -n RSSFeedReader.UI -na RSSFeedReader.UI --no-https

# Adicionar à solução
dotnet sln add RSSFeedReader.Api/RSSFeedReader.Api.csproj
dotnet sln add RSSFeedReader.UI/RSSFeedReader.UI.csproj

# Restaurar dependências
dotnet restore
```

### 3. Desenvolvimento

**Terminal 1 - Backend:**
```bash
cd RSSFeedReader.Api
dotnet watch run
```

**Terminal 2 - Frontend:**
```bash
cd RSSFeedReader.UI
dotnet watch run
```

### 4. Acessar a Aplicação

- Frontend Blazor: http://localhost:7000
- Backend API: http://localhost:5000
- API Swagger: http://localhost:5000/swagger

## 📦 Usando Docker Compose (Alternativo)

Se preferir usar `docker-compose`:

```bash
# Construir e iniciar
docker-compose up -d --build

# Acessar o container
docker-compose exec dev-container bash

# Parar
docker-compose down
```

## 🔧 Personalizando o Dev Container

### Adicionar Extensões VS Code

Edite `.devcontainer/devcontainer.json` e adicione à lista `customizations.vscode.extensions`:

```json
"extensions": [
  "ms-dotnettools.csharp",
  "sua-nova-extensao.aqui"
]
```

### Instalar Pacotes Python Adicionais

Edite `Dockerfile` e adicione antes de `WORKDIR`:

```dockerfile
RUN pip3 install seu-pacote-aqui
```

### Alterar Portas Expostas

Edite `devcontainer.json`:

```json
"forwardPorts": [5000, 5001, 7000, 7001, 8080],
```

## 🐛 Troubleshooting

### Container não inicia

```bash
# Reconstruir o container
Ctrl+Shift+P > "Dev Containers: Rebuild Container"
```

### Porta já em uso

Edite `devcontainer.json` e altere as portas em `forwardPorts`:

```json
"forwardPorts": [5000, 5001, 7000, 7001]
```

### Specify CLI não encontrado

```bash
uv tool install --force --python python3.11 specify-cli --from git+https://github.com/github/spec-kit.git@v0.7.0
```

### Git não configura autor

```bash
# Dentro do container
git config user.email "seu@email.com"
git config user.name "Seu Nome"

# Para todo o sistema
git config --global user.email "seu@email.com"
git config --global user.name "Seu Nome"
```

### .NET SDK não encontrado

Reconstrua o container:

```bash
Ctrl+Shift+P > "Dev Containers: Rebuild Container"
```

### Problemas de permissão

Se encontrar problemas de permissão com arquivos:

```bash
# Dentro do container
sudo chown -R vscode:vscode "$PWD"
```

## 📚 Recursos Úteis

- [Dev Containers Documentation](https://containers.dev/)
- [VS Code Remote - Containers](https://code.visualstudio.com/docs/remote/containers)
- [Docker Install Guide](https://docs.docker.com/install/)
- [.NET Documentation](https://learn.microsoft.com/dotnet)
- [Blazor Documentation](https://learn.microsoft.com/aspnet/core/blazor/)

## ⚡ Performance Tips

### WSL 2 (Windows)

Se usar Windows com WSL 2:

1. Clone o projeto **inside** WSL 2
2. Abra com: `code \\wsl$\Ubuntu\path\to\project`

### macOS com Apple Silicon

O Dockerfile usa Ubuntu 22.04 que é compatível com ARM64. Se encontrar problemas:

```dockerfile
# Em .devcontainer/Dockerfile, altere
FROM mcr.microsoft.com/devcontainers/dotnet:8.0-bookworm
# para:
FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/dotnet:8.0-bookworm
```

### Melhorar Velocidade de Build

O `devcontainer.json` atual usa `image + features` (sem build customizado), então não há `buildArgs` para ajustar no Codespaces. Para Docker Compose local, prefira manter cache Docker habilitado no host.



## ✅ Verificação de Ambiente

Após abrir no Dev Container, o script `post-create.sh` executa automaticamente. Você pode verificar:

```bash
dotnet --version
python3 --version
node --version
npm --version
specify --version
```

## 🎉 Conclusão

Seu ambiente Dev Container está pronto! Comece a desenvolver:

1. ✅ Container construído
2. ✅ Ferramentas instaladas
3. ✅ GitHub Spec Kit inicializado
4. ✅ Dependências restauradas

Agora você pode:
- Gerar documentação com Spec Kit
- Criar projetos .NET
- Desenvolver com GitHub Copilot
- Usar hot reload com `dotnet watch`

**Happy Coding! 🚀**
