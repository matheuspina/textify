# Contribuindo para o Tarefy

Obrigado por considerar contribuir para o Tarefy! Este documento fornece diretrizes para contribuições.

## 🚀 Como Contribuir

### 1. Fork e Clone

```bash
# Fork o repositório no GitHub
# Clone seu fork
git clone https://github.com/seu-usuario/tarefy.git
cd tarefy
```

### 2. Configure o Ambiente de Desenvolvimento

```bash
# Crie um ambiente virtual
python -m venv venv
source venv/bin/activate  # Linux/Mac
# ou
venv\Scripts\activate     # Windows

# Instale as dependências
pip install -r requirements.txt

# Instale dependências de desenvolvimento
pip install black flake8 pytest pytest-cov
```

### 3. Crie uma Branch

```bash
git checkout -b feature/sua-nova-feature
# ou
git checkout -b fix/correcao-bug
```

## 📝 Diretrizes de Código

### Estilo de Código

- Use **Black** para formatação automática
- Siga as convenções **PEP 8**
- Use **type hints** sempre que possível
- Documente funções e classes com **docstrings**

```bash
# Formate o código
black src/

# Verifique o estilo
flake8 src/
```

### Estrutura de Commits

Use mensagens de commit claras e descritivas:

```
tipo(escopo): descrição breve

Descrição mais detalhada se necessário.

- Lista de mudanças
- Outra mudança importante
```

**Tipos de commit:**
- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Mudanças na documentação
- `style`: Formatação, sem mudança de lógica
- `refactor`: Refatoração de código
- `test`: Adição ou correção de testes
- `chore`: Tarefas de manutenção

### Exemplo:
```
feat(converter): adiciona suporte para arquivos .epub

Implementa conversão de arquivos EPUB para texto usando
a biblioteca ebooklib.

- Adiciona dependência ebooklib
- Cria função extract_epub_text
- Atualiza lista de formatos suportados
- Adiciona testes para conversão EPUB
```

## 🧪 Testes

### Executar Testes

```bash
# Executar todos os testes
pytest

# Executar com cobertura
pytest --cov=src

# Executar testes específicos
pytest tests/test_converter.py
```

### Escrever Testes

- Crie testes para novas funcionalidades
- Mantenha cobertura de testes acima de 80%
- Use nomes descritivos para funções de teste
- Organize testes em classes quando apropriado

```python
def test_convert_pdf_to_text():
    """Testa conversão de PDF para texto."""
    # Arrange
    pdf_content = load_test_pdf()
    
    # Act
    result = convert_file(pdf_content, "pdf")
    
    # Assert
    assert result["success"] is True
    assert "texto esperado" in result["extracted_text"]
```

## 📚 Documentação

### Atualizando Documentação

- Mantenha o README.md atualizado
- Documente novas APIs no código
- Atualize exemplos quando necessário
- Use comentários para lógica complexa

### Docstrings

```python
def extract_text_from_file(file_content: bytes, file_format: str) -> dict:
    """
    Extrai texto de um arquivo baseado no formato.
    
    Args:
        file_content: Conteúdo do arquivo em bytes
        file_format: Formato do arquivo (pdf, docx, etc.)
        
    Returns:
        Dict contendo o texto extraído e metadados
        
    Raises:
        UnsupportedFormatError: Quando o formato não é suportado
        FileProcessingError: Quando há erro no processamento
    """
```

## 🐛 Reportando Bugs

### Antes de Reportar

1. Verifique se o bug já foi reportado
2. Teste com a versão mais recente
3. Reproduza o bug consistentemente

### Template de Bug Report

```markdown
**Descrição do Bug**
Descrição clara e concisa do problema.

**Passos para Reproduzir**
1. Vá para '...'
2. Clique em '....'
3. Role para baixo até '....'
4. Veja o erro

**Comportamento Esperado**
Descrição do que deveria acontecer.

**Screenshots**
Se aplicável, adicione screenshots.

**Ambiente:**
- OS: [e.g. Ubuntu 20.04]
- Python: [e.g. 3.9.7]
- Versão do Tarefy: [e.g. 1.0.0]

**Contexto Adicional**
Qualquer outra informação relevante.
```

## ✨ Sugerindo Melhorias

### Template de Feature Request

```markdown
**Resumo da Funcionalidade**
Descrição clara da funcionalidade desejada.

**Motivação**
Por que esta funcionalidade seria útil?

**Solução Proposta**
Como você imagina que isso funcionaria?

**Alternativas Consideradas**
Outras abordagens que você considerou?

**Contexto Adicional**
Screenshots, mockups, links relevantes, etc.
```

## 🔄 Processo de Review

### Pull Request

1. **Título claro**: Descreva a mudança brevemente
2. **Descrição detalhada**: Explique o que foi feito e por quê
3. **Testes**: Inclua testes para novas funcionalidades
4. **Documentação**: Atualize documentação se necessário

### Template de PR

```markdown
## Descrição
Breve descrição das mudanças.

## Tipo de Mudança
- [ ] Bug fix
- [ ] Nova funcionalidade
- [ ] Breaking change
- [ ] Documentação

## Como Testar
1. Passo 1
2. Passo 2
3. Passo 3

## Checklist
- [ ] Código segue as diretrizes de estilo
- [ ] Testes passam localmente
- [ ] Documentação atualizada
- [ ] Sem breaking changes (ou documentado)
```

## 🏗️ Arquitetura

### Estrutura do Projeto

```
src/
├── main.py              # Aplicação FastAPI principal
├── file_converter.py    # Lógica de conversão
└── utils/              # Utilitários auxiliares
```

### Adicionando Novos Formatos

1. Implemente a função de extração em `file_converter.py`
2. Adicione o formato à lista `SUPPORTED_FORMATS`
3. Atualize a documentação
4. Adicione testes

## 📞 Contato

- **Issues**: Use o GitHub Issues para bugs e sugestões
- **Discussões**: Use GitHub Discussions para perguntas gerais
- **Email**: Para questões sensíveis ou privadas

## 🙏 Reconhecimento

Todos os contribuidores serão reconhecidos no README.md e releases.

---

Obrigado por contribuir para o Tarefy! 🚀