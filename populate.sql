-- TABELA LEILÕES

CALL criar_leilao('2025-06-01', 'Lisboa');
CALL criar_leilao('2025-06-02', 'Porto');
CALL criar_leilao('2025-06-03', 'Coimbra');
CALL criar_leilao('2025-06-04', 'Braga');
CALL criar_leilao('2025-06-05', 'Aveiro');
CALL criar_leilao('2025-06-06', 'Faro');
CALL criar_leilao('2025-06-07', 'Leiria');
CALL criar_leilao('2025-06-08', 'Évora');
CALL criar_leilao('2025-06-09', 'Setúbal');
CALL criar_leilao('2025-06-10', 'Viseu');
CALL criar_leilao('2025-06-11', 'Guimarães');
CALL criar_leilao('2025-06-12', 'Viana do Castelo');
CALL criar_leilao('2025-06-13', 'Funchal');
CALL criar_leilao('2025-06-14', 'Ponta Delgada');
CALL criar_leilao('2025-06-15', 'Cascais');
CALL criar_leilao('2025-06-16', 'Sintra');
CALL criar_leilao('2025-06-17', 'Almada');
CALL criar_leilao('2025-06-18', 'Barreiro');
CALL criar_leilao('2025-06-19', 'Tomar');
CALL criar_leilao('2025-06-20', 'Beja');


-- TABELA CATEGORIAS

INSERT INTO categorias (nome_c) VALUES 
('Smartphones'),
('Portáteis / Laptops'),
('Tablets'),
('Televisões'),
('Consolas de Jogos'),
('Componentes de PC'),
('Acessórios de Computador'),
('Smartwatches / Wearables'),
('Câmaras Digitais'),
('Drones'),
('Sistemas de Som / Colunas'),
('Auscultadores / Headphones'),
('Electrodomésticos Pequenos'),
('Equipamentos de Rede'),
('Armazenamento Externo'),
('Dispositivos de Streaming'),
('Projetores'),
('Equipamento de Impressão'),
('Acessórios para Telemóvel'),
('Dispositivos Usados');


-- TABELA SESSOES

INSERT INTO sessoes (hora_inicio, hora_fim, id_leilao) VALUES
('09:00:00', '10:00:00', 1),
('10:00:00', '11:00:00', 2),
('11:00:00', '12:00:00', 3),
('12:00:00', '13:00:00', 4),
('13:00:00', '14:00:00', 5),
('14:00:00', '15:00:00', 6),
('15:00:00', '16:00:00', 7),
('16:00:00', '17:00:00', 8),
('17:00:00', '18:00:00', 9),
('18:00:00', '19:00:00', 10),
('09:00:00', '10:00:00', 11),
('10:00:00', '11:00:00', 12),
('11:00:00', '12:00:00', 13),
('12:00:00', '13:00:00', 14),
('13:00:00', '14:00:00', 15),
('14:00:00', '15:00:00', 16),
('15:00:00', '16:00:00', 17),
('16:00:00', '17:00:00', 18),
('17:00:00', '18:00:00', 19),
('18:00:00', '19:00:00', 20);


-- TABELA SESSAO_CATEGORIA

INSERT INTO sessao_categoria (id_sessao, nome_c) VALUES
(1, 'Smartphones'),
(2, 'Portáteis / Laptops'),
(2, 'Acessórios de Computador'),
(3, 'Tablets'),
(4, 'Televisões'),
(4, 'Sistemas de Som / Colunas'),
(4, 'Projetores'),
(5, 'Consolas de Jogos'),
(6, 'Componentes de PC'),
(6, 'Armazenamento Externo'),
(7, 'Auscultadores / Headphones'),
(8, 'Equipamentos de Rede'),
(9, 'Electrodomésticos Pequenos'),
(9, 'Equipamento de Impressão'),
(10, 'Dispositivos Usados'),
(11, 'Smartwatches / Wearables'),
(12, 'Drones'),
(12, 'Acessórios para Telemóvel'),
(13, 'Smartphones'),
(14, 'Portáteis / Laptops'),
(14, 'Componentes de PC'),
(15, 'Tablets'),
(15, 'Dispositivos de Streaming'),
(16, 'Televisões'),
(17, 'Consolas de Jogos'),
(17, 'Auscultadores / Headphones'),
(18, 'Projetores'),
(19, 'Equipamentos de Rede'),
(19, 'Armazenamento Externo'),
(20, 'Electrodomésticos Pequenos'),
(20, 'Dispositivos Usados'),
(20, 'Smartphones');

