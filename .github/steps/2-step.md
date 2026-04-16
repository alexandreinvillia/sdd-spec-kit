## Etapa 2: Gerar a `constitution.md` para o stakeholder

O arquivo constitution.md define políticas, requisitos e padrões técnicos que devem ser seguidos durante todo o processo de desenvolvimento.

O GitHub Spec Kit inclui vários recursos que ajudam você a criar e manter o arquivo constitution.md:

O arquivo `.specify/memory/constitution.md` contém um template para o documento de constitution.
O arquivo `.github/agents/speckit.constitution.agent.md` contém instruções detalhadas usadas para gerar (ou atualizar) o arquivo **constitution.md**.
O arquivo `.github/prompts/speckit.constitution.prompt.md` contém um "routing stub" que instrui o Copilot Chat a executar o agent chamado `speckit.constitution` quando o comando `/speckit.constitution` é invocado.
O comando `/speckit.constitution` é usado para gerar o arquivo **constitution.md** do projeto.

A versão inicial do arquivo **constitution.md** especifica que a constitution deve incluir o seguinte:

**Project Name**

**Section 1: Core Principles.** A seção Core Principles precisa incluir cinco princípios centrais. Exemplos dos princípios e de suas descrições são fornecidos no template.

**Section 2: unnamed.** Exemplos de nome e conteúdo da seção são fornecidos no template.

**Section 3: unnamed.** Exemplos de nome e conteúdo da seção são fornecidos no template.

**Section 4: Governance.** Exemplos de como a seção de governance é aplicada e de regras de governance são fornecidos no template.


O arquivo **speckit.constitution.agent.md** fornece instruções para atualizar o arquivo constitution.md com base no texto ou nos arquivos de entrada fornecidos com o comando `/speckit.constitution`. Quando nenhuma orientação é fornecida, o agent usa o que consegue encontrar no codebase para preencher o template da constitution.

O workflow **/speckit.constitution** usa entrada de texto, entrada de arquivos e o codebase para coletar políticas, padrões, requisitos e diretrizes que compõem o arquivo constitution.md. Fornecer entradas detalhadas ajuda a gerar uma constitution mais precisa e abrangente.


### ⌨️ Atividade 1: Adicionando os documentos do stakeholder e gerando a constitution.md

Nesta tarefa, você precisa adicionar os documentos do stakeholder do projeto RSS e avaliará a relação deles com os comandos do GitHub Spec Kit e, em seguida, usará esses documentos para gerar o arquivo constitution.md.



Use as etapas a seguir para concluir esta tarefa:

1. Na pasta raiz do projeto dentro da pasta `docs`selecione os três documentos do stakeholder.

2. Abra cada um deles e visualize o conteúdo para entender sobre o projeto.

3. Crie uma nova pasta chamada `StakeholderDocuments` na raiz do projeto e copie os três documentos para essa pasta.

4. O resultado deve estar semelhante ao modelo abaixo:

```text
 Project (root)
 ├── .github/
 │   ├── agents/                 (workflows executáveis do GitHub Spec Kit que podem ser acionados por comandos)
 │   └── prompts/                (arquivos de prompt do GitHub Spec Kit que fornecem instruções detalhadas para cada workflow de agent)
 ├── .specify/                   (configuração do GitHub Spec Kit)
 │   ├── memory/                 (o GitHub Spec Kit armazena a constitution do projeto, definindo princípios centrais e regras de governance que todos os recursos devem seguir)
 │   ├── scripts/powershell/     (o GitHub Spec Kit usa utilitários de automação (scripts) para criar recursos, configurar plans e gerenciar o workflow de specification)
 │   └── templates/              (o GitHub Spec Kit fornece formatos markdown padronizados para specs, plans, tasks e checklists para garantir documentação consistente em todos os recursos)
 ├── .vscode/                    (configuração do Visual Studio Code)
 ├── StakeholderDocuments        (pasta que contém documentos fornecidos pelo stakeholder)
 └── README.md                   (arquivo readme que descreve a documentação do projeto)

```


5. Na visualização EXPLORER do Visual Studio Code, expanda a pasta `StakeholderDocuments`.

A pasta StakeholderDocuments deve incluir os seguintes arquivos:

