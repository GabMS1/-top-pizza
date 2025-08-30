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
('Pizzas Tradicionais', 'Pizzas com sabores classicos e tradicionais.'),
('Pizzas Premium', 'Pizzas com ingredientes e combinacoes especiais.'),
('Porções', 'Diversas opções de porções para acompanhar.'),
('Bebidas', 'Refrigerantes, sucos e cervejas.');

-- Inserção de Produtos da categoria 'Pizzas Doces'
SET @id_doces = (SELECT id_categoria FROM categorias WHERE nome_categoria = 'Pizzas Doces');
INSERT INTO produtos (nome_produto, descricao_produto, id_categoria) VALUES
('CHOCOLATE C/MORANGO', 'MUSSARELA, CHOCOLATE E MORANGO', @id_doces),
('CHOCOLATE', 'MUSSARELA, CHOCOLATE E GRANULADO', @id_doces),
('PRESTIGIO', 'MUSSARELA, CHOCOLATE E COCO RALADO', @id_doces),
('ROMEU E JULIETA', 'MUSSARELA E GOIABADA', @id_doces),
('BANANINHA', 'MUSSARELA, BANANA, CANELA E ACUCAR', @id_doces),
('CHOCONANA', 'MUSSARELA, CHOCOLATE E BANANA FATIADA', @id_doces),
('SONHO DE VALSA', 'MUSSARELA, CHOCOLATE E SONHO DE VALSA', @id_doces),
('BANANA TROPICAL', 'MUSSARELA, BANANA, CATUPIRY, CANELA E ACUCAR', @id_doces);

-- Inserção dos preços de Pizzas Doces
SET @id_chocolate_morango = (SELECT id_produto FROM produtos WHERE nome_produto = 'CHOCOLATE C/MORANGO' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_chocolate_morango, 'PEQUENA', 32.00), (@id_chocolate_morango, 'MEDIA', 42.00), (@id_chocolate_morango, 'GRANDE', 50.00);

SET @id_chocolate = (SELECT id_produto FROM produtos WHERE nome_produto = 'CHOCOLATE' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_chocolate, 'PEQUENA', 29.00), (@id_chocolate, 'MEDIA', 39.00), (@id_chocolate, 'GRANDE', 44.00);

SET @id_prestigio = (SELECT id_produto FROM produtos WHERE nome_produto = 'PRESTIGIO' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_prestigio, 'PEQUENA', 29.00), (@id_prestigio, 'MEDIA', 39.00), (@id_prestigio, 'GRANDE', 44.00);

SET @id_romeu_julieta = (SELECT id_produto FROM produtos WHERE nome_produto = 'ROMEU E JULIETA' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_romeu_julieta, 'PEQUENA', 29.00), (@id_romeu_julieta, 'MEDIA', 39.00), (@id_romeu_julieta, 'GRANDE', 44.00);

SET @id_bananinha = (SELECT id_produto FROM produtos WHERE nome_produto = 'BANANINHA' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_bananinha, 'PEQUENA', 29.00), (@id_bananinha, 'MEDIA', 39.00), (@id_bananinha, 'GRANDE', 44.00);

SET @id_choconana = (SELECT id_produto FROM produtos WHERE nome_produto = 'CHOCONANA' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_choconana, 'PEQUENA', 29.00), (@id_choconana, 'MEDIA', 39.00), (@id_choconana, 'GRANDE', 44.00);

SET @id_sonho_de_valsa = (SELECT id_produto FROM produtos WHERE nome_produto = 'SONHO DE VALSA' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_sonho_de_valsa, 'PEQUENA', 29.00), (@id_sonho_de_valsa, 'MEDIA', 39.00), (@id_sonho_de_valsa, 'GRANDE', 44.00);

SET @id_banana_tropical = (SELECT id_produto FROM produtos WHERE nome_produto = 'BANANA TROPICAL' AND id_categoria = @id_doces);
INSERT INTO precos (id_produto, tamanho, valor) VALUES (@id_banana_tropical, 'PEQUENA', 29.00), (@id_banana_tropical, 'MEDIA', 39.00), (@id_banana_tropical, 'GRANDE', 44.00);


