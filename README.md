# 🏥 Módulo de Prescrição de Medicamentos

Sistema de gerenciamento de prescrições médicas desenvolvido com **Spring Boot 3.4.0** e **MySQL 8.0**.

## 🚀 Tecnologias

- **Java 24**
- **Spring Boot 3.4.0**
- **Spring Data JPA**
- **HikariCP** (connection pooling)
- **MySQL 8.0** (Banco Legado)
- **Bootstrap 5.3**
- **Font Awesome 6.4**

## ⚙️ Configuração

### 1. Configurar Banco de Dados

Edite o arquivo `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/SEU_BANCO
spring.datasource.username=SEU_USUARIO
spring.datasource.password=SUA_SENHA
```

⚠️ **IMPORTANTE**: O banco é **legado** e não será alterado (`ddl-auto=none`).

### 2. Estrutura do Banco

O sistema espera as seguintes tabelas:

#### Tabelas Utilizadas
- `PESSOA` (IDPESSOA como PK, ID_DOCUMENTO separado)
- `PACIENTE`
- `PROFISSIONAL`
- `ESPECIALIDADE`
- `PROCEDIMENTO`
- `PRONTUARIO_TEMPORARIO` (tabela principal)

### 3. Executar o Projeto

```bash
# Compilar
mvn clean install

# Executar
mvn spring-boot:run
```

O servidor estará disponível em: `http://localhost:8080`

## 📋 Funcionalidades

### Backend (REST API)

- `GET /api/prescricoes` - Lista prescrições do profissional (filtra PENDENTE e REPROVADO)
- `GET /api/prescricoes/{id}` - Detalhes de uma prescrição
- `PUT /api/prescricoes/editar` - Edita prescrição PENDENTE
- `PUT /api/prescricoes/corrigir` - Corrige prescrição REPROVADA
- `DELETE /api/prescricoes/cancelar/{id}` - Cancela prescrição

### Frontend

Acesse: `http://localhost:8080/index.html`

**Features:**
- ✅ Listagem de prontuários em cards
- ✅ Cards vermelhos para prontuários reprovados
- ✅ Modal para visualizar detalhes completos
- ✅ Modal para editar prontuários PENDENTES
- ✅ Modal para corrigir prontuários REPROVADOS com motivo da reprovação
- ✅ Modal para cancelar/excluir prontuários
- ✅ Design limpo (azul #4A90E2 + branco)
- ✅ Interface totalmente estática (sem hover effects)
- ✅ Botão "Enviar Correção" verde

## 🔐 Contexto de Usuário

O sistema identifica o profissional logado:

- **Profissional ID**: 99 (hardcoded no UserContextService)

## 📊 Fluxo de Aprovação

1. **PENDENTE** → Prontuário criado, aguardando aprovação do supervisor
2. **REPROVADO** → Prontuário reprovado, pode ser corrigido pelo profissional
3. **APROVADO** → Prontuário aprovado, **não aparece mais** (foi movido para PRONTUARIO definitivo)

⚠️ **Importante**: Prontuários APROVADOS são automaticamente movidos da tabela temporária para a definitiva.

## 🎨 Design

- Header azul gradiente (#4A90E2)
- Cards brancos com sombra suave
- Cards vermelhos (#ffebee) para reprovações
- Interface estática (sem animações hover)
- Layout responsivo com Bootstrap 5.3
- Ícones Font Awesome 6.4

## 📁 Estrutura do Projeto

```
src/main/java/com/prescricao/medicamentos/
├── PrescricaoMedicamentosApplication.java
├── controller/
│   └── PrescricaoController.java
├── dto/
│   ├── PrescricaoDTO.java
│   ├── SalvarPrescricaoRequest.java
│   └── CorrigirPrescricaoRequest.java
├── model/
│   ├── Documento.java
│   ├── Pessoa.java
│   ├── Paciente.java
│   ├── Profissional.java
│   ├── Especialidade.java
│   ├── Procedimento.java
│   └── ProntuarioTemporario.java
├── repository/
│   ├── ProntuarioTemporarioRepository.java
│   ├── PacienteRepository.java
│   ├── ProfissionalRepository.java
│   ├── PessoaRepository.java
│   ├── EspecialidadeRepository.java
│   └── ProcedimentoRepository.java
└── service/
    ├── UserContextService.java
    └── PrescricaoService.java

src/main/resources/
├── application.properties
└── static/
    ├── index.html
    ├── css/
    │   └── styles.css
    └── js/
        └── app.js
```

## 📝 Notas Importantes

1. O nome do **Paciente** vem de: `PRONTUARIO_TEMPORARIO → PACIENTE → ID_DOCUMENTO → PESSOA.NOMEPESSOA`

2. O nome do **Profissional** vem de: `PRONTUARIO_TEMPORARIO → PROFISSIONAL → ID_DOCUMENTO → PESSOA.NOMEPESSOA`

3. O sistema **NÃO modifica** a estrutura do banco (`ddl-auto=none`)

4. **Sem Lombok**: Todos os getters/setters são manuais (Java 24 incompatível)

5. **Pacientes são sempre Pessoas Físicas** (contexto médico/odontológico)

6. **HikariCP configurado** com pool mínimo para banco compartilhado

## 🐛 Troubleshooting

- **Erro de conexão**: Verifique as credenciais no `application.properties`
- **Tabela não encontrada**: Confirme que todas as tabelas existem no banco
- **CORS**: O backend está configurado com `@CrossOrigin(origins = "*")`

---

**Desenvolvido com ❤️ para sistemas de saúde universitários**
