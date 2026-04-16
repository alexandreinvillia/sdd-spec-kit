# Phase 0 Research - MVP de Assinaturas RSS

## Decision 1: Arquitetura de aplicação

- Decision: Usar backend ASP.NET Core Web API + frontend Blazor WebAssembly em projetos separados.
- Rationale: Permite evolução incremental (MVP -> MVP Estendido -> pós-MVP), mantém fronteiras claras e reduz acoplamento entre UI e lógica de negócio.
- Alternatives considered:
  - Monólito único sem separação frontend/backend: rejeitado por reduzir clareza arquitetural e dificultar evolução de contratos.
  - UI server-side única: rejeitada por não alinhar com o direcionamento de stack informado pelos stakeholders.

## Decision 2: Armazenamento no MVP

- Decision: Armazenamento exclusivamente em memória com serviço singleton e coleção de assinaturas.
- Rationale: É a forma mais simples e rápida para cumprir o escopo do MVP, respeitando o princípio de complexidade incremental (YAGNI).
- Alternatives considered:
  - EF Core + SQLite no MVP: rejeitado por complexidade prematura fora de escopo.
  - Arquivo local (JSON): rejeitado por introduzir I/O e responsabilidades extras sem benefício para o MVP.

## Decision 3: Validação de URL de assinatura

- Decision: Validar URL como URI absoluta com esquema HTTP/HTTPS no endpoint de criação.
- Rationale: Atende à constituição (segurança) com custo mínimo de implementação, sem adicionar busca/parsing de feed ao MVP.
- Alternatives considered:
  - Sem validação de URL: rejeitado por conflito com requisitos de segurança da constituição.
  - Validação com request HTTP para confirmar feed: rejeitado por estender escopo para comportamento do MVP Estendido.

## Decision 4: Contrato de API para assinaturas

- Decision: Expor endpoints REST mínimos para criar e listar assinaturas.
- Rationale: Fornece interface estável entre frontend e backend e simplifica testes de integração.
- Alternatives considered:
  - Endpoint único multifunção: rejeitado por menor clareza semântica.
  - Comunicação direta frontend para armazenamento: rejeitado por violar separação de responsabilidades.

## Decision 5: Estratégia de testes

- Decision: Adotar testes unitários para serviço de assinaturas e testes de integração para endpoints críticos.
- Rationale: Suporta o gate de qualidade (TDD/cobertura) e protege regras principais (validação, inclusão e listagem).
- Alternatives considered:
  - Apenas testes manuais: rejeitado por não atender gate de qualidade.
  - Apenas unitários: rejeitado por não validar contrato HTTP fim a fim.

## Decision 6: CORS e configuração local

- Decision: Configurar CORS com origem explícita do frontend e manter portas coordenadas entre launchSettings e appsettings.
- Rationale: Evita falhas de integração local e atende requisito de segurança.
- Alternatives considered:
  - AllowAnyOrigin em todos os ambientes: rejeitado por violar política de segurança.
  - URL de API hardcoded no frontend: rejeitado por dificultar configuração e portabilidade local.

## Clarifications Status

Não há itens NEEDS CLARIFICATION pendentes no contexto técnico após esta pesquisa.