-- Inserção de Produtos da categoria 'Pizzas Tradicionais'
SET @id_tradicionais = (SELECT id_categoria FROM categorias WHERE nome_categoria = 'Pizzas Tradicionais');
INSERT INTO produtos (nome_produto, descricao_produto, id_categoria) VALUES
('MODA DA CASA', 'MOLHO, MUSSARELA, FRANGO, TOMATE, CALABRESA, BACON EM CUBOS, PALMITO E OREGANO', @id_tradicionais),
('CARNE DE SOL', 'MOLHO, CARNE DE SOL, MUSSARELA, MILHO, TOMATE, CATUPIRY, CEBOLA E OREGANO', @id_tradicionais),
('MEXICANA', 'MOLHO, MUSSARELA, TOMATE, CALABRESA, BACON EM CUBOS, PIMENTA CALABRESA, PIMENTA DO REINO, CEBOLA E OREGANO', @id_tradicionais),
('PORTUGUESA', 'MOLHO, MUSSARELA, TOMATE, PRESUNTO, OVO, CEBOLA E OREGANO', @id_tradicionais),
('CHAMPIGNON', 'MOLHO, TOMATE, MUSSARELA, COGUMELO CHAMPIGNON, TOMATE SECO E OREGANO', @id_tradicionais),
('LOMBO TROPICAL', 'MOLHO, MUSSARELA, LOMBINHO, ACABAXI, TOMATE, CEBOLA, BACON, AZEITONA E OREGANO', @id_tradicionais),
('BAIANA', 'MOLHO, MUSSARELA, CALABRESA, BACON EM CUBOS, PIMENTA CALABRESA E OREGANO', @id_tradicionais),
('FRANGO C/BACON', 'MOLHO, MUSSARELA, TOMATE, FRANGO DESFIADO, CATUPIRY, BACON EM CUBOS E OREGANO', @id_tradicionais),
('FRANGO C/ CATUPIRY', 'MOLHO, MUSSARELA, FRANGO DESFIADO, MILHO, CATUPIRY E OREGANO', @id_tradicionais),
('CALABRESA', 'MOLHO, MUSSARELA, CALABRESA, CEBOLA E OREGANO', @id_tradicionais),
('LOMBO CANADENSE', 'MOLHO, MUSSARELA, LOMBINHO, CATUPIRY, CEBOLA E OREGANO', @id_tradicionais),
('LOMBO AO BARBECUE', 'MOLHO, MUSSARELA, LOMBINHO, BARBECUE, CEBOLA, AZEITONA E OREGANO', @id_tradicionais),
('BACON', 'MOLHO, MUSSARELA, BACON EM CUBOS, CEBOLA E OREGANO', @id_tradicionais),
('4 QUEIJOS', 'MOLHO, MUSSARELA, PROVOLONE, GORGONZOLA, CATUPIRY E OREGANO', @id_tradicionais),
('VEGETARIANA ESPECIAL', 'MOLHO, MUSSARELA, TOMATE, PALMITO, ERVILHA, MILHO, COGUMELO CHAMPIGNON E OREGANO', @id_tradicionais),
('3 QUEIJOS', 'MOLHO, MUSSARELA, PROVOLONE, CATUPIRY E OREGANO', @id_tradicionais),
('PRESUNTO', 'MOLHO, MUSSARELA, PRESUNTO, TOMATE, CEBOLA E OREGANO', @id_tradicionais),
('NAPOLITANA', 'MOLHO, MUSSARELA, TOMATE, PALMITO E OREGANO', @id_tradicionais),
('MARGUERITA', 'MOLHO, MUSSARELA, TOMATE, MANJERICAO E OREGANO', @id_tradicionais),
('ATUM', 'MOLHO, MUSSARELA, ATUM, TOMATE E OREGANO', @id_tradicionais),
('ALHO E OLEO', 'MOLHO, MUSSARELA, TOMATE, ALHO CROCANTE AO OLEO E OREGANO', @id_tradicionais),
('PALMITO', 'MOLHO, MUSSARELA, PALMITO E OREGANO', @id_tradicionais),
('MUSSARELA', 'MOLHO, MUSSARELA E OREGANO', @id_tradicionais),
('CAIPIRINHA', 'MOLHO, MUSSARELA, FRANGO, OVO E OREGANO', @id_tradicionais),
('CACHORRO QUENTE', 'MOLHO, MUSSARELA, SALSICHA, MILHO, BATATA PALHA E OREGANO', @id_tradicionais),
('BAURU', 'MOLHO, MUSSARELA, FRANGO, MILHO, ERVILHA, PALMITO E OREGANO', @id_tradicionais),
('VINAGRETE', 'MOLHO, MUSSARELA, VINAGRETE, AZEITONA E OREGANO', @id_tradicionais),
('MILHO VERDE', 'MOLHO, MUSSARELA, TOMATE, MILHO, AZEITONA E OREGANO', @id_tradicionais),
('MUSSARELA FIT', 'MOLHO, MUSSARELA, TOMATE, AZEITONA E OREGAMO', @id_tradicionais),
('TOMATE SECO C/RUCULA', 'MOLHO, MUSSARELA, TOMATE SECO, RUCULA, AZEITONA, PALMITO E OREGANO', @id_tradicionais),
('BROCOLIS', 'MOLHO, MUSSARELA, COBERTURA DE BROCOLIS, CEBOLA, ALHO FRITO, AZEITONA E OREGANO', @id_tradicionais),
('VEGETARIANA', 'MOLHO, MUSSARELA, TOMATE, PALMITO, RUCULA E OREGANO', @id_tradicionais),
('VEGANA', 'MOLHO, MUSSARELA, ABOBRINHA GRATINADA, TOMATE, CATUPIRY. CEBOLA E OREGANO', @id_tradicionais),
('PROVOLONE', 'MOLHO, MUSSARELA, PROVOLONE, TOMATE, AZEITONA E OREGANO', @id_tradicionais),
('BERINGELA', 'MOLHO, MUSSARELA, TOMATE, BERINGELA, CEBOLA. PIMENTA DO REIN E OREGANO', @id_tradicionais);

