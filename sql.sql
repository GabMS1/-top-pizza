CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(255) NOT NULL,
    descricao_categoria TEXT
);

CREATE TABLE IF NOT EXISTS produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(255) NOT NULL,
    descricao_produto TEXT,
    id_categoria INT,
    foto_url VARCHAR(255) DEFAULT NULL,
    visivel BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE IF NOT EXISTS precos (
    id_preco INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    tamanho VARCHAR(50),
    valor DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    nome_produto VARCHAR(255),
    valor_final DECIMAL(10, 2),
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_pedido VARCHAR(50) DEFAULT 'Recebido',
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- Inserção de categorias com base no cardápio
INSERT INTO categorias (nome_categoria, descricao_categoria) VALUES
('Pizzas Doces', 'Pizzas com sabores doces, como chocolate e frutas.'),
('Pizzas Tradicionais', 'Pizzas com sabores clássicos e tradicionais.'),
('Pizzas Premium', 'Pizzas com ingredientes e combinações especiais.'),
('Porções', 'Diversas opções de porções para acompanhar.'),
('Bebidas', 'Refrigerantes, sucos e cervejas.');

-- Inserção de Produtos da categoria 'Bebidas'
SET @id_bebidas = (SELECT id_categoria FROM categorias WHERE nome_categoria = 'Bebidas');

INSERT INTO produtos (nome_produto, descricao_produto, id_categoria) VALUES
('PEPSI ZERO/NORMAL', 'Refrigerante Lata', @id_bebidas),
('COCA ZERO/NORMAL', 'Refrigerante Lata', @id_bebidas),
('SUKITA', 'Refrigerante Lata', @id_bebidas),
('SPRIT', 'Refrigerante Lata', @id_bebidas),
('ANTARCTICA', 'Refrigerante Lata', @id_bebidas),
('COCA KS', 'Refrigerante KS', @id_bebidas),
('FANTA KS', 'Refrigerante KS', @id_bebidas),
('COCA ZERO/NORMAL 600ML', 'Refrigerante 600ML', @id_bebidas),
('H20 600ML', 'Refrigerante 600ML', @id_bebidas),
('H20 LIMONETO 600ML', 'Refrigerante 600ML', @id_bebidas),
('ANTÁRTICA 1 LITRO', 'Refrigerante 1 Litro', @id_bebidas),
('COCA 1 LITRO', 'Refrigerante 1 Litro', @id_bebidas),
('MINEIRO 1,5 LITROS', 'Refrigerante 1,5 Litros', @id_bebidas),
('COCA NORMAL 1,5 LITROS', 'Refrigerante 1,5 Litros', @id_bebidas),
('ANTARCTICA 1,5 LITROS', 'Refrigerante 1,5 Litros', @id_bebidas),
('H20 1,5 LITROS', 'Refrigerante 1,5 Litros', @id_bebidas),
('H20 LIMONETO 1,5 LITROS', 'Refrigerante 1,5 Litros', @id_bebidas),
('SUCOS NATURAL COPO 350ML', NULL, @id_bebidas),
('SUCO NATURAL JARRA 750ML', NULL, @id_bebidas),
('SUCOS CAIXA 200ML', NULL, @id_bebidas),
('SUCOS CAIXA 1 LITRO', NULL, @id_bebidas),
('COCA ZERO 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('COCA 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('PEPSI ZERO 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('PEPSI 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('ANTARCTICA 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('MINEIRO 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('SUKITA LARANJA 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('SUKITA UVA 2 LITROS', 'Refrigerante 2 Litros', @id_bebidas),
('ORIGINAL LATA', 'Cerveja Lata', @id_bebidas),
('AMSTEL LATA', 'Cerveja Lata', @id_bebidas),
('SKOL LATA', 'Cerveja Lata', @id_bebidas),
('ANTARCTICA LATA', 'Cerveja Lata', @id_bebidas),
('SUB-ZERO LATA', 'Cerveja Lata', @id_bebidas),
('BRAHMA LATA', 'Cerveja Lata', @id_bebidas),
('HEINEKEIN LONG NECK', 'Cerveja Long Neck', @id_bebidas),
('CORONA/SPATEN/AMSTEL SOL LONG NECK', 'Cerveja Long Neck', @id_bebidas),
('ICE LONG NECK', 'Cerveja Long Neck', @id_bebidas),
('HEINEKEIN 600ML', 'Cerveja 600ML', @id_bebidas),
('AMSTEL 600ML', 'Cerveja 600ML', @id_bebidas),
('ORIGINAL 600ML', 'Cerveja 600ML', @id_bebidas);


-- Inserção dos preços de Bebidas
INSERT INTO precos (id_produto, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'PEPSI ZERO/NORMAL'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA ZERO/NORMAL'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUKITA' AND descricao_produto = 'Refrigerante Lata'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SPRIT'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ANTARCTICA' AND descricao_produto = 'Refrigerante Lata'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA KS'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FANTA KS'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA ZERO/NORMAL 600ML'), 7.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'H20 600ML'), 6.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'H20 LIMONETO 600ML'), 6.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ANTÁRTICA 1 LITRO'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA 1 LITRO'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MINEIRO 1,5 LITROS'), 8.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA NORMAL 1,5 LITROS'), 11.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ANTARCTICA 1,5 LITROS'), 11.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'H20 1,5 LITROS'), 9.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'H20 LIMONETO 1,5 LITROS'), 9.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUCOS NATURAL COPO 350ML'), 15.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUCO NATURAL JARRA 750ML'), 23.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUCOS CAIXA 200ML'), 3.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUCOS CAIXA 1 LITRO'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA ZERO 2 LITROS'), 14.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA 2 LITROS'), 12.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PEPSI ZERO 2 LITROS'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PEPSI 2 LITROS'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ANTARCTICA 2 LITROS'), 12.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MINEIRO 2 LITROS'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUKITA LARANJA 2 LITROS'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUKITA UVA 2 LITROS'), 10.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ORIGINAL LATA'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'AMSTEL LATA'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SKOL LATA'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ANTARCTICA LATA'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUB-ZERO LATA'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BRAHMA LATA'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'HEINEKEIN LONG NECK'), 9.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CORONA/SPATEN/AMSTEL SOL LONG NECK'), 8.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ICE LONG NECK'), 9.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'HEINEKEIN 600ML'), 17.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'AMSTEL 600ML'), 13.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ORIGINAL 600ML'), 15.00);


-- Inserção de Porções da categoria 'Porções'
SET @id_porcoes = (SELECT id_categoria FROM categorias WHERE nome_categoria = 'Porções');

INSERT INTO produtos (nome_produto, descricao_produto, id_categoria) VALUES
('BATATA SIMPLES', NULL, @id_porcoes),
('BATATA COMPLETA', NULL, @id_porcoes),
('CONTRA FILÉ ACEBOLADO', NULL, @id_porcoes),
('CALABRESA ACEBOLADA', NULL, @id_porcoes),
('FRANGO A PASSARINHO', NULL, @id_porcoes);

-- Inserção dos preços de Porções
INSERT INTO precos (id_produto, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'BATATA SIMPLES'), 25.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BATATA COMPLETA'), 30.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CONTRA FILÉ ACEBOLADO'), 35.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALABRESA ACEBOLADA'), 25.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO A PASSARINHO'), 30.00);