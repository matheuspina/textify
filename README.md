# Textify - API de Conversão de Arquivos

Uma API FastAPI moderna e robusta para extrair texto de diversos formatos de arquivo, com suporte a Docker Swarm, autenticação por API key e geração de URLs temporárias para download.

## 🚀 Características

- **Múltiplos Formatos**: Suporte para DOCX, PDF, XLSX, PPTX, HTML, JSON, XML e muito mais
- **Conversão Flexível**: Upload direto ou conversão via URL
- **URLs Temporárias**: Geração de links de download com expiração configurável
- **Autenticação Segura**: Proteção por API key
- **Docker Ready**: Configuração completa para Docker e Docker Swarm
- **Documentação Interativa**: Swagger UI e ReDoc integrados

## 📁 Estrutura do Projeto

```
textify/
├── src/                          # Código fonte principal
│   ├── main.py                   # Aplicação FastAPI principal
│   ├── file_converter.py         # Lógica de conversão de arquivos
│   └── html_to_docx_universal.py # Conversor HTML para DOCX
├── docker/                       # Configurações Docker
│   ├── Dockerfile               # Imagem Docker
│   ├── docker-compose.yml       # Desenvolvimento local
│   ├── docker-compose.swarm.yml # Produção com Swarm
│   └── nginx.conf               # Configuração Nginx
├── docs/                        # Documentação
├── scripts/                     # Scripts de automação
├── tests/                       # Testes automatizados
├── .vercel/                     # Configuração Vercel
├── requirements.txt             # Dependências Python
├── .env.example                 # Exemplo de variáveis de ambiente
├── .gitignore                   # Arquivos ignorados pelo Git
└── README.md                    # Este arquivo
```

## 🔐 Segurança

- **Autenticação**: Todos os endpoints protegidos requerem header `x-api-key`
- **HTTPS**: Configuração SSL/TLS com Nginx
- **Rate Limiting**: Proteção contra abuso da API
- **Docker Secrets**: API key armazenada como secret do Docker
- **URLs Temporárias**: Links de download com expiração automática

## 🚀 Início Rápido

### Desenvolvimento Local

1. **Clone o repositório**
```bash
git clone https://github.com/matheuspina/textify.git
cd textify
```

2. **Configure o ambiente**
```bash
cp .env.example .env
# Edite o .env com suas configurações
```

3. **Instale as dependências**
```bash
pip install -r requirements.txt
```

4. **Execute a aplicação**
```bash
cd src
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

### Docker (Desenvolvimento)

```bash
cd docker
docker-compose up --build
```

### Docker Swarm (Produção)

1. **Inicializar Docker Swarm**
```bash
docker swarm init
```

2. **Criar API Key Secret**
```bash
API_KEY=$(openssl rand -base64 32)
echo "$API_KEY" | docker secret create api_key -
```

3. **Deploy**
```bash
cd docker
docker stack deploy -c docker-compose.swarm.yml textify
```

## 🌐 Endpoints da API

### Públicos (sem autenticação)
- `GET /` - Informações da API
- `GET /health` - Status de saúde da aplicação

### Protegidos (requer x-api-key)
- `GET /formats` - Formatos suportados
- `POST /convert/url` - Converter arquivo via URL
- `POST /convert/file` - Converter arquivo enviado
- `POST /generate/url` - Gerar URL temporária para download

## 📝 Exemplos de Uso

### Converter arquivo via URL
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "x-api-key: YOUR_API_KEY" \
  -d '{"url": "https://example.com/document.pdf"}' \
  http://localhost:8000/convert/url
```

### Converter arquivo enviado
```bash
curl -X POST \
  -H "x-api-key: YOUR_API_KEY" \
  -F "file=@document.pdf" \
  http://localhost:8000/convert/file
```

### Gerar URL temporária
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "x-api-key: YOUR_API_KEY" \
  -d '{"file": "base64_encoded_content", "format": "docx"}' \
  http://localhost:8000/generate/url
```

## 📈 Formatos Suportados

- **Documentos**: DOCX, DOC, PDF, ODT
- **Planilhas**: XLSX, XLS, CSV, ODS
- **Apresentações**: PPTX, PPT, ODP
- **Web**: HTML, HTM
- **Dados**: JSON, XML, YML, YAML
- **Texto**: TXT

## 🔧 Configuração

### Variáveis de Ambiente

```bash
API_KEY=your-secret-api-key
TEMP_FILE_DURATION_MINUTES=60
MAX_FILE_SIZE_MB=50
```

### Docker Secrets (Produção)

- `api_key`: Chave de API para autenticação

## 📊 Monitoramento

### Ver status dos serviços
```bash
docker service ls
```

### Ver logs
```bash
docker service logs textify_api
docker service logs textify_nginx
```

### Escalar serviços
```bash
docker service scale textify_api=5
```

## 🛠️ Desenvolvimento

### Executar testes
```bash
cd tests
python -m pytest
```

### Linting e formatação
```bash
black src/
flake8 src/
```

### Build da imagem Docker
```bash
cd docker
docker build -t textify:latest .
```

## 📚 Documentação

- **Swagger UI**: `http://localhost:8000/docs`
- **ReDoc**: `http://localhost:8000/redoc`
- **OpenAPI JSON**: `http://localhost:8000/openapi.json`

## 🐛 Troubleshooting

### Problemas comuns

1. **Erro de autenticação**: Verifique se o header `x-api-key` está correto
2. **Formato não suportado**: Consulte `/formats` para ver formatos disponíveis
3. **Timeout de download**: URLs muito lentas podem exceder o timeout de 30s
4. **Memória insuficiente**: Arquivos muito grandes podem causar problemas

### Logs úteis

```bash
# Docker Compose
docker-compose logs -f

# Docker Swarm
docker service logs -f textify_api
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Agradecimentos

- [FastAPI](https://fastapi.tiangolo.com/) - Framework web moderno e rápido
- [Pandoc](https://pandoc.org/) - Conversor universal de documentos
- [Docker](https://www.docker.com/) - Plataforma de containerização
- [Nginx](https://nginx.org/) - Servidor web de alta performance

---

**Textify** - Transformando arquivos em texto de forma simples e eficiente.