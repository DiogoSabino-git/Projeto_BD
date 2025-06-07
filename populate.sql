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


