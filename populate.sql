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