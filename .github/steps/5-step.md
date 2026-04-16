## Etapa 5: Gerar as tarefas usando os arquivos spec.md, plan.md e constitution.md

O arquivo `tasks.md` divide o plano técnico em etapas de implementação específicas e acionáveis. Cada tarefa deve ser pequena o suficiente para ser concluída em um prazo razoável, normalmente de algumas horas a um dia quando executada sem assistência de IA, e deve ter critérios de aceitação claros.

### ⌨️ Atividade 1: Construindo as tarefas a partir da spec e do plano

Nesta tarefa, você usará o comando `/speckit.tasks` do GitHub Spec Kit para gerar uma lista abrangente de tarefas e um plano de implementação organizado por fases.

Use as etapas a seguir para concluir esta tarefa:

1. Use a visualização EXPLORER do Visual Studio Code para abrir os arquivos `tasks-template.md` e `speckit.tasks.agent.md`.

2. Reserve um minuto para revisar os arquivos `tasks-template.md` e `speckit.tasks.agent.md`.

> [!NOTE]
> O arquivo `tasks-template.md` organiza as tarefas em fases lógicas, enquanto o arquivo `speckit.tasks.agent.md` descreve as etapas que o fluxo de trabalho `/speckit.tasks` deve seguir:
> - quais entradas devem ser lidas (`spec.md`, `plan.md`, `constitution.md` etc.)
> - o que deve ser produzido (`tasks.md`)
> - como as tarefas devem ser sequenciadas (por fase, história do usuário etc.)
> - como cada tarefa deve ser definida (específica, acionável e testável)
> - quais verificações devem ser aplicadas (cobertura, ordenação e escopo)

3. Feche todos os arquivos que estiverem abertos no editor.

4. Na visualização Chat, para iniciar a geração do arquivo `tasks.md`, digite o seguinte comando:

```bash
/speckit.tasks
```

5. Monitore a resposta do GitHub Copilot e forneça suporte na visualização Chat.

O GitHub Copilot analisa os arquivos `spec.md`, `plan.md` e `constitution.md` para gerar as tarefas no arquivo `tasks.md`.

Esse processo pode levar de 4 a 6 minutos. Conceda permissões e ofereça suporte quando necessário.

6. Quando o fluxo de trabalho de geração das tarefas for concluído, reserve alguns minutos para revisar o arquivo `tasks.md`.

Verifique se as tarefas estão ordenadas logicamente por fase e por história do usuário. Por exemplo:
- as tarefas de Configuração e Fundação vêm primeiro
- as tarefas da API de backend são construídas sobre essa fundação
- as tarefas de frontend fazem referência aos endpoints do backend
- as tarefas de teste vêm após a implementação
- as tarefas de implantação vêm por último

Em um cenário de produção, você também deve verificar se cada requisito do `spec.md` e cada compromisso de design importante do `plan.md` correspondem a pelo menos uma tarefa concreta, e geralmente a várias. Por exemplo:
- os compromissos de design definidos no arquivo `plan.md` devem ter tarefas de implementação correspondentes
- os critérios de aceitação das histórias do usuário devem ter tarefas de implementação e verificação correspondentes
- os requisitos funcionais devem ter tarefas de implementação correspondentes
- os requisitos de segurança devem ter tarefas de implementação correspondentes
- os requisitos de desempenho devem ter tarefas de teste correspondentes

7. Aceite as alterações de arquivo sugeridas e, em seguida, salve o arquivo `tasks.md`.

8. Salve as alterações, faça commit e sincronize as atualizações.

O arquivo `tasks.md` agora fornece um roteiro claro para a implementação.

