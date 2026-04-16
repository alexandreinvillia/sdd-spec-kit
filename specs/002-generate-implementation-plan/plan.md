# Implementation Plan: MVP de Assinaturas de Feed RSS

**Branch**: `002-generate-implementation-plan` | **Date**: 2026-04-16 | **Spec**: `/workspaces/sdd-spec-kit/specs/002-generate-implementation-plan/spec.md`
**Input**: Feature specification from `/specs/002-generate-implementation-plan/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implementar MVP de leitor RSS focado exclusivamente em gerenciamento de assinaturas (adicionar + listar), com backend ASP.NET Core Web API e frontend Blazor WebAssembly, armazenamento em memória e validação mínima de URL (HTTP/HTTPS) compatível com a constituição.

## Technical Context

**Language/Version**: C# 12 com .NET 8 (ASP.NET Core + Blazor WebAssembly)  
**Primary Dependencies**: ASP.NET Core Web API, Blazor WebAssembly, HttpClient (frontend), xUnit (testes), Microsoft.AspNetCore.Mvc.Testing (integração)  
**Storage**: Em memória (`List<Subscription>` via serviço singleton)  
**Testing**: xUnit para unitário e integração de API  
**Target Platform**: Desenvolvimento local em Linux/macOS/Windows; browser moderno para frontend
**Project Type**: Aplicação web com frontend + backend separados  
**Performance Goals**: Listagem e inclusão com resposta < 200ms p95 para até 100 assinaturas locais  
**Constraints**: Sem persistência, sem parsing/busca de feed no MVP, CORS restrito à origem do frontend, validação de URL absoluta HTTP/HTTPS  
**Scale/Scope**: 1 usuário local, até ~100 assinaturas em memória no MVP

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

- Gate 1: Security-First (NÃO NEGOCIÁVEL) - PASS
  - Entrada de URL será validada como URI absoluta HTTP/HTTPS.
  - CORS será configurado por origem explícita para ambiente local.
  - Sem renderização de HTML externo no MVP.
- Gate 2: Separação de Responsabilidades - PASS
  - Backend API e frontend Blazor em projetos separados.
  - Lógica de negócio em serviço dedicado, não em controller.
- Gate 3: Test-First & Cobertura Mínima - PASS (planejado)
  - Testes unitários e de integração definidos para serviços e endpoints.
  - Meta de cobertura >= 80% para serviços de backend.
- Gate 4: YAGNI / Complexidade Incremental - PASS
  - Sem EF Core, sem parsing RSS no MVP.
  - Armazenamento exclusivamente em memória.
- Gate 5: Observabilidade & Tratamento de Erros - PASS
  - Códigos HTTP semânticos (`400` para validação, `409` para duplicidade quando aplicável).
  - Mensagens simples para usuário no frontend.

Re-check pós-design (Phase 1): PASS

- Artefatos de dados e contratos mantêm escopo do MVP e não introduzem complexidade fora de fase.
- Contratos de API preservam validação mínima e respostas semânticas.

## Project Structure

### Documentation (this feature)

```text
specs/002-generate-implementation-plan/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── subscriptions-api.yaml
└── tasks.md
```

### Source Code (repository root)

```text
backend/
├── RSSFeedReader.Api/
│   ├── Controllers/
│   ├── Services/
│   ├── Models/
│   └── Program.cs
└── tests/
    ├── RSSFeedReader.Api.Tests/
    └── RSSFeedReader.Api.IntegrationTests/

frontend/
└── RSSFeedReader.UI/
    ├── Pages/
    ├── Components/
    ├── Services/
    ├── Layout/
    ├── wwwroot/
    │   └── appsettings.json
    └── Program.cs

shared/
└── RSSFeedReader.Contracts/
```

**Structure Decision**: Estrutura web application com separação frontend/backend e pacote shared para contratos, alinhada ao documento de stack tecnológica e ao princípio de separação de responsabilidades da constituição.

## Complexity Tracking

Nenhuma violação de constituição identificada; seção de exceções não aplicável.
