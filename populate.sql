-- TABELA LEILÕES

CALL sp_criar_leilao('2025-06-01', '2025-06-02', 'Lisboa','Leilão de Eletrónicos - Smartphones');
CALL sp_criar_leilao('2025-06-02', '2025-06-03', 'Porto','Leilão de Eletrónicos - Portáteis e Acessórios');
CALL sp_criar_leilao('2025-06-03', '2025-06-04', 'Coimbra','Leilão de Eletrónicos - Tablets');
CALL sp_criar_leilao('2025-06-04', '2025-06-05', 'Braga','Leilão de Eletrónicos - Televisões, Colunas e Projetores');
CALL sp_criar_leilao('2025-06-05', '2025-06-06', 'Aveiro','Leilão de Eletrónicos - Consolas de Jogos');
CALL sp_criar_leilao('2025-06-06', '2025-06-07', 'Faro','Leilão de Eletrónicos - Componentes de PC e Armazenamento Externo');
CALL sp_criar_leilao('2025-06-07', '2025-06-08', 'Leiria','Leilão de Eletrónicos - Auscultadores');
CALL sp_criar_leilao('2025-06-08', '2025-06-09', 'Évora','Leilão de Eletrónicos - Equipamentos de Rede');
CALL sp_criar_leilao('2025-06-09', '2025-06-10', 'Setúbal','Leilão de Eletrónicos - Electrodomésticos e Impressoras');
CALL sp_criar_leilao('2025-06-10', '2025-06-11', 'Viseu','Leilão de Eletrónicos - Dispositivos Usados');
CALL sp_criar_leilao('2025-06-11', '2025-06-12', 'Guimarães','Leilão de Eletrónicos - Smartwatches');
CALL sp_criar_leilao('2025-06-12', '2025-06-13', 'Viana do Castelo','Leilão de Eletrónicos - Drones e Acessórios para Telemóveis');
CALL sp_criar_leilao('2025-06-13', '2025-06-14', 'Funchal','Leilão de Eletrónicos - Smartphones');
CALL sp_criar_leilao('2025-06-14', '2025-06-15', 'Ponta Delgada','Leilão de Eletrónicos - Portáteis e Componentes de PC');
CALL sp_criar_leilao('2025-06-15', '2025-06-16', 'Cascais','Leilão de Eletrónicos - Tablets e Dispositivos de Streaming');
CALL sp_criar_leilao('2025-06-16', '2025-06-17', 'Sintra','Leilão de Eletrónicos - Televisões');
CALL sp_criar_leilao('2025-06-17', '2025-06-18', 'Almada','Leilão de Eletrónicos - Consolas de Jogos e Auscultadores');
CALL sp_criar_leilao('2025-06-18', '2025-06-19', 'Barreiro','Leilão de Eletrónicos - Projetores');
CALL sp_criar_leilao('2025-06-19', '2025-06-20', 'Tomar','Leilão de Eletrónicos - Equipamento de Rede e Armazenamento Externo');
CALL sp_criar_leilao('2025-06-20', '2025-06-21', 'Beja','Leilão de Eletrónicos - Electrodomésticos e Smartphones Usados');

