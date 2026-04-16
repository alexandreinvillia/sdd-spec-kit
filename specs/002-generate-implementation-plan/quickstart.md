# Quickstart - MVP de Assinaturas RSS

## Pré-requisitos

- .NET 8 SDK instalado
- Ambiente local com portas disponíveis para backend e frontend

## Estrutura esperada

- backend/RSSFeedReader.Api
- frontend/RSSFeedReader.UI
- shared/RSSFeedReader.Contracts

## 1. Subir backend

1. Ir para o projeto da API.
2. Executar aplicação backend.
3. Confirmar endpoint base em http://localhost:5151.

Comando de referência:

```bash
dotnet run --project backend/RSSFeedReader.Api
```

## 2. Configurar frontend para apontar para API

Ajustar frontend/RSSFeedReader.UI/wwwroot/appsettings.json:

```json
{
  "ApiBaseUrl": "http://localhost:5151/api/"
}
```

## 3. Verificar CORS no backend

Permitir explicitamente a origem do frontend (exemplo local):

- http://localhost:5213

## 4. Subir frontend

Comando de referência:

```bash
dotnet run --project frontend/RSSFeedReader.UI
```

## 5. Teste manual do MVP

1. Abrir UI no navegador.
2. Informar URL de feed HTTP/HTTPS no campo de entrada.
3. Acionar ação de adicionar assinatura.
4. Confirmar item na listagem de assinaturas.

## 6. Testes automatizados (quando projetos de teste existirem)

```bash
dotnet test
```

## Resultado esperado

- Usuário consegue adicionar assinaturas válidas.
- URLs inválidas retornam erro de validação.
- Lista de assinaturas reflete estado em memória da execução atual.
