@echo off
echo ========================================
echo    ENVIANDO TAREFY PARA O GITHUB
echo ========================================
echo.

REM Verificar se Git está instalado
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Git não encontrado!
    echo.
    echo Por favor, instale o Git primeiro:
    echo https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo ✅ Git encontrado!
echo.

REM Inicializar repositório
echo 📦 Inicializando repositório Git...
git init

REM Configurar branch principal
echo 🔧 Configurando branch principal...
git branch -M main

REM Adicionar todos os arquivos
echo 📁 Adicionando arquivos...
git add .

REM Fazer commit inicial
echo 💾 Fazendo commit inicial...
git commit -m "Initial commit: Tarefy v1.9.0 - Conversor Universal de Arquivos para LLMs"

REM Adicionar repositório remoto
echo 🔗 Conectando ao repositório remoto...
git remote add origin git@github.com:matheuspina/textify.git

REM Fazer push
echo 🚀 Enviando para o GitHub...
git push -u origin main

echo.
echo ✅ Projeto enviado com sucesso para o GitHub!
echo.
echo 🌐 Acesse: https://github.com/matheuspina/textify
echo.
pause