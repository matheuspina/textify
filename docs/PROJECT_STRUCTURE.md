# Estrutura do Projeto Textify

Este documento descreve a organização e estrutura do projeto Textify.

## Visão Geral da Estrutura

```
textify/
├── .env                          # Variáveis de ambiente (não commitado)
├── .env.example                  # Exemplo de variáveis de ambiente
├── .github/                      # Configurações do GitHub
│   ├── ISSUE_TEMPLATE/          # Templates para issues
│   │   ├── bug_report.md        # Template para relatórios de bug
│   │   └── feature_request.md   # Template para solicitações de feature
│   ├── pull_request_template.md # Template para Pull Requests
│   └── workflows/               # GitHub Actions
│       └── ci.yml              # Pipeline de CI/CD
├── .gitignore                   # Arquivos ignorados pelo Git
├── LICENSE                      # Licença MIT
├── Makefile                     # Comandos automatizados
├── README.md                    # Documentação principal
├── docker/                      # Configurações Docker
│   ├── Dockerfile              # Imagem Docker
│   ├── docker-compose.yml      # Desenvolvimento local
│   ├── docker-compose.swarm.yml # Produção com Docker Swarm
│   └── nginx.conf              # Configuração do Nginx
├── docs/                        # Documentação
│   ├── CONTRIBUTING.md         # Guia de contribuição
│   └── PROJECT_STRUCTURE.md    # Este arquivo
├── pyproject.toml              # Configuração do projeto Python
├── pytest.ini                 # Configuração do pytest
├── requirements.txt            # Dependências Python
├── scripts/                    # Scripts utilitários
│   ├── build.sh               # Script de build Docker
│   └── setup.sh               # Script de configuração
├── src/                        # Código fonte
│   ├── __init__.py            # Inicialização do pacote
│   ├── file_converter.py      # Lógica de conversão
│   ├── html_to_docx_universal.py # Conversão HTML para DOCX
│   └── main.py                # API FastAPI
└── tests/                      # Testes
    ├── __init__.py            # Inicialização do pacote de testes
    └── test_converter.py      # Testes do conversor
```

## Descrição dos Diretórios

### `/src` - Código Fonte
Contém todo o código fonte da aplicação:
- **main.py**: Aplicação FastAPI principal com endpoints da API
- **file_converter.py**: Lógica central de conversão de arquivos
- **html_to_docx_universal.py**: Conversor especializado HTML para DOCX
- **__init__.py**: Configuração do pacote Python

### `/tests` - Testes
Contém todos os testes automatizados:
- **test_converter.py**: Testes unitários para o módulo de conversão
- **__init__.py**: Configuração do pacote de testes

### `/docker` - Containerização
Configurações para Docker e orquestração:
- **Dockerfile**: Definição da imagem Docker
- **docker-compose.yml**: Configuração para desenvolvimento local
- **docker-compose.swarm.yml**: Configuração para produção
- **nginx.conf**: Configuração do proxy reverso

### `/scripts` - Automação
Scripts para automatizar tarefas comuns:
- **setup.sh**: Configuração inicial do ambiente de desenvolvimento
- **build.sh**: Build e publicação da imagem Docker

### `/docs` - Documentação
Documentação do projeto:
- **CONTRIBUTING.md**: Guia para contribuidores
- **PROJECT_STRUCTURE.md**: Estrutura do projeto (este arquivo)

### `/.github` - GitHub
Configurações específicas do GitHub:
- **workflows/ci.yml**: Pipeline de CI/CD
- **ISSUE_TEMPLATE/**: Templates para issues
- **pull_request_template.md**: Template para PRs

## Arquivos de Configuração

### Raiz do Projeto
- **.env**: Variáveis de ambiente (local, não commitado)
- **.env.example**: Exemplo de configuração de ambiente
- **.gitignore**: Arquivos ignorados pelo controle de versão
- **LICENSE**: Licença MIT do projeto
- **Makefile**: Comandos automatizados para desenvolvimento
- **README.md**: Documentação principal do projeto
- **pyproject.toml**: Configuração do projeto Python (dependências, build, etc.)
- **pytest.ini**: Configuração do framework de testes
- **requirements.txt**: Lista de dependências Python

## Convenções

### Nomenclatura
- **Arquivos Python**: snake_case (ex: `file_converter.py`)
- **Classes**: PascalCase (ex: `FileConverter`)
- **Funções e variáveis**: snake_case (ex: `extract_text_from_file`)
- **Constantes**: UPPER_SNAKE_CASE (ex: `SUPPORTED_FORMATS`)

### Estrutura de Código
- Imports organizados: stdlib, third-party, local
- Docstrings em português para funções públicas
- Type hints quando possível
- Máximo de 88 caracteres por linha (Black formatter)

### Testes
- Um arquivo de teste por módulo
- Nomenclatura: `test_<module_name>.py`
- Classes de teste: `Test<ClassName>`
- Métodos de teste: `test_<functionality>`

## Comandos Úteis

### Desenvolvimento
```bash
make setup          # Configuração inicial
make run            # Executar aplicação
make test           # Executar testes
make lint           # Verificar código
make format         # Formatar código
```

### Docker
```bash
make docker-build   # Build da imagem
make docker-run     # Executar container
make docker-compose-up  # Subir com compose
```

### CI/CD
```bash
make ci             # Pipeline completo de CI
make build          # Build completo (clean, format, lint, test)
```

## Fluxo de Desenvolvimento

1. **Setup**: `make setup`
2. **Desenvolvimento**: Editar código em `/src`
3. **Testes**: Adicionar/atualizar testes em `/tests`
4. **Verificação**: `make check` (format, lint, test)
5. **Commit**: Seguir convenções do Git
6. **PR**: Usar template do GitHub

## Deployment

### Desenvolvimento Local
```bash
cd src && uvicorn main:app --reload
```

### Docker Local
```bash
make docker-compose-up
```

### Produção (Docker Swarm)
```bash
cd docker && docker stack deploy -c docker-compose.swarm.yml textify
```

## Monitoramento

- **Logs**: Disponíveis via Docker logs
- **Métricas**: Endpoint `/health` para health checks
- **Documentação**: `/docs` para Swagger UI
- **Status**: `/` para informações básicas

## Contribuição

Consulte <mcfile name="CONTRIBUTING.md" path="docs/CONTRIBUTING.md"></mcfile> para diretrizes detalhadas de contribuição.