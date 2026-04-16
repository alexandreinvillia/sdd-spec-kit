# Desenvolvendo uma aplicação usando GitHub Spec Kit

O GitHub Spec Kit é um kit de ferramentas de código aberto que permite o Spec-Driven Development (SSD) integrando especificações com assistentes de codificação de IA como o GitHub Copilot.

Neste exercício, você vai aprender a usar o GitHub Spec Kit para desenvolver uma nova aplicação do zero. 
Inicira uma aplicação .Net e utilizará a metodologia Spec-Driven Development (SSD) para criar os documentos de constituição, especificação, plano e tarefas do aplicativo. Você usa o fluxo de trabalho de implementação do GitHub Spec Kit para implementar uma versão inicial do MVP do aplicativo.

## Bem vindo ao exercício de desenvolvimento de aplicativo usando o GitHub Spec Kit!

- **Para quem é**: Esse exercício é destinado a desenvolvedores que desejam aprender a usar o GitHub Spec Kit para desenvolvimento orientado por especificações.
- **O que você vai aprender**: Você aprenderá a criar documentos de constituição, especificação, plano e tarefas do aplicativo usando a metodologia Spec-Driven Development (SSD) e a implementar uma versão inicial do MVP do aplicativo.
- **O que você vai construir**: Você construirá uma aplicação .NET utilizando o GitHub Spec Kit e a metodologia SSD.
- **Requisitos**:
  - Para completar este exercício, você precisade uma conta do GitHub e assinatura do GitHub Copilot. Se você não tiver uma conta do GitHub, poderá se inscrever em uma conta individual gratuita e usar um plano do GitHub Copilot Free para concluir o exercício. Se você tiver acesso a uma assinatura do GitHub Copilot Pro, GitHub Copilot Pro+, GitHub Copilot Business ou GitHub Copilot Enterprise de dentro do ambiente de laboratório, você pode usar sua assinatura GitHub Copilot existente para concluir esse exercício
 - Seu ambiente de laboratório DEVE incluir os seguintes recursos: Git 2.48 ou posterior, . NET SDK 8.0 ou posterior, Visual Studio Code com as extensões C# Dev Kit e GitHub Copilot Chat, Python 3.11 ou posterior, o gerenciador de pacotes uv, Specify CLI e acesso a uma conta GitHub com GitHub Copilot ativado.

- **Tempo de duração**: Esse exercicío tem aproximadamente 60 min de duração.

Neste exercicio você vai realizar:

1. Criar um projeto e inicializar o GitHub Spec Kit
2. Gerar a documentação usada pelo stakeholder
3. Gerar o arquivo spec.md usado na documentação do stakeholder
4. Gerar o plano de execução no arquivo plan.md através do arquivo spec.md
5. Gerar as tarefas de implementação no arquivo tasks.md através do arquivo plan.md
6. Implementar a primeira versão do MVP do aplicativo usando o plano de execução e as tarefas

## Usando no Codespaces

O repositório agora está configurado para abrir diretamente no diretório padrão do Codespaces e provisionar automaticamente as dependências principais do exercício:

- .NET SDK 8
- Python 3.11
- uv
- Specify CLI
- Node.js e npm

Ao criar o Codespace, o script de pós-criação também:

- cria a pasta `StakeholderDocuments` quando necessário
- copia os documentos base de `docs/`
- inicializa o GitHub Spec Kit com `--force` quando o projeto ainda não possui `.specify/`

Se quiser validar manualmente o ambiente depois da criação, rode:

```bash
dotnet --version
python3 --version
uv --version
specify version
```


### Como iniciar o exercício?

Simplesmente copie o exercício para sua conta, depois dê ao seu Octocat favorito (Mona) **cerca de 20 segundos** para preparar a primeira lição, e então **atualize a página**.

[![](https://img.shields.io/badge/Copiar%20Exerc%C3%ADcio-%E2%86%92-1f883d?style=for-the-badge&logo=github&labelColor=197935)](https://github.com/new?template_owner=rdmotta-invillia&template_name=github-spec-kit-starter&owner=%40me&name=skills-<replace-me>&description=Workshop+Invillia:Construindo+uma+aplicação+usando+GitHub+Spec+Kit&visibility=public)

<details>
<summary>Está com problemas? 🤷</summary><br/>

Ao copiar o exercício, recomendamos as seguintes configurações:

- Para owner, escolha sua conta pessoal ou uma organização para hospedar o repositório.

- Recomendamos criar um repositório público, pois repositórios privados consumirão minutos de Actions.

Se o exercício não estiver pronto em 20 segundos, por favor verifique a aba [Actions](../../actions).

- Verifique se há um job em execução. Às vezes simplesmente demora um pouco mais.

- Se a página mostrar um job com falha, por favor envie uma issue. Legal, você encontrou um bug! 🐛

</details>

---

&copy; 2026 GitHub &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)

