## Etapa 4: Gerando um plano usando a documentação do arquivo spec.md e usando a documentação do stakeholder

O plano técnico faz a ponte entre o **"o quê"** (especificação) e o **"como"** (implementação). Ele define a arquitetura, as escolhas de tecnologia, os modelos de dados, os designs de API e a abordagem de implementação, respeitando as restrições definidas na constitution.

### ⌨️ Atividade 1: Construindo o plano a partir da spec

Nesta tarefa, você usará o comando `/speckit.plan` do GitHub Copilot para gerar um plano técnico de implementação abrangente.

Use as etapas a seguir para concluir esta tarefa:

1. Use a visualização EXPLORER do Visual Studio Code para abrir os arquivos plan-template.md e speckit.plan.agent.md.

2. Reserve um minuto para revisar os arquivos plan-template.md e speckit.plan.agent.md.

> [!NOTE] Observação: O arquivo plan-template.md define a estrutura e as seções de um documento de plano técnico. O arquivo speckit.plan.agent.md fornece instruções detalhadas para o comando `/speckit.plan`. Ele orienta o GitHub Copilot sobre como criar um plano técnico com base na especificação e na constitution.

3. Feche todos os arquivos que estiverem abertos no editor.

4. Na visualização Chat, para iniciar um fluxo de trabalho que gera o arquivo plan.md, digite o seguinte comando:

```bash
/speckit.plan --files StakeholderDocuments/ProjectGoals.md StakeholderDocuments/TechStack.md
```

5. Monitore a resposta do GitHub Copilot e forneça suporte na visualização Chat.

O GitHub Copilot analisa os arquivos `constitution.md`, `spec.md` e os arquivos de stakeholder para gerar o plano. Conceda permissões e ofereça suporte quando necessário.

O GitHub Copilot pode levar de 6 a 8 minutos para gerar o plano técnico e os arquivos markdown associados.

6. Quando o fluxo de trabalho do plano for concluído, verifique se os seguintes arquivos foram adicionados à raiz da pasta specs:
- `plan.md`
- `research.md`
- `quickstart.md`
- `data-model.md`

Você também pode ver um ou mais arquivos listados na pasta `contracts`.

7. Reserve alguns minutos para revisar os arquivos `research.md`, `plan.md`, `quickstart.md` e `data-model.md`.
- O arquivo **research.md** registra as descobertas de pesquisa e as decisões de tecnologia para o app RSS.
- O arquivo **plan.md** descreve o plano técnico de implementação para o app RSS.
- O arquivo **quickstart.md** fornece instruções de configuração e uma visão geral de alto nível sobre como começar a implementação.
- O arquivo **data-model.md** define as entidades de dados, propriedades e relacionamentos necessários para o app RSS.

Em um cenário de produção, você precisa garantir que o plano forneça uma descrição abrangente do contexto técnico e uma estratégia de implementação claramente definida para o novo app/novas funcionalidades. Os arquivos de research, quickstart e data model devem complementar o plano, fornecendo contexto e detalhes adicionais. Neste exercício, foque em se familiarizar com o conteúdo associado a cada um desses arquivos.

8. Depois de revisar os arquivos, aceite todas as edições sugeridas.

Se o plano omitir detalhes importantes ou fizer suposições com as quais você não concorda, você pode:
- Editar o arquivo plan.md diretamente, ou
- Fazer perguntas de acompanhamento no GitHub Copilot Chat.

9. Salve os arquivos e, em seguida, faça commit e sync das suas alterações.

O plano técnico agora serve como um blueprint para a implementação. Ele traduz os requisitos de negócio em decisões técnicas concretas, respeitando as restrições organizacionais.


