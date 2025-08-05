#!/bin/bash

# Script de build para o Textify
# Este script constrói e publica a imagem Docker

set -e

# Configurações
IMAGE_NAME="textify"
REGISTRY="mathpina"
VERSION=${1:-"latest"}
PLATFORMS="linux/amd64,linux/arm64"

echo "🐳 Construindo imagem Docker do Textify..."
echo "   Imagem: $REGISTRY/$IMAGE_NAME:$VERSION"
echo "   Plataformas: $PLATFORMS"

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    echo "❌ Docker não encontrado. Por favor, instale Docker."
    exit 1
fi

# Verificar se buildx está disponível
if ! docker buildx version &> /dev/null; then
    echo "❌ Docker Buildx não encontrado. Por favor, atualize Docker."
    exit 1
fi

# Criar builder se não existir
if ! docker buildx ls | grep -q "textify-builder"; then
    echo "🔧 Criando builder multi-plataforma..."
    docker buildx create --name textify-builder --use
fi

# Usar o builder
docker buildx use textify-builder

# Fazer login no Docker Hub (se necessário)
if [ ! -z "$DOCKER_USERNAME" ] && [ ! -z "$DOCKER_PASSWORD" ]; then
    echo "🔐 Fazendo login no Docker Hub..."
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
fi

# Build da imagem
echo "🏗️ Construindo imagem..."
docker buildx build \
    --platform $PLATFORMS \
    --file docker/Dockerfile \
    --tag $REGISTRY/$IMAGE_NAME:$VERSION \
    --tag $REGISTRY/$IMAGE_NAME:latest \
    --push \
    .

echo "✅ Build concluído com sucesso!"
echo "   Imagem publicada: $REGISTRY/$IMAGE_NAME:$VERSION"

# Verificar se a imagem foi criada
echo "🔍 Verificando imagem..."
docker buildx imagetools inspect $REGISTRY/$IMAGE_NAME:$VERSION

echo ""
echo "🎉 Imagem Docker do Textify está pronta!"
echo ""
echo "📋 Para usar a imagem:"
echo "   docker run -p 8000:8000 $REGISTRY/$IMAGE_NAME:$VERSION"
echo ""
echo "📋 Para usar com Docker Compose:"
echo "   cd docker && docker-compose up"