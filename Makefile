.PHONY: help setup dev-setup build run clean restore test docker-build docker-run spec-init spec-constitution spec-spec spec-plan spec-tasks

# Variáveis
PROJECT_NAME=RSSFeedReader
DOCKER_IMAGE=github-spec-kit-rss-reader
API_DIR=RSSFeedReader.Api
UI_DIR=RSSFeedReader.UI
SOLUTION_FILE=RSSFeedReader.sln

# Default target
help:
	@echo ""
	@echo "╔════════════════════════════════════════════════════════════════╗"
	@echo "║         GitHub Spec Kit - Leitor RSS | Make Commands           ║"
	@echo "╚════════════════════════════════════════════════════════════════╝"
	@echo ""
	@echo "📋 Configuração Inicial:"
	@echo "  make setup          - Setup interativo completo do projeto"
	@echo "  make dev-setup      - Setup para desenvolvimento local"
	@echo ""
	@echo "🐳 Dev Container:"
	@echo "  make docker-build   - Construir imagem Docker"
	@echo "  make docker-run     - Executar container"
	@echo ""
	@echo "🔨 Desenvolvimento:"
	@echo "  make build          - Build dos projetos .NET"
	@echo "  make run            - Executar backend API"
	@echo "  make watch          - Executar com hot reload"
	@echo "  make clean          - Limpar bin/ obj/ e caches"
	@echo "  make restore        - Restaurar dependências NuGet"
	@echo "  make test           - Executar testes"
	@echo ""
	@echo "📚 GitHub Spec Kit:"
	@echo "  make spec-init      - Inicializar Spec Kit"
	@echo "  make spec-constitution - Gerar constitution.md"
	@echo "  make spec-spec      - Gerar spec.md"
	@echo "  make spec-plan      - Gerar plan.md"
	@echo "  make spec-tasks     - Gerar tasks.md"
	@echo ""
	@echo "🛠️  Utilitários:"
	@echo "  make format         - Formatar código"
	@echo "  make lint           - Validar código"
	@echo ""

# Setup interativo
setup:
	@bash ./setup.sh

# Setup para desenvolvimento local
dev-setup:
	@echo "🔨 Configurando ambiente de desenvolvimento..."
	@dotnet restore
	@echo "✅ Ambiente pronto para desenvolvimento!"

# Build
build:
	@echo "🔨 Compilando projetos..."
	@dotnet build $(SOLUTION_FILE)
	@echo "✅ Build concluído!"

# Run API
run:
	@echo "🚀 Iniciando backend API..."
	@cd $(API_DIR) && dotnet run

# Watch mode
watch:
	@echo "👁️  Iniciando watch mode..."
	@cd $(API_DIR) && dotnet watch run

# Restore
restore:
	@echo "📦 Restaurando dependências..."
	@dotnet restore $(SOLUTION_FILE)
	@echo "✅ Dependências restauradas!"

# Clean
clean:
	@echo "🧹 Limpando arquivos temporários..."
	@find . -type d -name "bin" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name "obj" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".vs" -exec rm -rf {} + 2>/dev/null || true
	@rm -rf .dotnet 2>/dev/null || true
	@echo "✅ Limpeza concluída!"

# Test
test:
	@echo "🧪 Executando testes..."
	@dotnet test $(SOLUTION_FILE)

# Docker build
docker-build:
	@echo "🐳 Construindo imagem Docker..."
	@docker build -t $(DOCKER_IMAGE):latest .devcontainer
	@echo "✅ Imagem construída!"

# Docker run
docker-run:
	@echo "🐳 Iniciando container..."
	@docker-compose up -d --build
	@docker-compose exec dev-container bash
	@docker-compose down

# GitHub Spec Kit - Initialize
spec-init:
	@echo "📋 Inicializando GitHub Spec Kit..."
	@specify init --here --ai copilot --script sh
	@echo "✅ Spec Kit inicializado!"

# GitHub Spec Kit - Constitution
spec-constitution:
	@echo "📋 Gerando constitution.md..."
	@echo "Execute no VS Code:"
	@echo "  /speckit.constitution --text \"Projetos de código enfatizam a segurança e qualidade.\" --files StakeholderDocuments/*"

# GitHub Spec Kit - Spec
spec-spec:
	@echo "📋 Gerando spec.md..."
	@echo "Execute no VS Code:"
	@echo "  /speckit.spec"

# GitHub Spec Kit - Plan
spec-plan:
	@echo "📋 Gerando plan.md..."
	@echo "Execute no VS Code:"
	@echo "  /speckit.plan"

# GitHub Spec Kit - Tasks
spec-tasks:
	@echo "📋 Gerando tasks.md..."
	@echo "Execute no VS Code:"
	@echo "  /speckit.tasks"

# Format
format:
	@echo "✨ Formatando código..."
	@dotnet format $(SOLUTION_FILE)
	@echo "✅ Formatação concluída!"

# Lint
lint:
	@echo "🔍 Validando código..."
	@dotnet build $(SOLUTION_FILE) --no-restore

# Install Specify CLI
install-specify:
	@echo "📦 Instalando Specify CLI..."
	@npm install -g @github-spec-kit/specify-cli
	@specify --version
	@echo "✅ Specify CLI instalado!"

# Create .NET projects
create-projects:
	@echo "🔨 Criando estrutura de projetos .NET..."
	@dotnet new solution -n $(PROJECT_NAME) --force
	@mkdir -p $(API_DIR)
	@dotnet new webapi -n $(PROJECT_NAME).Api -o $(API_DIR) -f net8.0 --no-https
	@mkdir -p $(UI_DIR)
	@dotnet new blazorwasm -n $(PROJECT_NAME).UI -o $(UI_DIR) -f net8.0 --no-https
	@dotnet sln RSSFeedReader.sln add $(API_DIR)/RSSFeedReader.Api.csproj
	@dotnet sln RSSFeedReader.sln add $(UI_DIR)/RSSFeedReader.UI.csproj
	@echo "✅ Projetos criados!"

# Verify environment
verify:
	@echo "🔍 Verificando ambiente..."
	@echo "✓ Verificando .NET..."
	@dotnet --version
	@echo "✓ Verificando Git..."
	@git --version
	@echo "✓ Verificando Python..."
	@python3 --version || echo "⚠ Python3 não encontrado"
	@echo "✓ Verificando Node.js..."
	@node --version || echo "⚠ Node.js não encontrado"
	@echo ""
	@echo "✅ Ambiente verificado!"

# Quick start
quick-start: verify restore build
	@echo ""
	@echo "🚀 Quick start completo!"
	@echo ""
	@echo "Próximos passos:"
	@echo "  1. Abra em Dev Container: code . && Ctrl+Shift+P > Dev Containers: Reopen"
	@echo "  2. Ou execute localmente: make run"

.DEFAULT_GOAL := help