-- Inserção dos preços de Pizzas Tradicionais
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'MODA DA CASA' AND id_categoria = @id_tradicionais), 'PEQUENA', 42.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MODA DA CASA' AND id_categoria = @id_tradicionais), 'MEDIA', 52.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MODA DA CASA' AND id_categoria = @id_tradicionais), 'GRANDE', 62.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CARNE DE SOL' AND id_categoria = @id_tradicionais), 'PEQUENA', 42.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CARNE DE SOL' AND id_categoria = @id_tradicionais), 'MEDIA', 52.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CARNE DE SOL' AND id_categoria = @id_tradicionais), 'GRANDE', 62.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'MEXICANA' AND id_categoria = @id_tradicionais), 'PEQUENA', 42.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MEXICANA' AND id_categoria = @id_tradicionais), 'MEDIA', 52.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MEXICANA' AND id_categoria = @id_tradicionais), 'GRANDE', 62.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'PORTUGUESA' AND id_categoria = @id_tradicionais), 'PEQUENA', 37.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PORTUGUESA' AND id_categoria = @id_tradicionais), 'MEDIA', 47.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PORTUGUESA' AND id_categoria = @id_tradicionais), 'GRANDE', 57.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CHAMPIGNON' AND id_categoria = @id_tradicionais), 'PEQUENA', 37.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CHAMPIGNON' AND id_categoria = @id_tradicionais), 'MEDIA', 47.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CHAMPIGNON' AND id_categoria = @id_tradicionais), 'GRANDE', 57.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO TROPICAL' AND id_categoria = @id_tradicionais), 'PEQUENA', 42.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO TROPICAL' AND id_categoria = @id_tradicionais), 'MEDIA', 52.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO TROPICAL' AND id_categoria = @id_tradicionais), 'GRANDE', 62.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'BAIANA' AND id_categoria = @id_tradicionais), 'PEQUENA', 37.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BAIANA' AND id_categoria = @id_tradicionais), 'MEDIA', 47.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BAIANA' AND id_categoria = @id_tradicionais), 'GRANDE', 57.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO C/BACON' AND id_categoria = @id_tradicionais), 'PEQUENA', 37.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO C/BACON' AND id_categoria = @id_tradicionais), 'MEDIA', 47.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO C/BACON' AND id_categoria = @id_tradicionais), 'GRANDE', 57.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO C/ CATUPIRY' AND id_categoria = @id_tradicionais), 'PEQUENA', 34.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO C/ CATUPIRY' AND id_categoria = @id_tradicionais), 'MEDIA', 44.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO C/ CATUPIRY' AND id_categoria = @id_tradicionais), 'GRANDE', 52.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALABRESA' AND id_categoria = @id_tradicionais), 'PEQUENA', 34.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALABRESA' AND id_categoria = @id_tradicionais), 'MEDIA', 44.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALABRESA' AND id_categoria = @id_tradicionais), 'GRANDE', 52.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO CANADENSE' AND id_categoria = @id_tradicionais), 'PEQUENA', 34.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO CANADENSE' AND id_categoria = @id_tradicionais), 'MEDIA', 44.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO CANADENSE' AND id_categoria = @id_tradicionais), 'GRANDE', 52.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO AO BARBECUE' AND id_categoria = @id_tradicionais), 'PEQUENA', 34.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO AO BARBECUE' AND id_categoria = @id_tradicionais), 'MEDIA', 44.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'LOMBO AO BARBECUE' AND id_categoria = @id_tradicionais), 'GRANDE', 52.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'BACON' AND id_categoria = @id_tradicionais), 'PEQUENA', 34.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BACON' AND id_categoria = @id_tradicionais), 'MEDIA', 44.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BACON' AND id_categoria = @id_tradicionais), 'GRANDE', 52.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = '4 QUEIJOS' AND id_categoria = @id_tradicionais), 'PEQUENA', 34.00),
((SELECT id_produto FROM produtos WHERE nome_produto = '4 QUEIJOS' AND id_categoria = @id_tradicionais), 'MEDIA', 44.00),
((SELECT id_produto FROM produtos WHERE nome_produto = '4 QUEIJOS' AND id_categoria = @id_tradicionais), 'GRANDE', 52.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGETARIANA ESPECIAL' AND id_categoria = @id_tradicionais), 'PEQUENA', 34.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGETARIANA ESPECIAL' AND id_categoria = @id_tradicionais), 'MEDIA', 44.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGETARIANA ESPECIAL' AND id_categoria = @id_tradicionais), 'GRANDE', 52.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = '3 QUEIJOS' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = '3 QUEIJOS' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = '3 QUEIJOS' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'PRESUNTO' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PRESUNTO' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PRESUNTO' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'NAPOLITANA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'NAPOLITANA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'NAPOLITANA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'MARGUERITA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MARGUERITA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MARGUERITA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'ATUM' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ATUM' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ATUM' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'ALHO E OLEO' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ALHO E OLEO' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ALHO E OLEO' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'PALMITO' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PALMITO' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PALMITO' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'MUSSARELA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MUSSARELA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MUSSARELA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAIPIRINHA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAIPIRINHA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAIPIRINHA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CACHORRO QUENTE' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CACHORRO QUENTE' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CACHORRO QUENTE' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'BAURU' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BAURU' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BAURU' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'VINAGRETE' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VINAGRETE' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VINAGRETE' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'MILHO VERDE' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MILHO VERDE' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MILHO VERDE' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'MUSSARELA FIT' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MUSSARELA FIT' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MUSSARELA FIT' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'TOMATE SECO C/RUCULA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'TOMATE SECO C/RUCULA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'TOMATE SECO C/RUCULA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'BROCOLIS' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BROCOLIS' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BROCOLIS' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGETARIANA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGETARIANA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGETARIANA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGANA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGANA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'VEGANA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'PROVOLONE' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PROVOLONE' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PROVOLONE' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'BERINGELA' AND id_categoria = @id_tradicionais), 'PEQUENA', 29.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BERINGELA' AND id_categoria = @id_tradicionais), 'MEDIA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BERINGELA' AND id_categoria = @id_tradicionais), 'GRANDE', 44.00);


