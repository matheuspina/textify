# Script PowerShell para enviar Tarefy ao GitHub
Write-Host "========================================" -ForegroundColor Blue
Write-Host "    ENVIANDO TAREFY PARA O GITHUB" -ForegroundColor Blue
Write-Host "========================================" -ForegroundColor Blue
Write-Host ""

# Verificar se Git está instalado
try {
    $gitVersion = git --version 2>$null
    Write-Host "✅ Git encontrado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git não encontrado!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Por favor, instale o Git primeiro:" -ForegroundColor Yellow
    Write-Host "https://git-scm.com/download/win" -ForegroundColor Cyan
    Write-Host ""
    Read-Host "Pressione Enter para sair"
    exit 1
}

Write-Host ""

try {
    # Inicializar repositório
    Write-Host "📦 Inicializando repositório Git..." -ForegroundColor Yellow
    git init
    
    # Configurar branch principal
    Write-Host "🔧 Configurando branch principal..." -ForegroundColor Yellow
    git branch -M main
    
    # Adicionar todos os arquivos
    Write-Host "📁 Adicionando arquivos..." -ForegroundColor Yellow
    git add .
    
    # Fazer commit inicial
    Write-Host "💾 Fazendo commit inicial..." -ForegroundColor Yellow
    git commit -m "Initial commit: Tarefy v1.9.0 - Conversor Universal de Arquivos para LLMs"
    
    # Adicionar repositório remoto
    Write-Host "🔗 Conectando ao repositório remoto..." -ForegroundColor Yellow
    git remote add origin git@github.com:matheuspina/textify.git
    
    # Fazer push
    Write-Host "🚀 Enviando para o GitHub..." -ForegroundColor Yellow
    git push -u origin main
    
    Write-Host ""
    Write-Host "✅ Projeto enviado com sucesso para o GitHub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "🌐 Acesse: https://github.com/matheuspina/textify" -ForegroundColor Cyan
    
} catch {
    Write-Host ""
    Write-Host "❌ Erro durante o processo:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "Verifique se:" -ForegroundColor Yellow
    Write-Host "1. Você tem acesso ao repositório" -ForegroundColor White
    Write-Host "2. Sua chave SSH está configurada" -ForegroundColor White
    Write-Host "3. O repositório existe no GitHub" -ForegroundColor White
}

Write-Host ""
Read-Host "Pressione Enter para sair"