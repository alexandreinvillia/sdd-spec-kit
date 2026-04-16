#!/bin/bash

# Dev Container Setup Checklist & Quick Reference
# Use este arquivo como guia rápido de referência

cat << 'EOF'

╔════════════════════════════════════════════════════════════════════════════════╗
║                   🐳 Dev Container Setup - Quick Reference                     ║
╚════════════════════════════════════════════════════════════════════════════════╝

📋 ARQUIVOS CRIADOS

✅ .devcontainer/
   ├── Dockerfile              - Imagem Docker completa
   ├── devcontainer.json       - Configuração VS Code
   ├── post-create.sh          - Script de inicialização
   ├── README.md               - Documentação detalhada
   └── WELCOME.txt             - Mensagem de boas-vindas

✅ Na raiz do projeto:
   ├── docker-compose.yml      - Orquestração Docker
   ├── .env.example            - Variáveis de ambiente
   ├── .gitpod.yml            - Suporte Gitpod
   ├── setup.sh                - Script interativo
   ├── Makefile                - Comandos úteis
   ├── global.json             - Versão .NET fixada
   ├── DEVCONTAINER_SETUP.md   - Este documento
   └── .gitignore              - Padrões atualizados

═══════════════════════════════════════════════════════════════════════════════════

🚀 INÍCIO RÁPIDO (3 passos)

1️⃣ Abra a pasta em VS Code:
   $ code .

2️⃣ Abra Command Palette (Ctrl+Shift+P) e execute:
   Dev Containers: Reopen in Container

3️⃣ Aguarde 3-5 minutos (primeira vez) → Pronto! ✨

═══════════════════════════════════════════════════════════════════════════════════

💻 DENTRO DO DEV CONTAINER

1️⃣ Verificar ambiente:
   $ make verify

2️⃣ Criar projetos .NET:
   $ make create-projects

3️⃣ Compilar:
   $ make build

4️⃣ Executar backend (Terminal 1):
   $ make run

5️⃣ Executar frontend (Terminal 2):
   $ cd RSSFeedReader.UI && dotnet watch run

6️⃣ Acessar a aplicação:
   🌐 Frontend: http://localhost:7000
   🔌 Backend:  http://localhost:5000

═══════════════════════════════════════════════════════════════════════════════════

📦 SPECS KIT WORKFLOW

1. Inicializar:
   $ make spec-init

2. Gerar Constitution (em VS Code Chat):
   /speckit.constitution --files StakeholderDocuments/*

3. Gerar Spec:
   /speckit.spec

4. Gerar Plan:
   /speckit.plan

5. Gerar Tasks:
   /speckit.tasks

═══════════════════════════════════════════════════════════════════════════════════

⚡ COMANDOS ÚTEIS (Make)

make help              - Ver todos os comandos
make verify            - Verificar ambiente
make dev-setup         - Setup de desenvolvimento
make build             - Compilar projetos
make run               - Executar backend
make watch             - Hot reload backend
make clean             - Limpar cache/bin/obj
make restore           - Restaurar NuGet
make test              - Executar testes
make format            - Formatar código
make create-projects   - Criar estrutura .NET

═══════════════════════════════════════════════════════════════════════════════════

🐳 DOCKER COMPOSE (Alternativo)

docker-compose up -d --build    # Iniciar
docker-compose exec dev-container bash
docker-compose down             # Parar

═══════════════════════════════════════════════════════════════════════════════════

📚 DOCUMENTAÇÃO

Lê isto primeiro:
  👉 DEVCONTAINER_SETUP.md       - Guia completo
  👉 .devcontainer/README.md     - Dev Container detalhado
  
Projeto:
  📄 docs/ProjectGoals.md        - Objetivos
  📄 docs/TechStack.md           - Stack tecnológico
  📄 docs/AppFeatures.md         - Funcionalidades

═══════════════════════════════════════════════════════════════════════════════════

🔧 PERSONALIZAÇÕES

Adicionar extensões:
  → Edite .devcontainer/devcontainer.json
  → Campo "extensions"
  → Reconstrua: Ctrl+Shift+P > Rebuild Container

Mudar portas:
  → Edite .devcontainer/devcontainer.json
  → Campo "forwardPorts"

Instalar pacotes Python:
  → Edite .devcontainer/Dockerfile
  → Linha: RUN pip3 install seu-pacote

═══════════════════════════════════════════════════════════════════════════════════

🐛 TROUBLESHOOTING

Problema: Container não inicia
  → Ctrl+Shift+P > Dev Containers: Rebuild Container

Problema: Port já em uso
  → Edite .devcontainer/devcontainer.json
  → Mude "forwardPorts"

Problema: Git não funciona
  $ git config user.email "seu@email.com"
  $ git config user.name "Seu Nome"

Problem: .NET não encontrado
  → Reconstrua o container
  → Verifique se Docker está rodando

═══════════════════════════════════════════════════════════════════════════════════

✨ RECURSOS

🔗 Dev Containers: https://containers.dev/
🔗 .NET Docs:      https://learn.microsoft.com/dotnet
🔗 Blazor:         https://learn.microsoft.com/aspnet/core/blazor/
🔗 Docker:         https://docs.docker.com/
🔗 Spec Kit:       https://github.com/github/spec-kit-starter

═══════════════════════════════════════════════════════════════════════════════════

🎯 PRÓXIMO PASSO

Execute para começar:

  code .

Depois: Ctrl+Shift+P > Dev Containers: Reopen in Container

═══════════════════════════════════════════════════════════════════════════════════

✅ Configuração concluída com sucesso!

EOF
