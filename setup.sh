#!/bin/bash

# Script de Setup Rápido - GitHub Spec Kit RSS Reader
# Este script ajuda na configuração inicial do projeto

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Função para exibir títulos
print_header() {
    echo ""
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC} $1"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Função para exibir informações
print_info() {
    echo -e "${GREEN}→${NC} $1"
}

# Função para exibir avisos
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Função para exibir erros
print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Menu Principal
show_menu() {
    echo -e "${BLUE}Selecione uma opção:${NC}"
    echo ""
    echo "  1) Verificar ambiente"
    echo "  2) Abrir em Dev Container (VS Code)"
    echo "  3) Inicializar GitHub Spec Kit"
    echo "  4) Criar estrutura de projetos .NET"
    echo "  5) Restaurar dependências"
    echo "  6) Executar testes completos"
    echo "  7) Limpar e reconstruir"
    echo "  8) Exibir documentação"
    echo "  0) Sair"
    echo ""
    read -p "Opção [0-8]: " choice
}

# Verificar Ferramentas
check_tools() {
    print_header "🔍 Verificando Ferramentas"
    
    local all_good=true
    
    # .NET
    if command -v dotnet &> /dev/null; then
        version=$(dotnet --version)
        print_info ".NET SDK: $version"
    else
        print_error ".NET SDK não encontrado"
        all_good=false
    fi
    
    # Docker
    if command -v docker &> /dev/null; then
        version=$(docker --version)
        print_info "Docker: $version"
    else
        print_error "Docker não encontrado (necessário para Dev Container)"
        all_good=false
    fi
    
    # Git
    if command -v git &> /dev/null; then
        version=$(git --version)
        print_info "Git: $version"
    else
        print_error "Git não encontrado"
        all_good=false
    fi
    
    # Python
    if command -v python3 &> /dev/null; then
        version=$(python3 --version)
        print_info "Python: $version"
    else
        print_warning "Python3 não encontrado (opcional)"
    fi
    
    # VS Code
    if command -v code &> /dev/null; then
        print_info "VS Code encontrado"
    else
        print_warning "VS Code não encontrado (recomendado)"
    fi
    
    echo ""
    if [ "$all_good" = false ]; then
        print_error "Algumas ferramentas obrigatórias não foram encontradas"
        return 1
    fi
    
    print_info "Todas as ferramentas obrigatórias estão instaladas! ✅"
    return 0
}

# Abrir em Dev Container
open_devcontainer() {
    print_header "🐳 Abrindo em Dev Container"
    
    if ! command -v code &> /dev/null; then
        print_error "VS Code não encontrado. Instale em: https://code.visualstudio.com"
        return 1
    fi
    
    print_info "Abrindo VS Code..."
    code .
    
    echo ""
    print_info "Instruções:"
    echo "  1. Aguarde VS Code abrir"
    echo "  2. Pressione Ctrl+Shift+P (ou Cmd+Shift+P no macOS)"
    echo "  3. Digite: 'Dev Containers: Reopen in Container'"
    echo "  4. Pressione Enter"
    echo "  5. Aguarde o container ser construído (primeira vez leva 3-5 min)"
    echo ""
    print_info "Alternativamente: Um prompt 'Reopen in Container?' pode aparecer automaticamente"
}

# Inicializar GitHub Spec Kit
init_speckit() {
    print_header "📋 Inicializando GitHub Spec Kit"
    
    if [ -d ".specify" ]; then
        print_warning "GitHub Spec Kit já foi inicializado"
        read -p "Deseja reinicializar? (s/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Ss]$ ]]; then
            return 0
        fi
    fi
    
    print_info "Executando: specify init --here --ai copilot --script sh"
    
    if ! command -v specify &> /dev/null; then
        print_error "Specify CLI não encontrado"
        print_info "Instale com: npm install -g @github-spec-kit/specify-cli"
        return 1
    fi
    
    specify init --here --ai copilot --script sh
    
    print_info "GitHub Spec Kit inicializado com sucesso! ✅"
    echo ""
    echo "Próximos comandos disponíveis:"
    echo "  /speckit.constitution  - Gerar documentação constitution"
    echo "  /speckit.spec          - Gerar especificação técnica"
    echo "  /speckit.plan          - Gerar plano de execução"
    echo "  /speckit.tasks         - Gerar tarefas de implementação"
}