CALL sp_clonar_leilao(1);

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
-- INSERT INTO pessoas (cc, nome, email, telefone) VALUES
-- compradores
CALL sp_adicionar_pessoa('123456789012', 'Ana Silva', 'ana.silva@example.com', '912345678');
CALL sp_adicionar_pessoa('123456789013', 'Bruno Costa', 'bruno.costa@example.com', '913456789');
CALL sp_adicionar_pessoa('123456789014', 'Carla Pereira', 'carla.pereira@example.com', '914567890');
CALL sp_adicionar_pessoa('123456789015', 'Daniel Sousa', 'daniel.sousa@example.com', '915678901');
CALL sp_adicionar_pessoa('123456789016', 'Elisa Martins', 'elisa.martins@example.com', '916789012');
CALL sp_adicionar_pessoa('123456789017', 'Fábio Lopes', 'fabio.lopes@example.com', '917890123');
CALL sp_adicionar_pessoa('123456789018', 'Gabriela Fernandes', 'gabriela.fernandes@example.com', '918901234');
CALL sp_adicionar_pessoa('123456789019', 'Hugo Almeida', 'hugo.almeida@example.com', '919012345');
CALL sp_adicionar_pessoa('123456789020', 'Inês Ribeiro', 'ines.ribeiro@example.com', '920123456');
CALL sp_adicionar_pessoa('123456789021', 'João Gomes', 'joao.gomes@example.com', '921234567');
CALL sp_adicionar_pessoa('123456789022', 'Karina Duarte', 'karina.duarte@example.com', '922345678');
CALL sp_adicionar_pessoa('123456789023', 'Luís Moreira', 'luis.moreira@example.com', '923456789');
CALL sp_adicionar_pessoa('123456789024', 'Marta Carvalho', 'marta.carvalho@example.com', '924567890');
CALL sp_adicionar_pessoa('123456789025', 'Nuno Teixeira', 'nuno.teixeira@example.com', '925678901');
CALL sp_adicionar_pessoa('123456789026', 'Olga Freitas', 'olga.freitas@example.com', '926789012');
CALL sp_adicionar_pessoa('123456789027', 'Pedro Machado', 'pedro.machado@example.com', '927890123');
CALL sp_adicionar_pessoa('123456789028', 'Quim Monteiro', 'quim.monteiro@example.com', '928901234');
CALL sp_adicionar_pessoa('123456789029', 'Rita Lopes', 'rita.lopes@example.com', '929012345');
CALL sp_adicionar_pessoa('123456789030', 'Sofia Nunes', 'sofia.nunes@example.com', '930123456');
CALL sp_adicionar_pessoa('123456789031', 'Tiago Fernandes', 'tiago.fernandes@example.com', '931234567');
-- vendedores
CALL sp_adicionar_pessoa('123456789032', 'Miguel Silva', 'miguel.silva@example.com', '932345678');
CALL sp_adicionar_pessoa('123456789033', 'Carolina Sousa', 'carolina.sousa@example.com', '933456789');
CALL sp_adicionar_pessoa('123456789034', 'Rafael Costa', 'rafael.costa@example.com', '934567890');
CALL sp_adicionar_pessoa('123456789035', 'Patrícia Fernandes', 'patricia.fernandes@example.com', '935678901');
CALL sp_adicionar_pessoa('123456789036', 'João Rodrigues', 'joao.rodrigues@example.com', '936789012');
CALL sp_adicionar_pessoa('123456789037', 'Sandra Marques', 'sandra.marques@example.com', '937890123');
CALL sp_adicionar_pessoa('123456789038', 'Diogo Pereira', 'diogo.pereira@example.com', '938901234');
CALL sp_adicionar_pessoa('123456789039', 'Mariana Lopes', 'mariana.lopes@example.com', '939012345');
CALL sp_adicionar_pessoa('123456789040', 'André Almeida', 'andre.almeida@example.com', '940123456');
CALL sp_adicionar_pessoa('123456789041', 'Mónica Teixeira', 'monica.teixeira@example.com', '941234567');
CALL sp_adicionar_pessoa('123456789042', 'Pedro Machado', 'pedro.machado@example.com', '942345678');
CALL sp_adicionar_pessoa('123456789043', 'Raquel Nunes', 'raquel.nunes@example.com', '943456789');
CALL sp_adicionar_pessoa('123456789044', 'Filipe Monteiro', 'filipe.monteiro@example.com', '944567890');
CALL sp_adicionar_pessoa('123456789045', 'Sílvia Carvalho', 'silvia.carvalho@example.com', '945678901');
CALL sp_adicionar_pessoa('123456789046', 'Rui Fernandes', 'rui.fernandes@example.com', '946789012');
CALL sp_adicionar_pessoa('123456789047', 'Isabel Santos', 'isabel.santos@example.com', '947890123');
CALL sp_adicionar_pessoa('123456789048', 'Carlos Pinto', 'carlos.pinto@example.com', '948901234');
CALL sp_adicionar_pessoa('123456789049', 'Teresa Lopes', 'teresa.lopes@example.com', '949012345');
CALL sp_adicionar_pessoa('123456789050', 'Vítor Gomes', 'vitor.gomes@example.com', '950123456');
CALL sp_adicionar_pessoa('123456789051', 'Helena Dias', 'helena.dias@example.com', '951234567');

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