-- TABELA PESSOAS
INSERT INTO pessoas (cc, nome, email, telefone) VALUES
-- compradores
('123456789012', 'Ana Silva', 'ana.silva@example.com', '912345678'),
('123456789013', 'Bruno Costa', 'bruno.costa@example.com', '913456789'),
('123456789014', 'Carla Pereira', 'carla.pereira@example.com', '914567890'),
('123456789015', 'Daniel Sousa', 'daniel.sousa@example.com', '915678901'),
('123456789016', 'Elisa Martins', 'elisa.martins@example.com', '916789012'),
('123456789017', 'Fábio Lopes', 'fabio.lopes@example.com', '917890123'),
('123456789018', 'Gabriela Fernandes', 'gabriela.fernandes@example.com', '918901234'),
('123456789019', 'Hugo Almeida', 'hugo.almeida@example.com', '919012345'),
('123456789020', 'Inês Ribeiro', 'ines.ribeiro@example.com', '920123456'),
('123456789021', 'João Gomes', 'joao.gomes@example.com', '921234567'),
('123456789022', 'Karina Duarte', 'karina.duarte@example.com', '922345678'),
('123456789023', 'Luís Moreira', 'luis.moreira@example.com', '923456789'),
('123456789024', 'Marta Carvalho', 'marta.carvalho@example.com', '924567890'),
('123456789025', 'Nuno Teixeira', 'nuno.teixeira@example.com', '925678901'),
('123456789026', 'Olga Freitas', 'olga.freitas@example.com', '926789012'),
('123456789027', 'Pedro Machado', 'pedro.machado@example.com', '927890123'),
('123456789028', 'Quim Monteiro', 'quim.monteiro@example.com', '928901234'),
('123456789029', 'Rita Lopes', 'rita.lopes@example.com', '929012345'),
('123456789030', 'Sofia Nunes', 'sofia.nunes@example.com', '930123456'),
('123456789031', 'Tiago Fernandes', 'tiago.fernandes@example.com', '931234567'),
-- vendedores
('123456789032', 'Miguel Silva', 'miguel.silva@example.com', '932345678'),
('123456789033', 'Carolina Sousa', 'carolina.sousa@example.com', '933456789'),
('123456789034', 'Rafael Costa', 'rafael.costa@example.com', '934567890'),
('123456789035', 'Patrícia Fernandes', 'patricia.fernandes@example.com', '935678901'),
('123456789036', 'João Rodrigues', 'joao.rodrigues@example.com', '936789012'),
('123456789037', 'Sandra Marques', 'sandra.marques@example.com', '937890123'),
('123456789038', 'Diogo Pereira', 'diogo.pereira@example.com', '938901234'),
('123456789039', 'Mariana Lopes', 'mariana.lopes@example.com', '939012345'),
('123456789040', 'André Almeida', 'andre.almeida@example.com', '940123456'),
('123456789041', 'Mónica Teixeira', 'monica.teixeira@example.com', '941234567'),
('123456789042', 'Pedro Machado', 'pedro.machado@example.com', '942345678'),
('123456789043', 'Raquel Nunes', 'raquel.nunes@example.com', '943456789'),
('123456789044', 'Filipe Monteiro', 'filipe.monteiro@example.com', '944567890'),
('123456789045', 'Sílvia Carvalho', 'silvia.carvalho@example.com', '945678901'),
('123456789046', 'Rui Fernandes', 'rui.fernandes@example.com', '946789012'),
('123456789047', 'Isabel Santos', 'isabel.santos@example.com', '947890123'),
('123456789048', 'Carlos Pinto', 'carlos.pinto@example.com', '948901234'),
('123456789049', 'Teresa Lopes', 'teresa.lopes@example.com', '949012345'),
('123456789050', 'Vítor Gomes', 'vitor.gomes@example.com', '950123456'),
('123456789051', 'Helena Dias', 'helena.dias@example.com', '951234567');

-- TABELA PARA OS COMPRADORES

