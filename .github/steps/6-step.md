## Etapa 6: Implementar as tarefas necessárias para um aplicativo MVP

Com uma especificação clara, um plano técnico e um documento de tarefas em mãos, você está pronto para implementar o aplicativo RSS.

O arquivo tasks.md fornece uma estratégia de implementação em fases que divide o trabalho em partes gerenciáveis. A implementação pode ser abordada de diferentes maneiras, dependendo das prioridades e restrições do projeto. Por exemplo, você pode considerar uma das seguintes estratégias:

    Implementar os recursos do aplicativo de forma incremental, uma fase por vez.
    Implementar todo o aplicativo em uma única passagem.
    Implementar primeiro os recursos do aplicativo MVP e, depois, expandir para recursos adicionais.

O fluxo implement do GitHub Spec Kit demonstra como usar o arquivo tasks.md para orientar o processo de implementação.

### ⌨️ Atividade 1: Construindo as tarefas da aplicação  

Nesta tarefa, você revisa a estratégia de implementação e, em seguida, usa speckit/implement para implementar a versão MVP do aplicativo (a capacidade de adicionar e visualizar assinaturas).

Use as etapas a seguir para concluir esta tarefa:

1. Abra o arquivo `tasks.md`, localize a seção Implementation Strategy e revise a estratégia de MVP sugerida.

A estratégia MVP (ou MVP First) tem como objetivo entregar um aplicativo funcional o mais rápido possível. Ela deve se concentrar em concluir primeiro as fases Setup (inicialização) e Foundational (bloqueadora), antes de desenvolver a primeira User Story (US1).

Por exemplo, a estratégia de implementação do MVP (a capacidade de adicionar e visualizar assinaturas) pode ser semelhante ao exemplo a seguir:

- Fases: Setup → Foundation → apenas US1
- Tarefas: T001 - T050 (50 tarefas)
- Entrega: Os usuários podem adicionar uma URL de feed válida; atualizar; ver os itens; reiniciar e confirmar persistência.

A estratégia MVP First nem sempre se limita à primeira user story. Dependendo da complexidade do recurso, ela pode incluir várias user stories. Elas devem ser listadas sequencialmente após a fase Foundational e marcadas claramente como parte da estratégia de implementação MVP.

2. Na visualização Chat, insira um comando que inicie o fluxo implement para a estratégia MVP First:

Crie um comando que especifique o intervalo de tarefas necessário para implementar a versão MVP do recurso. Use o intervalo de tarefas especificado na seção Implementation Strategy do arquivo `tasks.md`, ou calcule-o com base nas tarefas listadas em cada fase.

> [!IMPORTANT] 
> O comando inserido deve referenciar o intervalo de tarefas específico definido no seu arquivo `tasks.md`.

Por exemplo (referenciando o exemplo de implementação MVP da etapa anterior), você pode inserir o seguinte comando:
```bash 
/speckit.implement Implementar a estratégia MVP First (Tarefas: T001 - T050)
```

Esse comando instrui o GitHub Copilot a começar a implementar as tarefas necessárias para a estratégia MVP First do aplicativo RSS Feed Reader.

Neste exercício, você implementa todas as tarefas da estratégia MVP First usando um único comando `/speckit.implement`. Em um ambiente de produção, você provavelmente seguiria uma abordagem em fases, como implementar primeiro as tarefas das fases Setup e Foundational e, depois, implementar as tarefas de cada fase de User Story, uma por vez.

3. Monitore a resposta do GitHub Copilot e forneça assistência na visualização Chat.

O agente constrói o aplicativo incrementalmente, tarefa por tarefa, seguindo a ordem definida no arquivo `tasks.md`.

> [!NOTE] 
> O GitHub Copilot exibe solicitações frequentes de assistência durante a fase de implementação. O tempo necessário para concluir a implementação pode ser afetado pela rapidez com que você responde às solicitações de assistência/permissão.

4. Continue monitorando o fluxo de implementação até que todas as tarefas necessárias para o aplicativo MVP sejam concluídas.

O GitHub Copilot deve notificar na visualização Chat quando os aplicativos de backend e frontend estiverem concluídos.

5. Aceite todas as alterações feitas nos arquivos do projeto.

Para este exercício de laboratório, tudo bem aceitar todas as alterações feitas pelo GitHub Copilot sem revisão. No entanto, em um ambiente de produção, é importante revisar cuidadosamente todas as alterações de código para garantir que atendam aos padrões de qualidade e estejam alinhadas aos requisitos do projeto.

