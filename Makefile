.PHONY: help install dev test lint format clean build docker-build docker-run docker-push setup

# Variáveis
PYTHON := python3
PIP := pip
DOCKER_IMAGE := mathpina/textify
VERSION := 1.9.0

# Cores para output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

help: ## Mostra esta mensagem de ajuda
	@echo "$(BLUE)Textify - Conversor Universal de Arquivos$(NC)"
	@echo ""
	@echo "$(YELLOW)Comandos disponíveis:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Configura o ambiente de desenvolvimento
	@echo "$(BLUE)🚀 Configurando ambiente de desenvolvimento...$(NC)"
	@chmod +x scripts/setup.sh
	@./scripts/setup.sh

install: ## Instala dependências de produção
	@echo "$(BLUE)📦 Instalando dependências...$(NC)"
	$(PIP) install -r requirements.txt

dev: ## Instala dependências de desenvolvimento
	@echo "$(BLUE)🛠️ Instalando dependências de desenvolvimento...$(NC)"
	$(PIP) install -r requirements.txt
	$(PIP) install black flake8 pytest pytest-cov isort mypy

test: ## Executa todos os testes
	@echo "$(BLUE)🧪 Executando testes...$(NC)"
	cd src && $(PYTHON) -m pytest ../tests/ -v --cov=. --cov-report=term-missing

test-unit: ## Executa apenas testes unitários
	@echo "$(BLUE)🧪 Executando testes unitários...$(NC)"
	cd src && $(PYTHON) -m pytest ../tests/ -v -m "unit"

test-integration: ## Executa apenas testes de integração
	@echo "$(BLUE)🧪 Executando testes de integração...$(NC)"
	cd src && $(PYTHON) -m pytest ../tests/ -v -m "integration"

lint: ## Executa linting do código
	@echo "$(BLUE)🔍 Executando linting...$(NC)"
	flake8 src/ tests/
	mypy src/

format: ## Formata o código
	@echo "$(BLUE)✨ Formatando código...$(NC)"
	black src/ tests/
	isort src/ tests/

format-check: ## Verifica formatação sem modificar
	@echo "$(BLUE)🔍 Verificando formatação...$(NC)"
	black --check src/ tests/
	isort --check-only src/ tests/

clean: ## Remove arquivos temporários
	@echo "$(BLUE)🧹 Limpando arquivos temporários...$(NC)"
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	rm -rf build/
	rm -rf dist/
	rm -rf .coverage
	rm -rf htmlcov/
	rm -rf .pytest_cache/
	rm -rf .mypy_cache/

run: ## Executa a aplicação localmente
	@echo "$(BLUE)🚀 Iniciando Textify...$(NC)"
	cd src && uvicorn main:app --reload --host 0.0.0.0 --port 8000

run-prod: ## Executa a aplicação em modo produção
	@echo "$(BLUE)🚀 Iniciando Textify (produção)...$(NC)"
	cd src && uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4

docker-build: ## Constrói a imagem Docker
	@echo "$(BLUE)🐳 Construindo imagem Docker...$(NC)"
	@chmod +x scripts/build.sh
	@./scripts/build.sh $(VERSION)

docker-run: ## Executa o container Docker
	@echo "$(BLUE)🐳 Executando container Docker...$(NC)"
	docker run -p 8000:8000 --env-file .env $(DOCKER_IMAGE):$(VERSION)

docker-compose-up: ## Inicia com Docker Compose
	@echo "$(BLUE)🐳 Iniciando com Docker Compose...$(NC)"
	cd docker && docker-compose up -d

docker-compose-down: ## Para Docker Compose
	@echo "$(BLUE)🐳 Parando Docker Compose...$(NC)"
	cd docker && docker-compose down

docker-push: ## Publica a imagem Docker
	@echo "$(BLUE)🐳 Publicando imagem Docker...$(NC)"
	docker push $(DOCKER_IMAGE):$(VERSION)
	docker push $(DOCKER_IMAGE):latest

build: clean format lint test ## Executa build completo (clean, format, lint, test)
	@echo "$(GREEN)✅ Build concluído com sucesso!$(NC)"

ci: format-check lint test ## Executa pipeline de CI
	@echo "$(GREEN)✅ Pipeline de CI concluído!$(NC)"

docs: ## Gera documentação
	@echo "$(BLUE)📚 Gerando documentação...$(NC)"
	@echo "Acesse http://localhost:8000/docs após iniciar a aplicação"

check: ## Executa todas as verificações
	@echo "$(BLUE)🔍 Executando todas as verificações...$(NC)"
	@make format-check
	@make lint
	@make test

install-hooks: ## Instala git hooks
	@echo "$(BLUE)🪝 Instalando git hooks...$(NC)"
	@echo "#!/bin/sh" > .git/hooks/pre-commit
	@echo "make format-check && make lint" >> .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit

# Comando padrão
all: build