CALL sp_adicionar_artigo(1, 150.00, 'Smartphone Samsung Galaxy S21, novo');
CALL sp_adicionar_artigo(1, 140.00, 'Smartphone Samsung Galaxy S20, usado');
CALL sp_adicionar_artigo(2, 1200.50, 'Portátil Dell Inspiron 15, 16GB RAM');
CALL sp_adicionar_artigo(2, 1100.00, 'Portátil HP Pavilion, 8GB RAM');
CALL sp_adicionar_artigo(3, 300.00, 'Tablet Apple iPad Air, 64GB');
CALL sp_adicionar_artigo(4, 450.00, 'Televisor LG 43 polegadas 4K');
CALL sp_adicionar_artigo(4, 430.00, 'Televisor Samsung 40 polegadas Full HD');
CALL sp_adicionar_artigo(5, 350.00, 'Consola Sony PlayStation 5, usada');
CALL sp_adicionar_artigo(6, 250.00, 'Placa gráfica NVIDIA GTX 1660');
CALL sp_adicionar_artigo(6, 230.00, 'Placa gráfica AMD Radeon RX 580');
CALL sp_adicionar_artigo(7, 45.00, 'Teclado mecânico RGB, usado');
CALL sp_adicionar_artigo(8, 180.00, 'Smartwatch Fitbit Versa 3');
CALL sp_adicionar_artigo(9, 400.00, 'Câmara digital Canon EOS 2000D');
CALL sp_adicionar_artigo(10, 600.00, 'Drone DJI Mini 2');
CALL sp_adicionar_artigo(10, 580.00, 'Drone DJI Spark');
CALL sp_adicionar_artigo(11, 100.00, 'Colunas Bluetooth JBL Charge 4');
CALL sp_adicionar_artigo(12, 85.00, 'Auscultadores Sony WH-CH510');
CALL sp_adicionar_artigo(13, 90.00, 'Máquina de café portátil');
CALL sp_adicionar_artigo(14, 75.00, 'Router WiFi TP-Link AC1200');
CALL sp_adicionar_artigo(15, 60.00, 'Disco externo SSD 500GB');
CALL sp_adicionar_artigo(15, 55.00, 'Disco externo HDD 1TB');
CALL sp_adicionar_artigo(16, 50.00, 'Dispositivo de streaming Amazon Fire TV');
CALL sp_adicionar_artigo(17, 350.00, 'Projetor portátil Epson');
CALL sp_adicionar_artigo(18, 120.00, 'Impressora HP DeskJet');
CALL sp_adicionar_artigo(19, 20.00, 'Capa protetora para telemóvel');
CALL sp_adicionar_artigo(20, 100.00, 'Smartphone usado, em bom estado');


-- TABELA LICITACOES

CALL sp_novo_lance(170.00, '123456789013', 1);  
CALL sp_novo_lance(180.00, '123456789012', 1);
CALL sp_novo_lance(145.00, '123456789014', 2);  
CALL sp_novo_lance(1250.00, '123456789015', 3);  
CALL sp_novo_lance(1150.00, '123456789016', 4);  
CALL sp_novo_lance(310.00, '123456789017', 5);   
CALL sp_novo_lance(460.00, '123456789018', 6);   
CALL sp_novo_lance(440.00, '123456789019', 7);   
CALL sp_novo_lance(360.00, '123456789020', 8);  
CALL sp_novo_lance(260.00, '123456789021', 9);   
CALL sp_novo_lance(240.00, '123456789022', 10);  
CALL sp_novo_lance(50.00, '123456789023', 11);   
CALL sp_novo_lance(200.00, '123456789024', 12);  
CALL sp_novo_lance(420.00, '123456789025', 13);  
CALL sp_novo_lance(650.00, '123456789026', 14);  
CALL sp_novo_lance(590.00, '123456789027', 15);  
CALL sp_novo_lance(110.00, '123456789028', 16);  
CALL sp_novo_lance(90.00, '123456789029', 17);   
CALL sp_novo_lance(100.00, '123456789030', 18);  
CALL sp_novo_lance(80.00, '123456789031', 19);   
CALL sp_novo_lance(70.00, '123456789012', 20);   
CALL sp_novo_lance(105.00, '123456789013', 21); 
CALL sp_novo_lance(95.00, '123456789014', 22);      
CALL sp_novo_lance(110.00, '123456789017', 25);  