-- Inserção de Produtos da categoria 'Pizzas Premium'
SET @id_premium = (SELECT id_categoria FROM categorias WHERE nome_categoria = 'Pizzas Premium');
INSERT INTO produtos (nome_produto, descricao_produto, id_categoria) VALUES
('CAMARAO', 'MOLHO, MUSSARELA, TOMATE, CAMARAO, TOMATE CEREJA. OREGANO E MANJERICAO', @id_premium),
('GOIANA', 'MOLHO, MUSSARELA, FRANGO, PEQUI, PALMITO, CATUPIRY, PIMENTAO, CEBOLA, AZEITONA E OREGANO', @id_premium),
('MODA DO CHEFE', 'MOLHO, MISSARELA, CARNE DE SOL, BACON EM CUBOS, CATUPIRY, PESSEGO, MILHO, ALHO GRANULADO E OREGANO', @id_premium),
('TOP MAIS', 'MOLHO, MUSSARELA, CONTRA FILE ACEBOLADO, MOLHO BARBECUE. MILHO, PIMENTA BIQUINHO E OREGANO', @id_premium),
('A MAIS TOP', 'MOLHO, MUSSARELA, FRANGO, CALABRESA, BACON EM CUBOS. PRESUNTO TOMATE, CATUPIRY, PALMITO, MILHO, CEBOLA, AZEITONA E OREGANO', @id_premium),
('SERTANEJA', 'MOLHO, MUSSARELA, CREAM CHEESE, CARNE DE SOL, CEBOLA, PIMENTA BIQUINHO, PIMENTAO E OREGANO', @id_premium),
('PEPPERONI', 'MOLHO, MUSSARRLA, PEPPERONI, AZEITONA, CEBOLA E OREGANO', @id_premium),
('CABOCLA', 'MOLHO, MUSSARELA, BROCOLIS, REQUEIJAO, BACON EM CUBOS, ALHO GRANULADO, PIMENTA BIQUINHO E OREGANO', @id_premium),
('PATANEIRA', 'MOLHO, MUSSARELA, CALABRESA RALADA, BACON EM CUBOS, PRESUNTO. TOMATE, CEBOLA, AZEITONA E OREGANO', @id_premium),
('A MAIS TOP DA TOP', 'MOLHO, MUSSARELA, CARNE MOIDA, GUARIROBA OU PALMITO, TOMATE, CATUPIRY, OREGANO', @id_premium),
('CAMARAO AO ALHO E OLEO', 'MOLHO, MUSSARELA, CAMARAO, ALHO FRITO, TOMATE CEREJA, MANJERICAO E OREGANO', @id_premium),
('FILE C/ CHAMPIGNON', 'MOLHO. MUSSARELA, FILE ACEBOLADO, MILHO, TOMATE, COGUMELO CHAMPIGNON E OREGANO', @id_premium),
('CARNE DE SOL C/CREAM CHEESE', 'MOLHO, MUSSARELA, CARNE DE SOL, CREAM CHEESE, PIMENTA BIQUINHO E OREGANO', @id_premium),
('STROGONOFF', 'MOLHO, MUSSARELA, STROGONOFF DE FRANGO, BATATA PALHA E OREGANO', @id_premium),
('SALAMINHO', 'MOLHO, MUSSARELA, SALAMINHO, TOMATE. CEBOLA. AZEITONA E OREGANO', @id_premium),
('CALIFORNIA', 'MOLHO, MUSSARELA, PEITO DE PERU. FIGO EM CALDA, PESSEGO EM CALDA. CREME DE LEITE, UVA PASSA', @id_premium),
('FESTA', 'MUSSARELA, CHOCOLATE, BIS, CONFETE, KIT KAT', @id_premium);