- ProjectGoals.md - Objetivos de alto nível do projeto, propósito, escopo, abordagem de entrega, plano de rollout, metas de qualidade e padrões/diretrizes.
- AppFeatures.md - Requisitos detalhados de funcionalidades voltadas ao usuário.
- TechStack.md - Escolhas de tecnologia e justificativa arquitetural.

Esses documentos incluem descrições em linguagem natural dos objetivos e restrições do projeto, das funcionalidades do aplicativo e dos requisitos técnicos. Entender esse contexto é essencial para criar specification, plan e tasks efetivos. O nível de detalhamento é típico do que você encontraria em documentação preliminar de muitos projetos reais.

A documentação do projeto e os detalhes fornecidos pelos documentos podem variar bastante, dependendo das políticas da empresa e da complexidade do projeto. Os comandos do GitHub Spec Kit foram projetados para funcionar com qualquer nível de detalhamento disponível e usar essas informações para criar os documentos constitution, spec, plan e tasks necessários para um processo de desenvolvimento orientado por especificação bem-sucedido. No entanto, entradas detalhadas levam a resultados mais previsíveis.

### ⌨️ Atividade 2: Construindo uma constitution.md usando os documentos do stakeholder

1. Na visualização Chat, para iniciar um workflow de constitution usando uma combinação de texto inline e documentos do stakeholder, digite o seguinte comando:

```bash
/speckit.constitution --text "Projetos de código enfatizam a segurança, a capacidade de manutenção e a qualidade do código. Certifique-se de que todos os princípios sejam específicos, acionáveis e relevantes para o contexto do projeto." --files StakeholderDocuments/ProjectGoals.md StakeholderDocuments/AppFeatures.md StakeholderDocuments/TechStack.md
```
2. Monitore a resposta do GitHub Copilot.

Pode levar alguns minutos para o GitHub Copilot analisar os requisitos do projeto e, em seguida, atualizar o arquivo constitution.md.

Quando o GitHub Copilot terminar de gerar a constitution, reserve um momento para revisar as edições sugeridas.

Observe que o workflow de constitution extrai princípios subjacentes das suas entradas (texto e arquivos) e usa essas informações para adicionar detalhes à constitution.

3. Você deve revisar a constitution para garantir que ela represente os requisitos com precisão. Essa etapa é importante quando você está trabalhando em um ambiente de produção, no qual a constitution representa seus requisitos de negócio e sua governance técnica. Em um exercício de treinamento, essa revisão serve principalmente para ajudar você a se familiarizar com o conteúdo da constitution.

Cada princípio deve ser declarado com clareza e ser acionável. Por exemplo:
    ❌ Vago: "Apply security best practices." é muito genérico.
    ✅ Claro: "All API endpoints MUST validate inputs before processing (URL format validation, length limits, null checks)." é específico e acionável.

Se requisitos críticos estiverem ausentes ou não estiverem claros, você pode editar o arquivo constitution.md diretamente para adicionar ou modificar princípios.

Em um cenário de produção, é importante revisar a constitution com base nos seguintes critérios:
    Completeness: todas as áreas principais estão cobertas.
    Clarity: cada princípio é específico e sem ambiguidades.
    Consistency: os princípios não se contradizem.
    Relevance: todos os princípios se relacionam ao projeto RSSFeedReader.

Se o workflow /speckit.constitution tiver atualizado arquivos na pasta templates, reserve um momento para revisar essas atualizações também.

Para aceitar as alterações em todos os arquivos atualizados, selecione o botão Keep na visualização Chat.

4. Salve e, em seguida, feche os arquivos atualizados.

### ⌨️ Atividade 3: Persistindo a constitution.md no repositório GitHub

1. Faça commit e push dos arquivos atualizados para o seu repositório Git.

Por exemplo:
    Abra a visualização SOURCE CONTROL do Visual Studio Code.
    Insira uma mensagem de commit como "Updated constitution using stakeholder requirements."
    Faça stage e commit das alterações.
    Faça push das alterações para o seu repositório Git.

Você pode verificar o commit consultando seu repositório GitHub no navegador. O arquivo constitution.md atualizado agora deve aparecer com a sua mensagem de commit.

A constitution funciona como um "contrato" entre requisitos de negócio e implementação técnica, garantindo consistência ao longo do processo de desenvolvimento orientado por especificação. Quando você usa o GitHub Spec Kit para gerar spec, plan e tasks, ele referencia esses princípios para garantir que a implementação esteja alinhada aos requisitos especificados.
 
