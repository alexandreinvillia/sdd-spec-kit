# Tasks: MVP de Assinaturas de Feed RSS

**Input**: Design documents from `/specs/002-generate-implementation-plan/`
**Prerequisites**: plan.md (required), spec.md (required), research.md, data-model.md, contracts/, quickstart.md

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Inicializar solução .NET e estrutura base dos projetos frontend/backend/shared/testes.

- [X] T001 Criar solução raiz em `RSSFeedReader.sln`
- [X] T002 Criar projeto API em `backend/RSSFeedReader.Api/RSSFeedReader.Api.csproj`
- [X] T003 [P] Criar projeto frontend Blazor WebAssembly em `frontend/RSSFeedReader.UI/RSSFeedReader.UI.csproj`
- [X] T004 [P] Criar projeto de contratos compartilhados em `shared/RSSFeedReader.Contracts/RSSFeedReader.Contracts.csproj`
- [X] T005 [P] Criar projeto de testes unitários da API em `tests/RSSFeedReader.Api.Tests/RSSFeedReader.Api.Tests.csproj`
- [X] T006 [P] Criar projeto de testes de integração da API em `tests/RSSFeedReader.Api.IntegrationTests/RSSFeedReader.Api.IntegrationTests.csproj`
- [X] T007 Adicionar todos os projetos na solução em `RSSFeedReader.sln`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Implementar infraestrutura comum que bloqueia qualquer user story.

**⚠️ CRITICAL**: Nenhuma user story deve começar antes desta fase.

- [X] T008 Configurar CORS por origem explícita e pipeline HTTP em `backend/RSSFeedReader.Api/Program.cs`
- [X] T009 [P] Definir modelos de contrato `Subscription`, `CreateSubscriptionRequest` e `ErrorResponse` em `shared/RSSFeedReader.Contracts/Models/`
- [X] T010 [P] Definir interface `ISubscriptionService` em `backend/RSSFeedReader.Api/Services/ISubscriptionService.cs`
- [X] T011 Implementar serviço em memória base em `backend/RSSFeedReader.Api/Services/InMemorySubscriptionService.cs`
- [X] T012 Registrar serviços e contratos compartilhados na API em `backend/RSSFeedReader.Api/RSSFeedReader.Api.csproj`
- [X] T013 Configurar `ApiBaseUrl` e opções de ambiente em `frontend/RSSFeedReader.UI/wwwroot/appsettings.json`
- [X] T014 Implementar cliente HTTP base para API em `frontend/RSSFeedReader.UI/Services/SubscriptionsApiClient.cs`
- [X] T015 Configurar injeção de dependência do `HttpClient` e serviços frontend em `frontend/RSSFeedReader.UI/Program.cs`
- [X] T016 Criar classe utilitária de validação/normalização de URL em `backend/RSSFeedReader.Api/Services/SubscriptionUrlValidator.cs`

**Checkpoint**: Base pronta para implementar histórias de usuário de forma independente.

---

## Phase 3: User Story 1 - Adicionar assinatura por URL (Priority: P1) 🎯 MVP

**Goal**: Permitir criação de assinatura via endpoint REST com validação de URL e tratamento semântico de erros.

**Independent Test**: Enviar `POST /subscriptions` com URL válida e inválida e validar respostas `201` e `400`; enviar duplicada e validar `409`.

### Tests for User Story 1

- [X] T017 [P] [US1] Criar testes unitários de validação de URL em `tests/RSSFeedReader.Api.Tests/Services/SubscriptionUrlValidatorTests.cs`
- [X] T018 [P] [US1] Criar testes unitários de criação e duplicidade no serviço em `tests/RSSFeedReader.Api.Tests/Services/InMemorySubscriptionServiceCreateTests.cs`
- [X] T019 [US1] Criar testes de integração para `POST /subscriptions` em `tests/RSSFeedReader.Api.IntegrationTests/SubscriptionsCreateEndpointTests.cs`

### Implementation for User Story 1

- [X] T020 [P] [US1] Implementar regra de validação HTTP/HTTPS e trim no serviço em `backend/RSSFeedReader.Api/Services/InMemorySubscriptionService.cs`
- [X] T021 [US1] Implementar endpoint `POST /subscriptions` em `backend/RSSFeedReader.Api/Controllers/SubscriptionsController.cs`
- [X] T022 [US1] Implementar mapeamento de erros `INVALID_URL` e `DUPLICATE_SUBSCRIPTION` em `backend/RSSFeedReader.Api/Controllers/SubscriptionsController.cs`
- [X] T023 [US1] Atualizar contrato OpenAPI do endpoint de criação em `specs/002-generate-implementation-plan/contracts/subscriptions-api.yaml`

**Checkpoint**: US1 funcional e testável isoladamente.

---

## Phase 4: User Story 2 - Visualizar lista de assinaturas (Priority: P1)

**Goal**: Retornar a lista atual de assinaturas em memória, incluindo estado vazio sem erro.

**Independent Test**: Criar assinaturas e consultar `GET /subscriptions` validando retorno completo; validar lista vazia quando não há dados.

### Tests for User Story 2

- [X] T024 [P] [US2] Criar testes unitários de listagem no serviço em `tests/RSSFeedReader.Api.Tests/Services/InMemorySubscriptionServiceListTests.cs`
- [X] T025 [US2] Criar testes de integração para `GET /subscriptions` em `tests/RSSFeedReader.Api.IntegrationTests/SubscriptionsListEndpointTests.cs`

### Implementation for User Story 2

