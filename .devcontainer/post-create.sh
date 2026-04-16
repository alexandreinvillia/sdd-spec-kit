#!/bin/bash

# Script de inicialização do Dev Container
# Executa configurações necessárias após a criação do container

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SPECIFY_VERSION="${SPECIFY_VERSION:-v0.7.0}"

cd "${WORKSPACE_DIR}"

# Garantir ~/.local/bin no PATH (necessário para uv e tools instalados pelo usuário)
export PATH="$HOME/.local/bin:$PATH"

echo "🚀 Iniciando configuração do Dev Container..."
echo ""

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Função para imprimir seções
print_section() {
    echo ""
    echo -e "${BLUE}==== $1 ====${NC}"
    echo ""
}

# Função para verificar ferramentas
check_tool() {
    local command_name="$1"
    local label="$2"

    if command -v "$command_name" &> /dev/null; then
        version=$($command_name --version 2>&1 | head -n 1)
        echo -e "${GREEN}✓${NC} ${label} instalado: $version"
        return 0
    else
        echo -e "${RED}✗${NC} ${label} não encontrado!"
        return 1
    fi
}

install_uv() {
    if command -v uv &> /dev/null; then
        return 0
    fi
    echo -e "${YELLOW}→${NC} Instalando uv (gerenciador de pacotes Python)..."
    python3 -m pip install --user --quiet uv 2>/dev/null \
        || pip3 install --user --quiet uv 2>/dev/null \
        || { echo -e "${RED}✗${NC} Não foi possível instalar uv"; return 1; }
    hash -r 2>/dev/null || true
}

install_specify_cli() {
    install_uv || true

    if command -v specify &> /dev/null; then
        return 0
    fi

    if ! command -v uv &> /dev/null; then
        echo -e "${RED}✗${NC} uv não disponível — não é possível instalar Specify CLI"
        return 1
    fi

    echo -e "${YELLOW}⚠${NC} Specify CLI não encontrado, instalando via uv..."
    uv tool install --force specify-cli \
        --from "git+https://github.com/github/spec-kit.git@${SPECIFY_VERSION}" 2>/dev/null \
    || uv tool install --force specify-cli \
        --from "git+https://github.com/github/spec-kit.git" 2>/dev/null \
    || { echo -e "${RED}✗${NC} Falha ao instalar Specify CLI"; return 1; }
}

# Validar ferramentas instaladas
print_section "Verificando ferramentas instaladas"

check_tool "dotnet" ".NET SDK" || true
check_tool "python3" "Python 3" || true
check_tool "node" "Node.js" || true
check_tool "npm" "npm" || true
check_tool "git" "Git" || true
check_tool "uv" "uv (Package Manager)" || true

# Verificar Specify CLI
print_section "Verificando Specify CLI"
install_specify_cli

if command -v specify &> /dev/null; then
    version=$(specify version 2>/dev/null | head -n 1)
    echo -e "${GREEN}✓${NC} Specify CLI instalado"
    echo "   ${version}"
else
    echo -e "${RED}✗${NC} Não foi possível instalar o Specify CLI"
fi

# Verificar/Criar estrutura do projeto
print_section "Configurando estrutura de diretórios"

# Criar pasta StakeholderDocuments se não existir
if [ ! -d "StakeholderDocuments" ]; then
    echo -e "${YELLOW}→${NC} Criando pasta StakeholderDocuments..."
    mkdir -p StakeholderDocuments
else
    echo -e "${GREEN}✓${NC} Pasta StakeholderDocuments já existe"
fi

# Copiar documentos do stakeholder se existirem em docs/
if [ -d "docs" ]; then
    echo -e "${YELLOW}→${NC} Verificando documentos do stakeholder..."
    
    for doc in ProjectGoals.md AppFeatures.md TechStack.md; do
        if [ -f "docs/$doc" ] && [ ! -f "StakeholderDocuments/$doc" ]; then
            echo -e "${YELLOW}→${NC} Copiando $doc para StakeholderDocuments/"
            cp "docs/$doc" "StakeholderDocuments/$doc"
        fi
    done
else
    echo -e "${YELLOW}⚠${NC} Pasta docs/ não encontrada"
fi

# Inicializar GitHub Spec Kit se necessário
print_section "Inicializando GitHub Spec Kit"

