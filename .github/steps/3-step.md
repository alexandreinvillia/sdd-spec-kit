## Etapa 3: Gerar o arquivo spec.md usando a documentação do stakeholder

A especificação (spec.md) define o que você está construindo sob a perspectiva do usuário. Ela descreve os recursos, histórias de usuário, critérios de aceitação e requisitos de negócio sem prescrever como implementá-los. Uma spec bem escrita serve como base para criar o plano de implementação e as tarefas.


### ⌨️ Atividade 1: Construindo a spec do documento

Nesta tarefa, você usará o comando `/speckit.specify` do GitHub Copilot para gerar uma especificação detalhada para o RSS com base nos requisitos fornecidos pelas partes interessadas de negócio.
 
Use os passos a seguir para concluir esta tarefa:

1. Use a visualização EXPLORER do Visual Studio Code para examinar os arquivos `spec-template.md` e `speckit.specify.agent.md`.

2. Observe os seguintes pontos sobre esses arquivos:
   O arquivo `spec-template.md` define a estrutura e as seções de um documento de especificação. Ele inclui exemplos e/ou espaços reservados para descrições de recursos, histórias de usuário, critérios de aceitação e outras informações relevantes.
   O arquivo `speckit.specify.agent.md` fornece instruções detalhadas para o comando `/speckit.specify`. Ele orienta o GitHub Copilot sobre como criar uma especificação com base nos requisitos fornecidos.
   O arquivo `speckit.specify.agent.md` gera uma branch de repositório no início do workflow. Criar uma branch geralmente exige permissões do usuário, então o GitHub Copilot solicita permissão quando o workflow é executado.

3. Use a visualização EXPLORER do Visual Studio Code para examinar os documentos das partes interessadas `ProjectGoals.md` e `AppFeatures.md`.

O arquivo `AppFeatures.md` é sua principal fonte para requisitos de recursos voltados ao usuário e fornece o contexto necessário para criar uma especificação abrangente. O arquivo `ProjectGoals.md` traz informações sobre o MVP e o plano de rollout que também podem ajudar a orientar a especificação.

4. Crie uma descrição resumida do aplicativo RSS com base nos documentos das partes interessadas.

A descrição resumida deve ser concisa (uma ou duas frases) e capturar a funcionalidade central do aplicativo RSS. Por exemplo:

> "Leitor RSS MVP: um leitor de feed RSS/Atom simples que demonstra a capacidade mais básica (adicionar assinaturas) sem a complexidade de um aplicativo pronto para produção."

Feche quaisquer arquivos que estejam abertos no editor.

Garanta que a visualização Chat esteja aberta.

5. Observe que o GitHub Copilot mantém o contexto de interações anteriores na sessão de chat atual. Se você gerou o arquivo `constitution.md` na sessão atual, o GitHub Copilot mostra um botão **Build Specification** próximo à parte inferior da visualização Chat, que poderia ser usado para iniciar a geração da especificação. Neste caso, você quer fornecer o documento de requisitos explicitamente, então não use o botão **Build Specification**.

6. Na visualização Chat, para iniciar um workflow de especificação que gere um arquivo `spec.md` usando informações do documento das partes interessadas, digite o seguinte comando: 

```bash
/speckit.specify --text "Leitor RSS MVP: um leitor de feed RSS/Atom simples que demonstra a capacidade mais básica (adicionar assinaturas) sem a complexidade de um aplicativo pronto para produção." --files StakeholderDocuments/ProjectGoals.md StakeholderDocuments/AppFeatures.md

```
Se você não especificar a opção `--text`, talvez seja solicitado a fornecer uma descrição dos recursos do aplicativo antes de continuar.

Monitore a resposta do GitHub Copilot e forneça assistência conforme necessário.

> [!IMPORTANT]
> Importante: o GitHub Copilot solicita assistência ao gerar o arquivo `spec.md`. Por exemplo, o GitHub Copilot solicita permissão para criar uma nova branch no repositório. Conceda permissão quando necessário respondendo na visualização Chat.