6. Salve todos os arquivos atualizados.

7. Inicie o aplicativo backend e, em seguida, inicie o aplicativo frontend.

Você pode usar um terminal dividido para executar ambos os aplicativos lado a lado. Garanta que ambos iniciem sem erros. Se tiver dúvidas, você pode pedir ao GitHub Copilot os comandos necessários para iniciar os dois aplicativos.

Se algum dos aplicativos falhar ao iniciar, relate o problema ao GitHub Copilot na visualização Chat. Forneça uma descrição detalhada do problema, incluindo quaisquer mensagens de erro ou logs que possam ajudar a diagnosticar a falha. O GitHub Copilot usará essas informações para começar a depuração e resolver o problema.

8. Verifique se o aplicativo frontend abre com sucesso no navegador.

O GitHub Copilot deve especificar na visualização Chat uma URL de frontend semelhante à seguinte:
> http://localhost:5213.

Se o aplicativo frontend apresentar um erro na UI ao abrir, descreva o problema em detalhes ao GitHub Copilot.

Por exemplo:
 - Você inicia o aplicativo backend. O backend está em execução localmente em http://localhost:5151.
 - Você inicia o aplicativo frontend. O frontend está em execução localmente em http://localhost:5213.
 - Você abre um navegador e acessa a URL especificada para o aplicativo frontend.
 - Quando a página carrega, ela exibe um erro: “An unhandled error has occurred. Reload”.
 - Você seleciona a opção “Reload”, mas o erro persiste.
 - Você abre o console das ferramentas de desenvolvedor do navegador para investigar mais a fundo.


<details>
<summary>No console das ferramentas de desenvolvedor, você vê a seguinte mensagem de erro:</summary><br/>
 
    "Microsoft.AspNetCore.Components.WebAssembly.Rendering.WebAssemblyRenderer[100]
    Unhandled exception rendering component: The following routes are ambiguous:
    '' in 'RSSFeedReader.UI.Pages.Home'
    '' in 'RSSFeedReader.UI.Pages.Subscriptions'
                    
    System.InvalidOperationException: The following routes are ambiguous:
    '' in 'RSSFeedReader.UI.Pages.Home'
    '' in 'RSSFeedReader.UI.Pages.Subscriptions'
                    
    at Microsoft.AspNetCore.Components.RouteTableFactory.DetectAmbiguousRoutes(:5213/TreeRouteBuilder builder)
    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/Dictionary2 templatesByHandler, IServiceProvider serviceProvider)    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/List1 componentTypes, IServiceProvider serviceProvider)
    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/RouteKey routeKey, IServiceProvider serviceProvider)
    at Microsoft.AspNetCore.Components.Routing.Router.RefreshRouteTable((index))
    at Microsoft.AspNetCore.Components.Routing.Router.Refresh(:5213/Boolean isNavigationIntercepted)
    at Microsoft.AspNetCore.Components.Routing.Router.RunOnNavigateAsync(:5213/String path, Boolean isNavigationIntercepted)
    at Microsoft.AspNetCore.Components.Routing.Router.<>c__DisplayClass82_0.<RunOnNavigateAsync>b__1(:5213/RenderTreeBuilder builder)
    at Microsoft.AspNetCore.Components.Rendering.ComponentState.RenderIntoBatch(:5213/RenderBatchBuilder batchBuilder, RenderFragment renderFragment, Exception& renderFragmentException)"

</details>

Você relata o problema ao GitHub Copilot na visualização Chat.