# Criar Projetos .NET
create_dotnet_projects() {
    print_header "🔨 Criando Estrutura de Projetos .NET"
    
    print_info "Criando solução..."
    dotnet new solution -n RSSFeedReader --force
    
    print_info "Criando projeto API..."
    mkdir -p RSSFeedReader.Api
    dotnet new webapi -n RSSFeedReader.Api -o RSSFeedReader.Api -f net8.0 --no-https
    
    print_info "Criando projeto Frontend Blazor..."
    mkdir -p RSSFeedReader.UI
    dotnet new blazorwasm -n RSSFeedReader.UI -o RSSFeedReader.UI -f net8.0 --no-https
    
    print_info "Adicionando projetos à solução..."
    dotnet sln RSSFeedReader.sln add RSSFeedReader.Api/RSSFeedReader.Api.csproj
    dotnet sln RSSFeedReader.sln add RSSFeedReader.UI/RSSFeedReader.UI.csproj
    
    print_info "Projetos .NET criados com sucesso! ✅"
    
    echo ""
    echo "Estrutura criada:"
    echo "  RSSFeedReader.sln"
    echo "  ├── RSSFeedReader.Api/"
    echo "  └── RSSFeedReader.UI/"
}

# Restaurar Dependências
restore_dependencies() {
    print_header "📦 Restaurando Dependências"
    
    if [ ! -f "RSSFeedReader.sln" ]; then
        print_error "RSSFeedReader.sln não encontrado"
        print_info "Execute a opção '4) Criar estrutura de projetos .NET' primeiro"
        return 1
    fi
    
    print_info "Executando dotnet restore..."
    dotnet restore RSSFeedReader.sln
    
    print_info "Dependências restauradas com sucesso! ✅"
}

# Testes Completos
run_tests() {
    print_header "✅ Executando Testes Completos"
    
    check_tools || return 1
    
    echo ""
    print_info "Verificação de ambiente com sucesso!"
}

# Limpar
cleanup() {
    print_header "🧹 Limpando Arquivos Temporários"
    
    read -p "Isso vai limpar bin/, obj/ e .vs/. Continuar? (s/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        find . -type d -name "bin" -exec rm -rf {} + 2>/dev/null || true
        find . -type d -name "obj" -exec rm -rf {} + 2>/dev/null || true
        find . -type d -name ".vs" -exec rm -rf {} + 2>/dev/null || true
        print_info "Limpeza concluída! ✅"
    fi
}

# Exibir Documentação
show_docs() {
    print_header "📚 Documentação"
    
    echo ""
    echo "Recursos disponíveis:"
    echo ""
    echo "1. README.md"
    echo "   Documentação principal do projeto"
    echo ""
    echo "2. .devcontainer/README.md"
    echo "   Guia completo do Dev Container"
    echo ""
    echo "3. docs/ProjectGoals.md"
    echo "   Objetivos e escopo do projeto"
    echo ""
    echo "4. docs/TechStack.md"
    echo "   Stack tecnológico e decisões arquiteturais"
    echo ""
    echo "5. docs/AppFeatures.md"
    echo "   Funcionalidades da aplicação"
    echo ""
    
    read -p "Abrir qual documentação? (1-5 / 0 para cancelar): " doc_choice
    
    case $doc_choice in
        1) less README.md ;;
        2) less .devcontainer/README.md ;;
        3) less docs/ProjectGoals.md ;;
        4) less docs/TechStack.md ;;
        5) less docs/AppFeatures.md ;;
        0) return ;;
        *) print_error "Opção inválida" ;;
    esac
}

# Main Loop
main() {
    print_header "🚀 GitHub Spec Kit - Setup Assistant"
    
    while true; do
        show_menu
        
        case $choice in
            1) check_tools ;;
            2) open_devcontainer ;;
            3) init_speckit ;;
            4) create_dotnet_projects ;;
            5) restore_dependencies ;;
            6) run_tests ;;
            7) cleanup ;;
            8) show_docs ;;
            0) 
                print_info "Até logo! 👋"
                exit 0
                ;;
            *)
                print_error "Opção inválida"
                ;;
        esac
        
        echo ""
        read -p "Pressione Enter para continuar..."
    done
}

# Executar
if [ "$#" -eq 0 ]; then
    main
else
    case $1 in
        check) check_tools ;;
        init) init_speckit ;;
        create) create_dotnet_projects ;;
        restore) restore_dependencies ;;
        clean) cleanup ;;
        *) 
            echo "Uso: $0 [check|init|create|restore|clean]"
            echo ""
            echo "Ou execute sem argumentos para menu interativo:"
            echo "  $0"
            ;;
    esac
fi