- [X] T026 [US2] Implementar método de listagem ordenada no serviço em `backend/RSSFeedReader.Api/Services/InMemorySubscriptionService.cs`
- [X] T027 [US2] Implementar endpoint `GET /subscriptions` em `backend/RSSFeedReader.Api/Controllers/SubscriptionsController.cs`
- [X] T028 [US2] Atualizar contrato OpenAPI do endpoint de listagem em `specs/002-generate-implementation-plan/contracts/subscriptions-api.yaml`

**Checkpoint**: US2 funcional e testável independentemente da UI.

---

## Phase 5: User Story 3 - Interação básica no frontend (Priority: P2)

**Goal**: Permitir adicionar URL e visualizar atualização da lista na interface Blazor sem recarga manual.

**Independent Test**: Executar frontend e backend, submeter URL válida na UI e verificar atualização; submeter inválida e verificar mensagem de erro.

### Tests for User Story 3

- [X] T029 [P] [US3] Criar projeto de testes do frontend em `tests/RSSFeedReader.UI.Tests/RSSFeedReader.UI.Tests.csproj`
- [X] T030 [US3] Criar testes do cliente HTTP de assinaturas em `tests/RSSFeedReader.UI.Tests/Services/SubscriptionsApiClientTests.cs`

### Implementation for User Story 3

- [X] T031 [P] [US3] Criar modelo de view state para assinaturas em `frontend/RSSFeedReader.UI/Models/SubscriptionViewModel.cs`
- [X] T032 [US3] Implementar página com formulário e listagem em `frontend/RSSFeedReader.UI/Pages/Subscriptions.razor`
- [X] T033 [US3] Implementar code-behind para carregamento e submit em `frontend/RSSFeedReader.UI/Pages/Subscriptions.razor.cs`
- [X] T034 [US3] Implementar mensagens simples de erro e estado de carregamento em `frontend/RSSFeedReader.UI/Pages/Subscriptions.razor`
- [X] T035 [US3] Configurar rota inicial para tela de assinaturas em `frontend/RSSFeedReader.UI/App.razor`

**Checkpoint**: Fluxo ponta a ponta (adicionar + listar via UI) funcional.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Ajustes finais de qualidade, documentação e validação do fluxo completo.

- [X] T036 [P] Atualizar instruções de execução e arquitetura em `README.md`
- [X] T037 Validar e alinhar quickstart com portas/configuração reais em `specs/002-generate-implementation-plan/quickstart.md`
- [X] T038 Executar suíte de testes e corrigir quebras em `tests/`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: sem dependências.
- **Phase 2 (Foundational)**: depende da Phase 1 e bloqueia todas as user stories.
- **Phase 3 (US1)**: depende da conclusão da Phase 2.
- **Phase 4 (US2)**: depende da conclusão da Phase 2; pode evoluir em paralelo com US1 após fundação, mas prioridade de entrega recomenda US1 primeiro.
- **Phase 5 (US3)**: depende da conclusão de US1 e US2 para fluxo ponta a ponta.
- **Phase 6 (Polish)**: depende das histórias concluídas.

### User Story Dependencies

- **US1 (P1)**: sem dependência de outras histórias após fase fundacional.
- **US2 (P1)**: sem dependência funcional de US1, mas compartilha o mesmo serviço de assinaturas.
- **US3 (P2)**: depende de endpoints de criação/listagem disponíveis (US1 + US2).

### Parallel Opportunities

- Setup: T003, T004, T005 e T006 em paralelo após T001.
- Foundational: T009 e T010 em paralelo; T013 e T016 em paralelo.
- US1: T017 e T018 em paralelo antes de T019.
- US2: T024 pode rodar em paralelo ao início de T025.
- US3: T031 pode iniciar em paralelo à base de testes T029/T030.

---

## Parallel Example: User Story 1

```bash
# Testes em paralelo para US1
T017: tests/RSSFeedReader.Api.Tests/Services/SubscriptionUrlValidatorTests.cs
T018: tests/RSSFeedReader.Api.Tests/Services/InMemorySubscriptionServiceCreateTests.cs

# Implementação paralela após testes
T020: backend/RSSFeedReader.Api/Services/InMemorySubscriptionService.cs
T023: specs/002-generate-implementation-plan/contracts/subscriptions-api.yaml
```

## Parallel Example: User Story 2

```bash
# Testes e implementação inicial em paralelo controlado
T024: tests/RSSFeedReader.Api.Tests/Services/InMemorySubscriptionServiceListTests.cs
T026: backend/RSSFeedReader.Api/Services/InMemorySubscriptionService.cs
```

## Parallel Example: User Story 3

```bash
# Frontend e testes do cliente em trilhas separadas
T030: tests/RSSFeedReader.UI.Tests/Services/SubscriptionsApiClientTests.cs
T031: frontend/RSSFeedReader.UI/Models/SubscriptionViewModel.cs
```

---

## Implementation Strategy

### MVP First (US1)

1. Finalizar Setup (Phase 1).
2. Finalizar Foundational (Phase 2).
3. Entregar US1 (Phase 3).
4. Validar endpoint de criação isoladamente antes de avançar.

### Incremental Delivery

1. Entregar US1 (criação).
2. Entregar US2 (listagem).
3. Entregar US3 (UI integrada).
4. Finalizar com polish e validação completa.

### Suggested MVP Scope

- **MVP recomendado**: concluir até o fim da **Phase 3 (US1)**.
- **MVP funcional ampliado**: concluir até o fim da **Phase 4 (US2)** para API completa de assinaturas.
