# Objetivos do projeto

Construir um leitor simples de feed RSS/Atom. O objetivo é demonstrar a capacidade mais básica (gerenciar uma lista de assinaturas) sem a complexidade de buscar e exibir conteúdo de feed.

## Propósito

O app existe para demonstrar como um usuário pode montar uma lista de assinaturas de feeds RSS. Esta é uma prova de conceito focada na interface de gerenciamento de assinaturas.

## Escopo-alvo (somente MVP)

Esta é uma aplicação POC mínima para um único usuário, executando localmente. Ela foi projetada para ser desenvolvida e testada em Windows, macOS ou Linux.

O MVP inclui apenas:

- Adicionar uma assinatura de feed por URL
- Exibir a lista de assinaturas na interface

Todos os outros recursos (buscar feeds, exibir itens, persistência, remover assinaturas etc.) ficam para MVP Estendido ou pós-MVP.

## Abordagem de entrega

O foco está no desenvolvimento rápido do recurso de MVP. Construa primeiro a funcionalidade mínima:

- Adicionar uma assinatura por URL
- Exibir a lista de assinaturas

Para manter o desenvolvimento rápido:

- Nenhuma busca ou parsing de feed é necessário no MVP
- Sem validação de URLs de feed (assuma que o usuário fornece URLs válidas)
- Armazene assinaturas apenas em memória (abordagem mais simples)
- Mantenha a interface simples e funcional em vez de polida

## O que significa "MVP funcionando"

O MVP está completo quando:

1. Um usuário consegue adicionar uma assinatura de feed colando uma URL
2. A interface exibe a lista atualizada de assinaturas

Nenhuma busca real de feed, parsing ou exibição de itens é necessária para o MVP.

## MVP Estendido (próxima fase)

Depois que o MVP básico estiver funcionando, o MVP Estendido adiciona capacidades de busca e exibição de feed:

1. Um usuário pode clicar em um botão para atualizar manualmente o feed
2. Os itens do feed são exibidos (no mínimo título e link)

Teste com um feed RSS conhecido e válido como <https://devblogs.microsoft.com/dotnet/feed/>.

### Checklist de desenvolvimento local

Antes de testar o MVP, verifique:

- [ ] Backend executa sem erros e escuta na porta configurada
- [ ] Frontend executa sem erros e carrega no navegador
- [ ] Configuração do frontend (`wwwroot/appsettings.json`) aponta para a URL correta do backend
- [ ] CORS do backend permite a origem do frontend
- [ ] Console do DevTools do navegador não mostra erros de conexão ao carregar a página

## Melhorias futuras (pós-MVP)

Quando o MVP Estendido estiver funcionando (gerenciamento de assinaturas + busca de feeds + exibição de itens), estes recursos podem ser adicionados:

- **Persistência**: salvar assinaturas e itens entre sessões (requer implementação de banco de dados)
- **Remover assinaturas**: permitir que usuários excluam feeds que não querem mais
- **Polling em segundo plano**: atualizar feeds automaticamente em um agendamento
- **Melhor tratamento de erros**: mostrar mensagens detalhadas para diferentes cenários de falha
- **Renderização de conteúdo**: exibir conteúdo completo do item, não apenas título e link
- **Controle de lido/não lido**: marcar itens como lidos e filtrar de acordo
- **Organização**: agrupar feeds em pastas ou categorias

## Nota sobre escolha de tecnologia

Embora este MVP seja intencionalmente simples, as escolhas de tecnologia (ASP.NET Core + Blazor) devem suportar recursos futuros prontos para produção sem exigir uma reescrita completa. A arquitetura permite adicionar persistência, operações em segundo plano e recursos de interface aprimorados quando necessário.

## Como este documento se encaixa com os outros

- [AppFeatures.md](AppFeatures.md) descreve os recursos específicos visíveis para o usuário no MVP
- [TechStack.md](TechStack.md) explica as escolhas de tecnologia e como elas suportam os objetivos do MVP