<details>
<summary>No console das ferramentas de desenvolvedor, você vê a seguinte mensagem de erro:</summary><br/>
 
    I was able to start the backend and frontend apps successfully. I opened the frontend app in the browser at http://localhost:5213. When the page opens, I see an error message: "An unhandled error has occurred. Reload". Selecting reload doesn't resolve the issue. When I check the browser's developer tools console, I see the following error message: 

    "Microsoft.AspNetCore.Components.WebAssembly.Rendering.WebAssemblyRenderer[100]
    Unhandled exception rendering component: The following routes are ambiguous:
    '' in 'RSSFeedReader.UI.Pages.Home'
    '' in 'RSSFeedReader.UI.Pages.Subscriptions'
                    
    System.InvalidOperationException: The following routes are ambiguous:
    '' in 'RSSFeedReader.UI.Pages.Home'
    '' in 'RSSFeedReader.UI.Pages.Subscriptions'
                    
    at Microsoft.AspNetCore.Components.RouteTableFactory.DetectAmbiguousRoutes(:5213/TreeRouteBuilder builder)
    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/Dictionary2 templatesByHandler, IServiceProvider serviceProvider)    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/List1 componentTypes, IServiceProvider serviceProvider)
    at Microsoft.AspNetCore.Components.RouteTableFactory.Create(:5213/RouteKey routeKey, IServiceProvider serviceProvider)
    at Microsoft.AspNetCore.Components.Routing.Router.RefreshRouteTable((index))
    at Microsoft.AspNetCore.Components.Routing.Router.Refresh(:5213/Boolean isNavigationIntercepted)
    at Microsoft.AspNetCore.Components.Routing.Router.RunOnNavigateAsync(:5213/String path, Boolean isNavigationIntercepted)
    at Microsoft.AspNetCore.Components.Routing.Router.<>c__DisplayClass82_0.<RunOnNavigateAsync>b__1(:5213/RenderTreeBuilder builder)
    at Microsoft.AspNetCore.Components.Rendering.ComponentState.RenderIntoBatch(:5213/RenderBatchBuilder batchBuilder, RenderFragment renderFragment, Exception& renderFragmentException)".
 
</details>

O GitHub Copilot analisa as informações fornecidas e começa a depurar o problema.

Quando você relata um problema, o GitHub Copilot usa as informações que você forneceu para iniciar a depuração. Uma descrição detalhada, incluindo o que está funcionando, ajuda o GitHub Copilot a entender melhor o problema. O GitHub Copilot pode precisar de detalhes extras, como mensagens de erro específicas, para resolver alguns problemas. Forneça quaisquer informações adicionais solicitadas pelo GitHub Copilot para ajudar a diagnosticar (e resolver) o problema.

Continue fornecendo assistência até que o problema seja resolvido. Depois que o problema for resolvido, o GitHub Copilot deve solicitar que você retome os testes manuais.

9. Reserve alguns minutos para verificar se o aplicativo frontend está funcionando conforme o esperado.

Use as seguintes URLs de feed para testar o aplicativo:
- https://devblogs.microsoft.com/dotnet/feed/
- https://devblogs.microsoft.com/visualstudio/feed/

Você pode encontrar os cenários de aceitação no arquivo `spec.md`, na seção User Scenarios & Testing.

Por exemplo, os cenários de aceitação para o aplicativo MVP podem ser semelhantes ao exemplo a seguir:
- **Dado que** nenhuma assinatura foi adicionada, **Quando** o usuário carrega a página, **Então** um estado vazio é exibido (por exemplo, mensagem “No subscriptions yet”)
- **Dado que** a interface de gerenciamento de assinaturas está carregada, **Quando** o usuário insere uma URL de feed válida no campo de entrada e clica em “Add Subscription”, **Então** o sistema aceita a URL e confirma que a assinatura foi adicionada
- **Dado que** o usuário inseriu uma URL de feed, **Quando** o usuário envia o formulário, **Então** o campo de entrada é limpo e fica pronto para outra URL
- **Dado que** o usuário insere uma string vazia ou apenas com espaços em branco, **Quando** tenta adicionar a assinatura, **Então** o sistema impede o envio (validação básica no cliente)
- **Dado que** o usuário adicionou uma assinatura, **Quando** a página é exibida, **Então** a URL da assinatura fica visível na lista
- **Dado que** o usuário adicionou várias assinaturas, **Quando** a página é exibida, **Então** todas as URLs de assinatura ficam visíveis na lista, na ordem em que foram adicionadas (mais recentes por último)

Você também pode pedir ao GitHub Copilot as etapas necessárias para realizar testes manuais da sua implementação MVP. Por exemplo, você pode inserir o seguinte prompt na visualização Chat:

```bash 
Você pode fornecer as etapas necessárias para testar manualmente a implementação do MVP?
```

Use o Visual Studio Code para executar o aplicativo e, em seguida, teste manualmente a funcionalidade do RSS Feed Reader para garantir que ela funcione como esperado.

10. Continue testando o frontend (e reportando quaisquer problemas ao GitHub Copilot) até que todos os cenários de aceitação do aplicativo MVP sejam aprovados com sucesso.

> [!IMPORTANT] 
> O processo de implementação pode ser iterativo e pode exigir várias rodadas de testes e depuração.
> Uma comunicação clara com o GitHub Copilot é essencial para uma solução de problemas eficaz.
> Testes abrangentes garantem que o aplicativo MVP atenda aos requisitos especificados e funcione conforme o esperado.

