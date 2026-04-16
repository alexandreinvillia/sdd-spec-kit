# Stack de tecnologia para o Leitor de Feed RSS

Nosso leitor de feed RSS usará um backend ASP.NET Core Web API e um frontend Blazor WebAssembly. Essa combinação permite desenvolvimento rápido do MVP, ao mesmo tempo em que suporta melhorias futuras prontas para produção.

## Por que ASP.NET Core Web API + Blazor WebAssembly?

Construir um leitor de feed RSS com backend **ASP.NET Core Web API** e frontend **Blazor WebAssembly** oferece várias vantagens:

1. **Desenvolvimento rápido**: as duas tecnologias funcionam bem juntas com configuração mínima, permitindo criar a demonstração rapidamente.

2. **Separação de responsabilidades**: o backend cuida do gerenciamento de dados e (no MVP Estendido) das operações de feed, enquanto o frontend foca na interação com o usuário.

3. **Multiplataforma**: tanto ASP.NET Core quanto Blazor são multiplataforma, permitindo execução em Windows, macOS e Linux.

4. **Complexidade incremental**: comece com gerenciamento simples de assinaturas (MVP), depois adicione busca de feed (MVP Estendido), então adicione persistência e recursos avançados.

5. **Arquitetura preparada para o futuro**: embora o MVP seja mínimo (apenas gerenciamento da lista de assinaturas), essa arquitetura suporta adicionar:

   - Busca e parsing de feed (`System.ServiceModel.Syndication`)
   - Persistência em banco de dados (EF Core + SQLite)
   - Processamento em segundo plano (`BackgroundService` para polling)
   - Recursos avançados (lido/não lido, pastas etc.)

6. **Código compartilhado**: Blazor WebAssembly usa C#, permitindo compartilhamento de código entre frontend e backend quando necessário.

## Responsabilidades

Para o MVP (somente gerenciamento de assinaturas):

**Backend** é responsável por:

- Expor uma API para adicionar assinaturas
- Armazenar assinaturas em memória
- Retornar a lista de assinaturas

**Frontend** é responsável por:

- Interface de gerenciamento de assinaturas (campo de entrada + botão adicionar)
- Exibir a lista de assinaturas

Para o MVP Estendido (adicionar busca de feed):

**Backend** adiciona:

- Buscar e fazer parsing de feeds RSS/Atom quando solicitado
- Retornar itens de feed para a interface

**Frontend** adiciona:

- Botão de atualização manual
- Exibição de itens (no mínimo título e link)
- Mensagens básicas de erro

## Abordagem de implementação com foco no MVP

Para entregar o MVP rapidamente:

**MVP (somente gerenciamento de assinaturas):**

- **Armazenamento**: usar armazenamento em memória (List<string> ou modelo simples). As assinaturas são perdidas quando o app é encerrado.
- **Sem operações de feed**: sem cliente HTTP, sem biblioteca de parsing, sem busca de feed
- **Foco**: interface básica e comunicação com API (adicionar assinatura, obter lista de assinaturas)

**MVP Estendido (adicionar busca de feed):**

- **Parsing**: adicionar `System.ServiceModel.Syndication` para parsing básico de RSS/Atom
- **Cliente HTTP**: adicionar HttpClient para buscar feeds
- **Atualização**: apenas manual - sem polling em segundo plano ou agendamento
- **Tratamento de erros**: mensagens simples de "falha ao carregar", sem diagnóstico detalhado
- **Exibição de conteúdo**: apenas texto simples (título + link), sem necessidade de renderização HTML

Essa abordagem incremental torna o desenvolvimento extremamente rápido e mantém a arquitetura limpa para melhorias futuras.

## Desenvolvimento local

### Inicialização do projeto Blazor

Ao criar um novo projeto Blazor WebAssembly a partir do template, o projeto inclui páginas de demonstração que devem ser removidas para evitar conflitos com os recursos do MVP.

**⚠️ CRÍTICO: essa limpeza deve ser concluída na Fase 2 (Fundacional) e VERIFICADA antes de iniciar qualquer implementação de recurso de UI. Erros de runtime por limpeza incompleta desperdiçam tempo de desenvolvimento.**

**Etapas obrigatórias de limpeza:**

1. **Remover páginas de demonstração do template** de `frontend/[ProjectName].UI/Pages/`:
   - Excluir `Home.razor` (conflita com a rota raiz)
   - Excluir `Counter.razor` (página de demonstração)
   - Excluir `Weather.razor` (página de demonstração)

2. **Atualizar menu de navegação** em `frontend/[ProjectName].UI/Layout/NavMenu.razor`:
   - Remover links de navegação para páginas de demonstração excluídas
   - Atualizar itens do menu para refletirem apenas os recursos do MVP
   - Alterar o texto do link de navegação raiz para corresponder à sua página inicial (ex.: "Assinaturas")

3. **Verificar roteamento**:
   - Garantir que apenas UMA página use a diretiva `@page "/"` (sua página principal do MVP)
   - Todas as outras páginas devem usar rotas únicas (ex.: `@page "/settings"`)