-- Inserção dos preços de Pizzas Premium
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAMARAO' AND id_categoria = @id_premium), 'PEQUENA', 65.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAMARAO' AND id_categoria = @id_premium), 'MEDIA', 75.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAMARAO' AND id_categoria = @id_premium), 'GRANDE', 85.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'GOIANA' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'GOIANA' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'GOIANA' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'MODA DO CHEFE' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MODA DO CHEFE' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'MODA DO CHEFE' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'TOP MAIS' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'TOP MAIS' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'TOP MAIS' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'A MAIS TOP' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'A MAIS TOP' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'A MAIS TOP' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'SERTANEJA' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SERTANEJA' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SERTANEJA' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'PEPPERONI' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PEPPERONI' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PEPPERONI' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CABOCLA' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CABOCLA' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CABOCLA' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'PATANEIRA' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PATANEIRA' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'PATANEIRA' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'A MAIS TOP DA TOP' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'A MAIS TOP DA TOP' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'A MAIS TOP DA TOP' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAMARAO AO ALHO E OLEO' AND id_categoria = @id_premium), 'PEQUENA', 65.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAMARAO AO ALHO E OLEO' AND id_categoria = @id_premium), 'MEDIA', 75.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CAMARAO AO ALHO E OLEO' AND id_categoria = @id_premium), 'GRANDE', 85.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'FILE C/ CHAMPIGNON' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FILE C/ CHAMPIGNON' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FILE C/ CHAMPIGNON' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CARNE DE SOL C/CREAM CHEESE' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CARNE DE SOL C/CREAM CHEESE' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CARNE DE SOL C/CREAM CHEESE' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'STROGONOFF' AND id_categoria = @id_premium), 'PEQUENA', 42.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'STROGONOFF' AND id_categoria = @id_premium), 'MEDIA', 52.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'STROGONOFF' AND id_categoria = @id_premium), 'GRANDE', 62.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'SALAMINHO' AND id_categoria = @id_premium), 'PEQUENA', 59.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SALAMINHO' AND id_categoria = @id_premium), 'MEDIA', 69.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SALAMINHO' AND id_categoria = @id_premium), 'GRANDE', 79.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALIFORNIA' AND id_categoria = @id_premium), 'PEQUENA', 42.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALIFORNIA' AND id_categoria = @id_premium), 'MEDIA', 52.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALIFORNIA' AND id_categoria = @id_premium), 'GRANDE', 62.00);
INSERT INTO precos (id_produto, tamanho, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'FESTA' AND id_categoria = @id_premium), 'PEQUENA', 39.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FESTA' AND id_categoria = @id_premium), 'MEDIA', 49.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FESTA' AND id_categoria = @id_premium), 'GRANDE', 59.00);


