-- =====================================================
-- CRIAÇÃO DO BANCO
-- =====================================================

CREATE DATABASE IF NOT EXISTS pedido_vendas
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE pedido_vendas;

-- =====================================================
-- TABELA CLIENTES
-- =====================================================

CREATE TABLE clientes (
    codigo INT NOT NULL,
    nome VARCHAR(120) NOT NULL,
    cidade VARCHAR(120),
    uf CHAR(2),

    CONSTRAINT pk_clientes
        PRIMARY KEY (codigo)
);

CREATE INDEX idx_clientes_nome ON clientes(nome);


-- =====================================================
-- TABELA PRODUTOS
-- =====================================================

CREATE TABLE produtos (
    codigo INT NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_produtos
        PRIMARY KEY (codigo)
);

CREATE INDEX idx_produtos_descricao ON produtos(descricao);


-- =====================================================
-- TABELA PEDIDOS (CABEÇALHO)
-- =====================================================

CREATE TABLE pedidos (
    numero_pedido INT NOT NULL,
    data_emissao DATE NOT NULL,
    codigo_cliente INT NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,

    CONSTRAINT pk_pedidos
        PRIMARY KEY (numero_pedido),

    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (codigo_cliente)
        REFERENCES clientes(codigo)
);

CREATE INDEX idx_pedidos_cliente ON pedidos(codigo_cliente);


-- =====================================================
-- TABELA ITENS DO PEDIDO
-- =====================================================

CREATE TABLE pedido_produtos (
    id INT NOT NULL AUTO_INCREMENT,
    numero_pedido INT NOT NULL,
    codigo_produto INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,

    CONSTRAINT pk_pedido_produtos
        PRIMARY KEY (id),

    CONSTRAINT fk_item_pedido
        FOREIGN KEY (numero_pedido)
        REFERENCES pedidos(numero_pedido),

    CONSTRAINT fk_item_produto
        FOREIGN KEY (codigo_produto)
        REFERENCES produtos(codigo)
);

CREATE INDEX idx_pedido_produtos_pedido
ON pedido_produtos(numero_pedido);

CREATE INDEX idx_pedido_produtos_produto
ON pedido_produtos(codigo_produto);


-- =====================================================
-- INSERT CLIENTES (20 REGISTROS)
-- =====================================================

INSERT INTO clientes (codigo, nome, cidade, uf) VALUES
(1,'João Silva','Ribeirão Preto','SP'),
(2,'Maria Oliveira','Campinas','SP'),
(3,'Carlos Pereira','São Paulo','SP'),
(4,'Fernanda Souza','Belo Horizonte','MG'),
(5,'Paulo Santos','Uberlândia','MG'),
(6,'Juliana Costa','Curitiba','PR'),
(7,'Roberto Lima','Londrina','PR'),
(8,'Patricia Alves','Florianópolis','SC'),
(9,'Lucas Fernandes','Joinville','SC'),
(10,'Ricardo Gomes','Porto Alegre','RS'),
(11,'Mariana Barbosa','Caxias do Sul','RS'),
(12,'Eduardo Carvalho','Brasília','DF'),
(13,'Camila Rocha','Goiânia','GO'),
(14,'André Martins','Salvador','BA'),
(15,'Beatriz Ribeiro','Fortaleza','CE'),
(16,'Thiago Teixeira','Recife','PE'),
(17,'Bruna Monteiro','Natal','RN'),
(18,'Gabriel Duarte','Maceió','AL'),
(19,'Renata Melo','Belém','PA'),
(20,'Felipe Nunes','Manaus','AM');


-- =====================================================
-- INSERT PRODUTOS (20 REGISTROS)
-- =====================================================

INSERT INTO produtos (codigo, descricao, preco_venda) VALUES
(1,'Teclado Mecânico RGB',320.00),
(2,'Mouse Gamer 16000 DPI',210.00),
(3,'Monitor LED 24"',980.00),
(4,'Notebook Core i5',4200.00),
(5,'Notebook Core i7',6200.00),
(6,'SSD 1TB NVMe',540.00),
(7,'SSD 512GB',310.00),
(8,'HD Externo 2TB',480.00),
(9,'Memória RAM 16GB',290.00),
(10,'Memória RAM 32GB',590.00),
(11,'Placa de Vídeo RTX 4060',3100.00),
(12,'Placa de Vídeo RTX 4070',5200.00),
(13,'Fonte 750W Gold',420.00),
(14,'Gabinete Gamer',350.00),
(15,'Water Cooler',460.00),
(16,'Headset Gamer',280.00),
(17,'Webcam Full HD',210.00),
(18,'Cadeira Gamer',1250.00),
(19,'Mesa para Setup Gamer',890.00),
(20,'Mousepad XXL',120.00);