if [ ! -d ".specify" ]; then
    echo -e "${YELLOW}→${NC} Inicializando GitHub Spec Kit..."
    if specify init --here --force --ai copilot --script sh; then
        echo -e "${GREEN}✓${NC} GitHub Spec Kit inicializado com sucesso"
    else
        echo -e "${YELLOW}⚠${NC} Falha ao inicializar o GitHub Spec Kit automaticamente"
        echo -e "${YELLOW}→${NC} Execute manualmente: specify init --here --force --ai copilot --script sh"
    fi
else
    echo -e "${GREEN}✓${NC} GitHub Spec Kit já está inicializado"
fi

# Verificar e preparar projetos .NET
print_section "Preparando projetos .NET"

# Listar soluções .NET
SOLUTION_COUNT=$(find . -name "*.sln" -not -path "./.git/*" | wc -l)

if [ "$SOLUTION_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}→${NC} Encontrado(s) $SOLUTION_COUNT solução(ões) .NET"
    
    # Restaurar dependências
    echo -e "${YELLOW}→${NC} Restaurando dependências NuGet..."
    while IFS= read -r solution_file; do
        dotnet restore "$solution_file" || echo -e "${YELLOW}⚠${NC} Falha ao restaurar ${solution_file}"
    done < <(find . -name "*.sln" -not -path "./.git/*")
    
    echo -e "${GREEN}✓${NC} Dependências restauradas"
else
    echo -e "${YELLOW}⚠${NC} Nenhuma solução .NET encontrada"
    echo -e "${YELLOW}→${NC} Use 'dotnet new' para criar uma nova solução"
fi

# Verificar .gitignore
print_section "Validando .gitignore"

GITIGNORE_FILE=".gitignore"

# Criar .gitignore se não existir
if [ ! -f "$GITIGNORE_FILE" ]; then
    echo -e "${YELLOW}→${NC} Criando .gitignore..."
    cat > "$GITIGNORE_FILE" << 'EOF'
# Compiled source
*.com
*.class
*.dll
*.exe
*.o
*.so

# Packages
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases
*.log
*.sql
*.sqlite

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# .NET
bin/
obj/
*.csproj.user
*.sln.iml
*.suo
.vs/
.vscode/

# Dev Container

# Node modules
node_modules/
package-lock.json
yarn.lock

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# IDEs
.idea/
.vscode/
*.swp
*.swo
*~

# Specify/GitHub Spec Kit
.specify/memory/constitution.md
EOF
    echo -e "${GREEN}✓${NC} .gitignore criado"
else
    # Verificar se tem padrões .NET
    if ! grep -q "bin/" "$GITIGNORE_FILE"; then
        echo -e "${YELLOW}⚠${NC} Adicionando padrões .NET ao .gitignore..."
        echo -e "\n# .NET\nbin/\nobj/\n*.csproj.user" >> "$GITIGNORE_FILE"
    fi
    echo -e "${GREEN}✓${NC} .gitignore já existe"
fi

# Configurar Git (opcional)
print_section "Configuração Git (opcional)"

if command -v git &> /dev/null && [ -z "$(git config user.email 2>/dev/null)" ]; then
    echo -e "${YELLOW}→${NC} Configurando Git..."
    git config user.email "dev@devcontainer.local"
    git config user.name "Dev Container"
    echo -e "${GREEN}✓${NC} Git configurado"
else
    echo -e "${GREEN}✓${NC} Git já configurado"
fi

# Resumo final
print_section "✨ Configuração concluída!"

echo -e "${GREEN}Dev Container pronto para uso!${NC}"
echo ""
echo "📋 Próximos passos:"
if [ -n "${CODESPACES:-}" ]; then
    echo "  1. Confirme se o workspace abriu em ${WORKSPACE_DIR}"
    echo "  2. Verifique as ferramentas com: dotnet --version && specify version && uv --version"
    echo "  3. Continue o exercício a partir do README do repositório"
else
    echo "  1. Abra VS Code: code ."
    echo "  2. Instale a extensão 'Dev Containers' (ms-vscode-remote.remote-containers)"
    echo "  3. Abra a pasta em um Dev Container: Ctrl+Shift+P > 'Dev Containers: Open Folder in Container'"
fi
echo ""
echo "🛠️ Ferramentas disponíveis:"
echo "  • .NET SDK 8.0+"
echo "  • Python 3.11 + uv"
echo "  • Node.js + npm"
echo "  • Specify CLI"
echo "  • Git 2.48+"
echo ""
echo "📚 Recursos úteis:"
echo "  • Spec Kit docs: https://github.com/github/spec-kit-starter"
echo "  • .NET docs: https://learn.microsoft.com/dotnet"
echo "  • Blazor docs: https://learn.microsoft.com/aspnet/core/blazor"
echo ""