Pode levar de 4 a 6 minutos para criar o arquivo `spec.md` e o checklist de requisitos usado para validar sua especificação. Se o processo do workflow ficar inativo por mais de 6 minutos sem reportar conclusão bem-sucedida, você pode usar o comando retry do GitHub Copilot para reiniciar o workflow.

> [!TIP] 
> Dica: Para uma melhor performance, utilize de subagentes para realizar tarefas complexas e ou extensas.

Quando o workflow do specify for concluído, use a visualização EXPLORER do Visual Studio Code para expandir as pastas specs e checklists.

Na visualização EXPLORER, selecione `spec.md` e reserve alguns minutos para revisar o arquivo `spec.md`.

O arquivo `spec.md` é baseado no template localizado em `.specify/templates/spec-template.md`. O arquivo `spec.md` atualizado deve incluir uma especificação detalhada do aplicativo RSS com base nos requisitos das partes interessadas que você forneceu.

A especificação deve ser clara, abrangente e bem estruturada. Ela também deve fornecer uma base sólida para criar o plano técnico e as tarefas.

Garanta que o arquivo `spec.md` inclua as seções obrigatórias definidas no template de spec. Por exemplo:
- User Scenarios & Testing: Descrições focadas no usuário sobre as capacidades dos recursos e como testá-los.
- Requirements: Requisitos detalhados que devem ser atendidos, organizados por categoria.
- Success Criteria: Resultados mensuráveis, premissas e itens fora de escopo.

Verifique se as **User Stories** (e **Acceptance Scenarios**) no arquivo `spec.md` são específicas e testáveis:

Os cenários de aceitação devem seguir o formato "Dado que, Quando, Então" (Given-When-Then). 
Eles devem fornecer condições claras de sucesso ou falha. Por exemplo:

| ✅  Bons exemplos:|||
| --- | --- | --- |
| Dado que | Quando | Então |
| o aplicativo está em execução | o usuário insere uma URL de feed RSS válida e a envia | o feed é adicionado à sua lista de assinatura |
| o usuário insere uma URL inválida (não uma URI adequada) | ele tenta enviá-la | ele vê uma mensagem de erro indicando que a URL está malformada |

| ⚠️ EVITE:|||
| --- | --- | --- |
|  **critérios vagos** | **"Atualização que funciona"** | **"Sistema deve ser rápido"** |

Verifique se a seção Requirements do arquivo `spec.md` inclui requisitos-chave do seu documento de requisitos das partes interessadas.

Por exemplo, você deve ver requisitos semelhantes ao exemplo a seguir:
- O sistema DEVE permitir que os usuários adicionem uma assinatura de feed fornecendo um URL de feed.

Na visualização EXPLORER, selecione `requirements.md` e reserve um minuto para revisar o arquivo `requirements.md`.

Verifique se nenhum problema é reportado no arquivo `requirements.md`. Você deve ver que todos os itens do checklist passaram com sucesso.

NOTA: O comando `/speckit.clarify` pode ser usado para identificar ambiguidades, lacunas e áreas subespecificadas na sua especificação. Em um ambiente de produção, recomenda-se executar o processo de clarificação após gerar a especificação inicial para garantir que todos os requisitos estejam claros e completos antes de avançar para a fase de planejamento técnico. Para este exercício de laboratório, você vai pular a etapa de clarificação.

### ⌨️ Atividade 2: Persistindo as alterações e publicando a branch

1. Aceite as atualizações sugeridas dos arquivos e, em seguida, salve os arquivos `spec.md` e `requirements.md`.

2. Faça commit dos arquivos de especificação e publique a nova branch no seu repositório Git.

**Por exemplo:**
>> Abra a visualização SOURCE CONTROL do Visual Studio Code, coloque as alterações em stage, informe uma mensagem de commit como "Adicionado especificação para o App RSS" e publique a nova branch no seu repositório Git.

> [!NOTE] 
> Nota: A especificação define o **"o quê"** sem o **"como"**. Ela não especifica linguagens de programação, frameworks, esquemas de banco de dados nem organização de código - esses detalhes de implementação são definidos nas fases de Plan e Tasks com base nas restrições técnicas da constituição. A spec foca nas necessidades do usuário e nos requisitos de negócio, facilitando a revisão com partes interessadas não técnicas.
 
