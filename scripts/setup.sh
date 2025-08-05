#!/bin/bash

# Script de configuração para o Textify
# Este script configura o ambiente de desenvolvimento

set -e

echo "🚀 Configurando ambiente de desenvolvimento do Textify..."

# Verificar se Python está instalado
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 não encontrado. Por favor, instale Python 3.9 ou superior."
    exit 1
fi

# Verificar versão do Python
python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "✅ Python $python_version encontrado"

# Criar ambiente virtual se não existir
if [ ! -d "venv" ]; then
    echo "📦 Criando ambiente virtual..."
    python3 -m venv venv
fi

# Ativar ambiente virtual
echo "🔧 Ativando ambiente virtual..."
source venv/bin/activate

# Atualizar pip
echo "⬆️ Atualizando pip..."
pip install --upgrade pip

# Instalar dependências
echo "📚 Instalando dependências..."
pip install -r requirements.txt

# Instalar dependências de desenvolvimento
echo "🛠️ Instalando dependências de desenvolvimento..."
pip install black flake8 pytest pytest-cov

# Verificar se Docker está instalado
if command -v docker &> /dev/null; then
    echo "✅ Docker encontrado"
    docker_version=$(docker --version)
    echo "   $docker_version"
else
    echo "⚠️ Docker não encontrado. Instale Docker para usar containers."
fi

# Verificar se Pandoc está instalado
if command -v pandoc &> /dev/null; then
    echo "✅ Pandoc encontrado"
    pandoc_version=$(pandoc --version | head -n1)
    echo "   $pandoc_version"
else
    echo "⚠️ Pandoc não encontrado. Instalando..."
    
    # Detectar sistema operacional e instalar Pandoc
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y pandoc
        elif command -v yum &> /dev/null; then
            sudo yum install -y pandoc
        else
            echo "❌ Gerenciador de pacotes não suportado. Instale Pandoc manualmente."
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            brew install pandoc
        else
            echo "❌ Homebrew não encontrado. Instale Pandoc manualmente."
        fi
    else
        echo "❌ Sistema operacional não suportado para instalação automática do Pandoc."
    fi
fi

# Criar arquivo .env se não existir
if [ ! -f ".env" ]; then
    echo "📝 Criando arquivo .env..."
    cp .env.example .env
    echo "⚠️ Configure as variáveis de ambiente no arquivo .env"
fi

# Executar testes para verificar se tudo está funcionando
echo "🧪 Executando testes..."
cd src
python -m pytest ../tests/ -v

echo ""
echo "✅ Configuração concluída com sucesso!"
echo ""
echo "📋 Próximos passos:"
echo "   1. Configure as variáveis de ambiente no arquivo .env"
echo "   2. Execute: source venv/bin/activate"
echo "   3. Execute: cd src && uvicorn main:app --reload"
echo "   4. Acesse: http://localhost:8000/docs"
echo ""
echo "🎉 Textify está pronto para desenvolvimento!"