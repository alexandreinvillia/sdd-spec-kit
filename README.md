# GitHub Spec Kit desenvolvimento orientado por especificações.

<img src="https://octodex.github.com/images/Professortocat_v2.png" align="right" height="200px" />

Hey alexandreinvillia!

Mona aqui. Terminei de preparar seu exercício. Espero que goste! 💚

Lembre-se, o exercício é no seu ritmo, então sinta-se à vontade para fazer uma pausa! ☕️

[![](https://img.shields.io/badge/Ir%20para%20o%20Exerc%C3%ADcio-%E2%86%92-1f883d?style=for-the-badge&logo=github&labelColor=197935)](https://github.com/alexandreinvillia/sdd-spec-kit/issues/1)

---

## MVP de Assinaturas RSS

### Arquitetura

```text
backend/RSSFeedReader.Api          → ASP.NET Core Web API (http://localhost:5151)
frontend/RSSFeedReader.UI          → Blazor WebAssembly  (http://localhost:5213)
shared/RSSFeedReader.Contracts     → Modelos compartilhados (Subscription, ErrorResponse)
tests/RSSFeedReader.Api.Tests      → Testes unitários da API
tests/RSSFeedReader.Api.IntegrationTests → Testes de integração dos endpoints
tests/RSSFeedReader.UI.Tests       → Testes do cliente HTTP do frontend
```

### Como executar

**Pré-requisitos**: .NET 8 SDK.

```bash
# Backend (porta 5151)
dotnet run --project backend/RSSFeedReader.Api

# Frontend (porta 5213)
dotnet run --project frontend/RSSFeedReader.UI
```

Com ambos rodando, acesse `http://localhost:5213` e adicione URLs de feeds RSS.

### Testes

```bash
dotnet test
```

---

&copy; 2025 GitHub &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)
