# Script de build para o Textify
# Este script constrói e publica a imagem Docker multiarch

param(
    [string]$Version = "latest"
)

# Configurações
$IMAGE_NAME = "textify"
$REGISTRY = "mathpina"
$PLATFORMS = "linux/amd64,linux/arm64"

Write-Host "🐳 Construindo imagem Docker do Textify..." -ForegroundColor Cyan
Write-Host "   Imagem: $REGISTRY/$IMAGE_NAME`:$Version" -ForegroundColor Yellow
Write-Host "   Plataformas: $PLATFORMS" -ForegroundColor Yellow

# Verificar se Docker está instalado
try {
    docker --version | Out-Null
} catch {
    Write-Host "❌ Docker não encontrado. Por favor, instale Docker." -ForegroundColor Red
    exit 1
}

# Verificar se buildx está disponível
try {
    docker buildx version | Out-Null
} catch {
    Write-Host "❌ Docker Buildx não encontrado. Por favor, atualize Docker." -ForegroundColor Red
    exit 1
}

# Criar builder se não existir
$builderExists = docker buildx ls | Select-String "textify-builder"
if (-not $builderExists) {
    Write-Host "🔧 Criando builder multi-plataforma..." -ForegroundColor Yellow
    docker buildx create --name textify-builder --use
}

# Usar o builder
docker buildx use textify-builder

# Fazer login no Docker Hub (se necessário)
if ($env:DOCKER_USERNAME -and $env:DOCKER_PASSWORD) {
    Write-Host "🔐 Fazendo login no Docker Hub..." -ForegroundColor Yellow
    $env:DOCKER_PASSWORD | docker login -u $env:DOCKER_USERNAME --password-stdin
}

# Build da imagem
Write-Host "🏗️ Construindo imagem..." -ForegroundColor Yellow
docker buildx build `
    --platform $PLATFORMS `
    --file docker/Dockerfile `
    --tag "$REGISTRY/$IMAGE_NAME`:$Version" `
    --tag "$REGISTRY/$IMAGE_NAME`:latest" `
    --push `
    .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Build concluído com sucesso!" -ForegroundColor Green
    Write-Host "   Imagem publicada: $REGISTRY/$IMAGE_NAME`:$Version" -ForegroundColor Green

    # Verificar se a imagem foi criada
    Write-Host "🔍 Verificando imagem..." -ForegroundColor Yellow
    docker buildx imagetools inspect "$REGISTRY/$IMAGE_NAME`:$Version"

    Write-Host ""
    Write-Host "🎉 Imagem Docker do Textify está pronta!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Para usar a imagem:" -ForegroundColor Cyan
    Write-Host "   docker run -p 8000:8000 $REGISTRY/$IMAGE_NAME`:$Version" -ForegroundColor White
    Write-Host ""
    Write-Host "📋 Para usar com Docker Compose:" -ForegroundColor Cyan
    Write-Host "   cd docker; docker-compose up" -ForegroundColor White
} else {
    Write-Host "❌ Erro durante o build!" -ForegroundColor Red
    exit 1
}