-- TABELA METODOSPAGAMENTO

INSERT INTO metodosPagamento (n_cartao, data_val, cc) VALUES
('1111222233334441', '2026-05-31', '123456789012'),
('1111222233334442', '2027-08-15', '123456789013'),
('1111222233334443', '2025-12-10', '123456789014'),
('1111222233334444', '2028-01-20', '123456789015'),
('1111222233334445', '2026-09-01', '123456789016'),
('1111222233334446', '2027-03-30', '123456789017'),
('1111222233334447', '2026-07-07', '123456789018'),
('1111222233334448', '2029-04-14', '123456789019'),
('1111222233334449', '2026-02-28', '123456789020'),
('1111222233334450', '2025-11-05', '123456789021'),
('1111222233334451', '2028-06-22', '123456789022'),
('1111222233334452', '2027-10-09', '123456789023'),
('1111222233334453', '2026-12-31', '123456789024'),
('1111222233334454', '2027-01-18', '123456789025'),
('1111222233334455', '2026-04-12', '123456789026'),
('1111222233334456', '2029-08-08', '123456789027'),
('1111222233334457', '2025-09-27', '123456789028'),
('1111222233334458', '2027-07-13', '123456789029'),
('1111222233334459', '2026-03-03', '123456789030'),
('1111222233334460', '2028-12-25', '123456789031');


-- TABELA COMPRA

CALL sp_fechar_compra(1);
CALL sp_fechar_compra(2);
CALL sp_fechar_compra(3);
CALL sp_fechar_compra(4);
CALL sp_fechar_compra(5);
CALL sp_fechar_compra(6);
CALL sp_fechar_compra(7);
CALL sp_fechar_compra(8);
CALL sp_fechar_compra(9);
CALL sp_fechar_compra(10);
CALL sp_fechar_compra(11);
CALL sp_fechar_compra(12);
CALL sp_fechar_compra(13);
CALL sp_fechar_compra(14);
CALL sp_fechar_compra(15);
CALL sp_fechar_compra(16);
CALL sp_fechar_compra(17);
CALL sp_fechar_compra(18);
CALL sp_fechar_compra(19);
CALL sp_fechar_compra(20);


-- TABELA RESULTADOS

CALL sp_adicionar_participante(17,123456789023);
CALL sp_registar_resultado(17,25);

CALL sp_registar_resultado(1,1);
CALL sp_registar_resultado(1,2);
CALL sp_registar_resultado(1,3);
CALL sp_registar_resultado(1,4);
CALL sp_registar_resultado(1,5);
CALL sp_registar_resultado(2,6);
CALL sp_registar_resultado(2,7);
CALL sp_registar_resultado(2,8);
CALL sp_registar_resultado(3,9);
CALL sp_registar_resultado(3,10);
CALL sp_registar_resultado(3,11); 
CALL sp_registar_resultado(4,12); 
CALL sp_registar_resultado(4,13);
CALL sp_registar_resultado(5,14); 
CALL sp_registar_resultado(5,15); 
CALL sp_registar_resultado(5,16);
CALL sp_registar_resultado(6,17); 
CALL sp_registar_resultado(7,18);
CALL sp_registar_resultado(8,19); 
CALL sp_registar_resultado(9,20); 
CALL sp_registar_resultado(10,21); 
CALL sp_registar_resultado(10,22); 
CALL sp_registar_resultado(11,23); 
CALL sp_registar_resultado(14,24); 