-- Inserção de Produtos da categoria 'Porções'
SET @id_porcoes = (SELECT id_categoria FROM categorias WHERE nome_categoria = 'Porções');
INSERT INTO produtos (nome_produto, descricao_produto, id_categoria) VALUES
('BATATA SIMPLES', NULL, @id_porcoes),
('BATATA COMPLETA', NULL, @id_porcoes),
('CONTRA FILE ACEBOLADO', NULL, @id_porcoes),
('CALABRESA ACEBOLADA', NULL, @id_porcoes),
('FRANGO A PASSARINHO', NULL, @id_porcoes);

-- Inserção dos preços de Porções
INSERT INTO precos (id_produto, valor) VALUES
((SELECT id_produto FROM produtos WHERE nome_produto = 'BATATA SIMPLES' AND id_categoria = @id_porcoes), 25.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'BATATA COMPLETA' AND id_categoria = @id_porcoes), 30.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CONTRA FILE ACEBOLADO' AND id_categoria = @id_porcoes), 35.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'CALABRESA ACEBOLADA' AND id_categoria = @id_porcoes), 25.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FRANGO A PASSARINHO' AND id_categoria = @id_porcoes), 30.00);


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
('ANTARTICA 1 LITRO', 'Refrigerante 1 Litro', @id_bebidas),
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
((SELECT id_produto FROM produtos WHERE nome_produto = 'PEPSI ZERO/NORMAL' AND descricao_produto = 'Refrigerante Lata'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA ZERO/NORMAL' AND descricao_produto = 'Refrigerante Lata'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SUKITA' AND descricao_produto = 'Refrigerante Lata'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'SPRIT' AND descricao_produto = 'Refrigerante Lata'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ANTARCTICA' AND descricao_produto = 'Refrigerante Lata'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA KS' AND descricao_produto = 'Refrigerante KS'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'FANTA KS' AND descricao_produto = 'Refrigerante KS'), 5.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'COCA ZERO/NORMAL 600ML'), 7.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'H20 600ML'), 6.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'H20 LIMONETO 600ML'), 6.00),
((SELECT id_produto FROM produtos WHERE nome_produto = 'ANTARTICA 1 LITRO'), 10.00),
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