INSERT INTO compradores (cc) VALUES
('123456789012'),
('123456789013'),
('123456789014'),
('123456789015'),
('123456789016'),
('123456789017'),
('123456789018'),
('123456789019'),
('123456789020'),
('123456789021'),
('123456789022'),
('123456789023'),
('123456789024'),
('123456789025'),
('123456789026'),
('123456789027'),
('123456789028'),
('123456789029'),
('123456789030'),
('123456789031');

-- TABELA PARA OS VENDEDORES

INSERT INTO vendedores (cc) VALUES
('123456789032'),
('123456789033'),
('123456789034'),
('123456789035'),
('123456789036'),
('123456789037'),
('123456789038'),
('123456789039'),
('123456789040'),
('123456789041'),
('123456789042'),
('123456789043'),
('123456789044'),
('123456789045'),
('123456789046'),
('123456789047'),
('123456789048'),
('123456789049'),
('123456789050'),
('123456789051');


-- TABELA LOTES

INSERT INTO lotes (id_lote, id_sessao, cc) VALUES
(1, 1, '123456789032'),
(2, 1, '123456789033'),
(3, 2, '123456789034'),
(4, 2, '123456789035'),
(5, 3, '123456789036'),
(6, 3, '123456789037'),
(7, 4, '123456789038'),
(8, 4, '123456789039'),
(9, 5, '123456789040'),
(10, 5, '123456789041'),
(11, 6, '123456789042'),
(12, 7, '123456789043'),
(13, 8, '123456789044'),
(14, 9, '123456789045'),
(15, 10, '123456789046'),
(16, 11, '123456789047'),
(17, 12, '123456789048'),
(18, 13, '123456789049'),
(19, 14, '123456789050'),
(20, 15, '123456789051');


-- TABELA ARTIGOS 

CALL adicionar_artigo(1, 150.00, 'Smartphone Samsung Galaxy S21, novo');
CALL adicionar_artigo(1, 140.00, 'Smartphone Samsung Galaxy S20, usado');
CALL adicionar_artigo(2, 1200.50, 'Portátil Dell Inspiron 15, 16GB RAM');
CALL adicionar_artigo(2, 1100.00, 'Portátil HP Pavilion, 8GB RAM');
CALL adicionar_artigo(3, 300.00, 'Tablet Apple iPad Air, 64GB');
CALL adicionar_artigo(4, 450.00, 'Televisor LG 43 polegadas 4K');
CALL adicionar_artigo(4, 430.00, 'Televisor Samsung 40 polegadas Full HD');
CALL adicionar_artigo(5, 350.00, 'Consola Sony PlayStation 5, usada');
CALL adicionar_artigo(6, 250.00, 'Placa gráfica NVIDIA GTX 1660');
CALL adicionar_artigo(6, 230.00, 'Placa gráfica AMD Radeon RX 580');
CALL adicionar_artigo(7, 45.00, 'Teclado mecânico RGB, usado');
CALL adicionar_artigo(8, 180.00, 'Smartwatch Fitbit Versa 3');
CALL adicionar_artigo(9, 400.00, 'Câmara digital Canon EOS 2000D');
CALL adicionar_artigo(10, 600.00, 'Drone DJI Mini 2');
CALL adicionar_artigo(10, 580.00, 'Drone DJI Spark');
CALL adicionar_artigo(11, 100.00, 'Colunas Bluetooth JBL Charge 4');
CALL adicionar_artigo(12, 85.00, 'Auscultadores Sony WH-CH510');
CALL adicionar_artigo(13, 90.00, 'Máquina de café portátil');
CALL adicionar_artigo(14, 75.00, 'Router WiFi TP-Link AC1200');
CALL adicionar_artigo(15, 60.00, 'Disco externo SSD 500GB');
CALL adicionar_artigo(15, 55.00, 'Disco externo HDD 1TB');
CALL adicionar_artigo(16, 50.00, 'Dispositivo de streaming Amazon Fire TV');
CALL adicionar_artigo(17, 350.00, 'Projetor portátil Epson');
CALL adicionar_artigo(18, 120.00, 'Impressora HP DeskJet');
CALL adicionar_artigo(19, 20.00, 'Capa protetora para telemóvel');
CALL adicionar_artigo(20, 100.00, 'Smartphone usado, em bom estado');
