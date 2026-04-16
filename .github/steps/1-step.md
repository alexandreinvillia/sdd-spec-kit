## Etapa 1: Criar a pasta do projeto e inicializar o GitHub Spec Kit

O Specify CLI é usado para inicializar o GitHub Spec Kit em uma pasta de projeto. O GitHub Spec Kit usa a pasta do projeto para armazenar arquivos de configuração, modelos, scripts e agentes que suportam os fluxos de trabalho de desenvolvimento orientados por especificações.

Nesta tarefa, caso esteja trabalhando localmente, crie uma pasta no seu computador para o projeto e depois inicialize o GitHub Spec Kit no diretório do projeto.

> [!NOTE]
> Caso deseje trabalhar usando o GitHub Codespaces, você pode pular os passos de criação de pasta e navegação no terminal, e simplesmente abrir um Codespace para este repositório. O GitHub Spec Kit será inicializado diretamente na raiz do repositório, onde os arquivos de configuração, modelos, scripts e agentes serão criados.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/{{full_repo_name}}?quickstart=1)
- O plano gratuito de Codespaces que vem com todas as contas GitHub é suficiente, assumindo que você ainda tem minutos disponíveis.
- As configurações do Codespace já estão configuradas e são suficientes.

O comando abaixo é usado para inicializar o GitHub Spec Kit 
```bash
 specify init --here --ai copilot --script ps
```


> [!IMPORTANT]
> Os passos abaixo são usados apenas para configuração local.

Crie uma pasta para o projeto usando o comando abaixo:
```bash
 mkdir TrainingProjects\RSSFeedReader
``` 

Acesse o diretório recém criado para o projeto:
```bash
 cd TrainingProjects\RSSFeedReader
``` 
O comando abaixo é usado para inicializar o GitHub Spec Kit 
```bash
 specify init --here --ai copilot --script ps
``` 

> [!IMPORTANT]
> Se você está usando macOS ou Linux com bash/zsh, troque o comando `--script ps` por `--script sh`.

Abra o projeto no seu Visual Studio Code com o comando a seguir:
```bash
 code .
```
 

Este comando especifica os seguintes parâmetros:

- `--here` - Inicializa o GitHub Spec Kit no diretório atual.
- `--ai copilot` - Configura o projeto para usar o GitHub Copilot como assistente de IA.
- `--script ps` - Especifica que os scripts do PowerShell serão usados.


O comando `specify init` completa as seguintes ações:

- Cria arquivos de prompt de agente nos diretórios `.github/agents/` e `.github/prompts/`.
- Cria arquivos de modelo nos diretórios `.specific/memory/` e `.specific/templates/`.
- Cria arquivos de script no diretório `.specific/scripts/powershell/`.
- Cria um arquivo `settings.json` no diretório `.vscode/`.
- Exibe uma mensagem de sucesso (“Projeto pronto”).
- Sugere alguns próximos passos opcionais.


Quando você usar o comando `specify init` ele reconhece que o diretório atual não está vazio e pede confirmação antes de prosseguir. O comando preserva todos os arquivos de aplicação existentes.

> [!WARNING]
> “Especificar comando não encontrado”: Para garantir que você instalou a CLI do Specify, execute a versão específica.
> Erros de permissão negados: no Windows, verifique se você está executando o PowerShell com permissões apropriadas. No macOS/Linux, verifique as permissões de arquivo.
> Erros de clone do Git: Verifique se você está conectado ao GitHub e que tem acesso ao seu repositório importado.
> Comandos do GitHub Spec Kit não aparecendo: Certifique-se de que o .github/prompts/ exista na raiz do seu espaço de trabalho. Tente recarregar o Visual Studio Code.


```text
 Project (root)
 ├── .github/
 │   ├── agents/                 (GitHub Spec Kit workflows que podem ser acionados por meio de comandos)
 │   └── prompts/                (GitHub Spec Kit arquivos de prompt que fornecem instruções detalhadas para cada um dos fluxos de trabalho do agente)
 ├── .specify/                   (GitHub Spec Kit configurações)
 │   ├── memory/                 (GitHub Spec Kit armazena a constituição do projeto definindo princípios fundamentais e regras de governança que todos os recursos devem seguir)
 │   ├── scripts/powershell/     (GitHub Spec Kit usa utilitários de automação (scripts) para criar recursos, configurar planos e gerenciar o fluxo de trabalho de especificação)
 │   └── templates/              (GitHub Spec Kit fornece formatos de markdown padronizados para especificações, planos, tarefas e listas de verificação para garantir documentação consistente em todos os recursos)
 └── .vscode/                    (Configurações do Visual Studio Code)
```

> [!IMPORTANT]
> As saidas geradas pela IA, tendem a ter comportamentos diferentes dependendo do modelo utilizado. Claude Sonnet 4.5 pode ter um detalhamento mais em relação ao modelo GPT-5.2 assim como outros modelos tem seus comportamentos diferentes. Sinta-se livre para experimentar os modelos disponíveis e usar o que melhor se encaixar para você.

### 📖 Publique suas alterações

1. Na sessão do Visual Studio Code, acesse a aba de controle de versão (ícone de ramificação) e você verá os arquivos modificados listados.
2. Selecione Publicar alterações para enviar suas modificações para o repositório remoto no GitHub.
3. Aguarde a conclusão do processo de publicação. Você verá uma confirmação quando as alterações forem publicadas com sucesso.

> [!NOTE]
> Se você estiver usando o plano GitHub Copilot Free, você deve publicar em um repositório público para garantir que você tenha acesso aos recursos do GitHub Copilot. Se você tiver uma assinatura Pro, Pro+, Business ou Enterprise, poderá publicar em um repositório privado.
