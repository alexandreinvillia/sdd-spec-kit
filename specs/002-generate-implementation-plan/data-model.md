# Data Model - MVP de Assinaturas RSS

## Entity: Subscription

- Description: Representa uma assinatura de feed cadastrada pelo usuário.
- Fields:
  - id: string (UUID), obrigatório, único, imutável
  - feedUrl: string, obrigatório, URI absoluta HTTP/HTTPS
  - createdAt: string (date-time ISO 8601 UTC), obrigatório
- Validation Rules:
  - feedUrl deve ser não vazio após trim
  - feedUrl deve ser URI absoluta com esquema http ou https
  - feedUrl não deve duplicar assinatura já existente (comparação normalizada)
- State Transitions:
  - created: após inclusão válida
  - listed: quando retornada em coleção por consulta

## Entity: CreateSubscriptionRequest

- Description: Payload de entrada para criar assinatura.
- Fields:
  - feedUrl: string, obrigatório
- Validation Rules:
  - feedUrl obrigatório
  - feedUrl conforme regras de URI de Subscription

## Entity: ErrorResponse

- Description: Estrutura de erro de API para frontend.
- Fields:
  - code: string, obrigatório (ex.: INVALID_URL, DUPLICATE_SUBSCRIPTION)
  - message: string, obrigatório
  - traceId: string, opcional

## Relationships

- CreateSubscriptionRequest -> Subscription: 1 para 1 (requisição gera uma assinatura).
- Subscription é agregado independente em coleção em memória.

## Volume and Lifecycle

- Escopo MVP: até 100 assinaturas em memória por execução local.
- Persistência: nenhuma (dados descartados ao encerrar processo).