4. **Verificar a conclusão da limpeza** antes de prosseguir com a implementação:

   ```powershell
   # Liste todas as páginas Razor - deve mostrar SOMENTE suas páginas do MVP (ex.: NotFound.razor, Subscriptions.razor)
   Get-ChildItem frontend/[ProjectName].UI/Pages/ -Filter *.razor | Select-Object Name
   ```

   **PARE: não prossiga com implementação de recursos até que:**
   - ✗ Home.razor tenha sido REMOVIDO
   - ✗ Counter.razor tenha sido REMOVIDO
   - ✗ Weather.razor tenha sido REMOVIDO
   - ✓ Apenas as páginas do MVP permaneçam

5. **Teste conflitos de rota imediatamente** após a limpeza:

   ```powershell
   # Build limpo para remover assemblies em cache
   dotnet clean frontend/[ProjectName].UI/[ProjectName].UI.csproj
   dotnet build frontend/[ProjectName].UI/[ProjectName].UI.csproj

   # Inicie o frontend para verificar ausência de erros de rota
   dotnet run --project frontend/[ProjectName].UI
   ```

   Navegue para a URL do frontend no navegador. Se você vir um erro de "ambiguous route" no console do navegador (DevTools F12), a limpeza está incompleta. **Corrija o problema antes de implementar qualquer recurso.**

**Por que isso importa:**

Templates Blazor incluem páginas de demonstração com rotas pré-configuradas. Se você criar novas páginas com as mesmas rotas (especialmente a rota raiz `/`), encontrará **exceções de rota ambígua** em runtime. A mensagem de erro será parecida com:

```
System.InvalidOperationException: The following routes are ambiguous:
'' in '[ProjectName].UI.Pages.Home'
'' in '[ProjectName].UI.Pages.YourFeature'
```

Esses erros aparecem apenas em runtime, depois que você já implementou recursos, tornando a depuração custosa. As etapas de verificação acima detectam esse problema imediatamente durante a limpeza da Fase 2, antes de qualquer trabalho de funcionalidade.

Limpar as páginas do template antes de implementar os recursos do MVP previne esses conflitos e garante uma estrutura de projeto limpa, focada nos requisitos de negócio.

### Configuração de portas

A API de backend e a UI de frontend executam em portas localhost separadas. **Consistência de portas é crítica** - as portas devem ser coordenadas entre três locais:

1. **Porta do backend** (definida em `backend/RSSFeedReader.Api/Properties/launchSettings.json`):

   - Padrão: `http://localhost:5151`
   - É aqui que a API escuta requisições

2. **Porta do frontend** (definida em `frontend/RSSFeedReader.UI/Properties/launchSettings.json`):

   - Padrão: `http://localhost:5213`
   - É aqui que o app Blazor executa

3. **URL base da API** (configurada em `frontend/RSSFeedReader.UI/wwwroot/appsettings.json`):

   - Deve corresponder à porta do backend da etapa 1
   - Exemplo: `{"ApiBaseUrl": "http://localhost:5151/api/"}`

4. **Política de CORS** (configurada em `backend/RSSFeedReader.Api/Program.cs`):

   - Deve permitir a porta do frontend da etapa 2
   - Exemplo: `.WithOrigins("http://localhost:5213", "https://localhost:7025")`

### Boas práticas de configuração

- **Frontend Program.cs**: leia a URL da API a partir da configuração, não codifique de forma fixa:

  ```csharp
  var apiBaseUrl = builder.Configuration["ApiBaseUrl"] ?? "http://localhost:5151/api/";
  builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(apiBaseUrl) });
  ```

- **CORS do backend**: permitir as portas reais do frontend vindas do launchSettings.json

- **Setup de testes**: antes de testar, verifique:

  1. O backend está em execução e acessível na porta configurada
  2. O appsettings.json do frontend aponta para a porta correta do backend
  3. O CORS permite a origem do frontend

**Para o MVP:** teste adicionando URLs de assinatura e verificando que aparecem na lista.

**Para o MVP Estendido:** teste com um feed válido conhecido como <https://devblogs.microsoft.com/dotnet/feed/>

## Melhorias futuras (pós-MVP)

Quando estiver pronto para evoluir além da demonstração básica, esta arquitetura suporta:

- **Persistência em banco de dados**: adicionar EF Core + SQLite para armazenar assinaturas e itens entre sessões
- **Polling em segundo plano**: implementar `BackgroundService` para atualizar feeds automaticamente em um agendamento
- **Sanitização de HTML**: adicionar biblioteca `HtmlSanitizer` para exibir com segurança conteúdo rico dos feeds
- **Descoberta de feed a partir de website**: usar `HtmlAgilityPack` para encontrar URLs de feed em links de sites
- **Melhor tratamento de erros**: implementar lógica de retentativa, timeouts e mensagens detalhadas de erro
- **Testes**: adicionar testes unitários e de integração com xUnit
- **Otimização**: implementar cache HTTP (ETag/Last-Modified), desduplicação e melhorias de desempenho

## Resumo

ASP.NET Core Web API com Blazor WebAssembly oferece um caminho direto para construir o leitor de feed RSS de forma incremental:

- **MVP**: somente gerenciamento de assinaturas (adicionar + listar) - extremamente simples, sem operações de feed
- **MVP Estendido**: adicionar busca de feed e exibição de itens - ainda simples com armazenamento em memória e atualização manual
- **Futuro**: adicionar persistência, processamento em segundo plano e recursos avançados

A arquitetura é intencionalmente mínima para permitir desenvolvimento rápido, enquanto as escolhas de tecnologia suportam a adição de recursos prontos para produção depois, sem exigir reescrita completa.
