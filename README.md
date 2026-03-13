# Sistema de Pedidos de Venda --- Delphi (MVC + DAO)

Projeto desenvolvido em **Delphi 12** utilizando **padrão MVC e DAO**, com
persistência em **MySQL**.

O sistema permite:

-   Cadastro de pedidos de venda
-   Inclusão de produtos no pedido
-   Cálculo automático do valor total
-   Edição e remoção de itens
-   Carregamento de pedidos já gravados
-   Exclusão de pedidos

------------------------------------------------------------------------

# Tecnologias utilizadas

-   Delphi
-   FireDAC
-   MySQL
-   Padrão **MVC**
-   Padrão **DAO**
-   Programação Orientada a Objetos

------------------------------------------------------------------------

# Estrutura do Projeto

    /src
       /controller
       /dao
       /model
       /view

    /database
       create_database.sql

    /bin
       Citel.exe

    database.ini

------------------------------------------------------------------------

# Pré-requisitos

Para executar o sistema é necessário ter instalado:

-   **MySQL Server**
-   **libmariadb.dll** ou **libmysql.dll** (32 bits)
-   Delphi (para compilação do projeto)

------------------------------------------------------------------------

# Configuração do Banco de Dados

## 1. Criar o banco

Execute o script localizado em:

    database/create_database.sql

Este script irá:

-   Criar o banco `pedido_vendas`
-   Criar as tabelas:
    -   `clientes`
    -   `produtos`
    -   `pedidos`
    -   `pedido_produtos`
-   Criar **PKs, FKs e índices**
-   Inserir **20 registros de clientes e produtos para testes**

### Exemplo de execução no MySQL

``` sql
SOURCE create_database.sql;
```

ou

``` bash
mysql -u root -p < create_database.sql
```

------------------------------------------------------------------------

# Configuração da Conexão

O sistema utiliza um arquivo **database.ini** para configuração da
conexão com o banco.

Crie o arquivo na mesma pasta do executável com o seguinte conteúdo:

    [database]

    host=localhost
    port=3306
    database=pedido_vendas
    user=root
    password=123456

  Campo      Descrição
  ---------- ----------------------------
  host       Endereço do servidor MySQL
  port       Porta do MySQL
  database   Nome do banco
  user       Usuário do banco
  password   Senha

------------------------------------------------------------------------

# Executando o sistema

Após configurar o banco e o `database.ini`:

1.  Compile o projeto no Delphi **Win32**

ou

2.  Execute diretamente:

```{=html}
<!-- -->
```
    bin/Citel.exe

------------------------------------------------------------------------

# Funcionalidades

## Cadastro de Pedido

1.  Informar o **código do cliente**
2.  Inserir os produtos:
    -   Código do produto
    -   Quantidade
    -   Valor unitário
3.  Os produtos serão adicionados ao grid
4.  O valor total do pedido será calculado automaticamente
5.  Clique em **Gravar Pedido**

------------------------------------------------------------------------

## Carregar Pedido

É possível carregar pedidos já gravados informando o **número do
pedido**.

------------------------------------------------------------------------

## Excluir Pedido

Pedidos podem ser excluídos informando o **número do pedido**.

------------------------------------------------------------------------

# Regras implementadas

-   PK e FK definidas no banco
-   Controle de integridade referencial
-   Uso de **transações**
-   Uso de **SQL direto para operações**
-   Separação clara entre:

```{=html}
<!-- -->
```
    View
    Controller
    DAO
    Model

------------------------------------------------------------------------

# Padrões utilizados

## MVC

    View → Interface do usuário
    Controller → Regras de negócio
    DAO → Persistência de dados
    Model → Entidades do domínio

## DAO

Responsável por:

-   consultas
-   inserts
-   updates
-   deletes

------------------------------------------------------------------------

# Autor

Projeto desenvolvido como **teste técnico para vaga de Programador
Delphi**.
