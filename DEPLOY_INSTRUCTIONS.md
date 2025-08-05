# 🚀 Instruções para Envio do Tarefy ao GitHub

## ⚠️ Pré-requisitos

### 1. Instalar Git
Se o Git não estiver instalado, baixe e instale de:
- **Windows**: https://git-scm.com/download/win
- **macOS**: https://git-scm.com/download/mac
- **Linux**: `sudo apt install git` (Ubuntu/Debian) ou `sudo yum install git` (CentOS/RHEL)

### 2. Configurar Git (primeira vez)
```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@exemplo.com"
```

### 3. Configurar Chave SSH (recomendado)
```bash
# Gerar chave SSH
ssh-keygen -t ed25519 -C "seu.email@exemplo.com"

# Adicionar ao ssh-agent
ssh-add ~/.ssh/id_ed25519

# Copiar chave pública
cat ~/.ssh/id_ed25519.pub
```
Depois adicione a chave pública em: https://github.com/settings/keys

## 🎯 Método 1: Script Automático

### Windows (Batch)
```cmd
cd "c:\Users\Matheus Pina\OneDrive - y57ps\Área de Trabalho\convert_all_files"
scripts\deploy-to-github.bat
```

### Windows (PowerShell)
```powershell
cd "c:\Users\Matheus Pina\OneDrive - y57ps\Área de Trabalho\convert_all_files"
.\scripts\deploy-to-github.ps1
```

### Linux/macOS
```bash
cd "/path/to/convert_all_files"
chmod +x scripts/setup.sh
./scripts/setup.sh
```

## 🔧 Método 2: Comandos Manuais

### 1. Navegar para o diretório
```bash
cd "c:\Users\Matheus Pina\OneDrive - y57ps\Área de Trabalho\convert_all_files"
```

### 2. Inicializar repositório Git
```bash
git init
```

### 3. Configurar branch principal
```bash
git branch -M main
```

### 4. Adicionar todos os arquivos
```bash
git add .
```

### 5. Fazer commit inicial
```bash
git commit -m "Initial commit: Tarefy v1.9.0 - Conversor Universal de Arquivos para LLMs"
```

### 6. Adicionar repositório remoto
```bash
git remote add origin git@github.com:matheuspina/textify.git
```

### 7. Enviar para GitHub
```bash
git push -u origin main
```

## 🌐 Método 3: GitHub CLI (Alternativo)

Se preferir usar o GitHub CLI:

### 1. Instalar GitHub CLI
- **Windows**: https://cli.github.com/
- **macOS**: `brew install gh`
- **Linux**: https://github.com/cli/cli/blob/trunk/docs/install_linux.md

### 2. Fazer login
```bash
gh auth login
```

### 3. Criar e enviar repositório
```bash
cd "c:\Users\Matheus Pina\OneDrive - y57ps\Área de Trabalho\convert_all_files"
git init
git add .
git commit -m "Initial commit: Tarefy v1.9.0"
gh repo create matheuspina/textify --public --source=. --remote=origin --push
```

## 🔍 Verificação

Após o envio, verifique se tudo funcionou:

1. **Acesse o repositório**: https://github.com/matheuspina/textify
2. **Verifique os arquivos**: Todos os arquivos devem estar presentes
3. **Teste o CI/CD**: O GitHub Actions deve executar automaticamente
4. **Verifique a documentação**: README.md deve estar renderizado corretamente

## 🛠️ Solução de Problemas

### Erro: "Permission denied (publickey)"
- Verifique se a chave SSH está configurada corretamente
- Teste a conexão: `ssh -T git@github.com`

### Erro: "Repository not found"
- Verifique se o repositório existe no GitHub
- Confirme se você tem permissão de escrita

### Erro: "Git not found"
- Instale o Git conforme instruções acima
- Reinicie o terminal após a instalação

### Erro: "Authentication failed"
- Use HTTPS em vez de SSH: `git remote set-url origin https://github.com/matheuspina/textify.git`
- Configure token de acesso pessoal

## 📋 Checklist Pós-Deploy

- [ ] Repositório criado e acessível
- [ ] Todos os arquivos enviados
- [ ] README.md renderizado corretamente
- [ ] GitHub Actions executando
- [ ] Issues e PR templates funcionando
- [ ] Licença MIT visível
- [ ] Documentação completa

## 🎉 Próximos Passos

Após o envio bem-sucedido:

1. **Configure branch protection** em Settings > Branches
2. **Ative GitHub Pages** se necessário
3. **Configure secrets** para CI/CD (Docker Hub, etc.)
4. **Adicione colaboradores** se necessário
5. **Crie primeira release** com tag v1.9.0

## 📞 Suporte

Se encontrar problemas:
1. Verifique os logs de erro
2. Consulte a documentação do Git: https://git-scm.com/doc
3. Verifique a documentação do GitHub: https://docs.github.com/

---

**Repositório de destino**: `git@github.com:matheuspina/textify.git`
**Branch principal**: `main`
**Versão**: `v1.9.0`