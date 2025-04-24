# terraform-talk

### O que é Infrastructure as Code (IaC)?
- **Definição**: Gerenciamento e provisionamento de infraestrutura através de arquivos de configuração em vez de processos manuais
- **Princípios chave**:
  - Infraestrutura versionável como código-fonte
  - Automatização do provisionamento
  - Infraestrutura idempotente e consistente
  - Documentação viva e auto-explicativa
- **Benefícios**:
  - Redução de erros humanos
  - Consistência entre ambientes
  - Agilidade nas mudanças
  - Rastreabilidade e auditoria


### Por que Terraform?
- **Características principais**:
  - Linguagem declarativa (HCL - HashiCorp Configuration Language)
  - Independente de plataforma (multi-cloud)
  - Open-source com grande comunidade
  - Ecossistema extenso de providers (AWS, Azure, GCP, e centenas de outros)
- **Diferenciais competitivos**:
  - Plano de execução detalhado antes da aplicação (`terraform plan`)
  - Gerenciamento de estado da infraestrutura
  - Abordagem declarativa vs. imperativa

### Arquitetura Básica do Terraform
- **Providers**: Plugins que interagem com APIs de serviços (AWS, Azure, etc.)
- **Resources**: Objetos gerenciados pelo Terraform (EC2, S3, etc.)
- **Data Sources**: Informações de recursos existentes não gerenciados
- **Modules**: Componentes reutilizáveis de código Terraform
- **State**: Arquivo que mapeia recursos reais à configuração


### Workflow Básico do Terraform

1. **Inicialização**:
   ```bash
   terraform init
   ```
   - Baixa providers necessários
   - Configura backend para o estado
   - Inicializa módulos

2. **Planejamento**:
   ```bash
   terraform plan
   ```
   - Compara o estado atual com a configuração desejada
   - Mostra o que será criado, modificado ou destruído

3. **Aplicação**:
   ```bash
   terraform apply
   ```
   - Executa as mudanças planejadas
   - Atualiza o arquivo de estado

4. **Destruição** (quando necessário):
   ```bash
   terraform destroy
   ```
   - Remove todos os recursos gerenciados

    Problemas Comuns em Ambientes Colaborativos
- **Gerenciamento de estado**:
  - Conflitos de estado quando múltiplas pessoas executam comandos
  - Necessidade de um local centralizado e seguro para o arquivo de estado
  - Controle de concorrência (lock de estado)

- **Revisão de código**:
  - Difícil avaliar o impacto das mudanças apenas olhando o código
  - Como garantir que mudanças não causem problemas inesperados?
  - Necessidade de expertise em infraestrutura para revisar

- **Segurança e governança**:
  - Quem pode aplicar mudanças e quando?
  - Como garantir que práticas de segurança são seguidas?
  - Auditoria de mudanças

- **Consistência de processos**:
  - Garantir que todos sigam o mesmo fluxo de trabalho
  - Prevenção de aplicações manuais e não rastreáveis

## 4. Atlantis + GitHub como Solução

### O que é Atlantis?
- **Ferramenta open-source** que automatiza fluxos de trabalho do Terraform via Pull Requests
- **Funciona com**: GitHub, GitLab, Bitbucket
- **Principais recursos**:
  - Executa automaticamente `terraform plan` em PRs
  - Comenta o resultado do plano diretamente no PR
  - Permite aplicação via comandos nos comentários
  - Controla locks de estado

### Como Funciona a Integração Atlantis + GitHub

**Fluxo de trabalho**:
1. Desenvolvedor cria uma branch e modifica configuração Terraform
2. Abre Pull Request para revisão
3. Atlantis detecta a PR e executa `terraform plan`
4. O resultado é comentado na PR para revisão
5. Após aprovação, `terraform apply` pode ser executado via comentário
6. Merge somente após aplicação bem-sucedida

**Componentes**:
- Servidor Atlantis (pode ser executado como container)
- Webhook do GitHub configurado para notificar o Atlantis
- Arquivo de configuração `atlantis.yaml` nos repositórios

### Benefícios da Integração
- **Transparência**: Todo o processo documentado em PRs
- **Segurança**: Controle de acesso via GitHub
- **Colaboração**: Facilita revisão de código com contexto
- **Automação**: Reduz etapas manuais propensas a erros
- **Auditoria**: Histórico completo de mudanças de infraestrutura
- **Padronização**: Força um processo consistente para todos
