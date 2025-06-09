-- STORED PROCEDURES


-- METE OUTRA


DELIMITER $$

CREATE PROCEDURE adicionar_artigo(
	IN p_id_lote INT,
    IN p_preco_inicial NUMERIC(10,2),
    IN p_descricao VARCHAR(250)
)
BEGIN 
	INSERT INTO artigos(id_lote, preco_inicial, descricao)
    VALUES (p_id_lote, p_preco_inicial, p_descricao);
END $$
DELIMITER ;
    
    
DELIMITER $$

CREATE PROCEDURE novo_lance(
	IN p_valor NUMERIC(10,2),
    IN p_cc VARCHAR(12),
    IN p_id_artigo INT 
)
BEGIN
	DECLARE preco_inicial_artigo NUMERIC(10,2);
    DECLARE maior_lance_atual NUMERIC(10,2);
    DECLARE v_id_leilao INT;
    
    SELECT preco_inicial INTO preco_inicial_artigo
    FROM artigos
    WHERE id_artigo = p_id_artigo;
    
    SELECT MAX(valor_l) INTO maior_lance_atual
    FROM licitacoes
    WHERE id_artigo = p_id_artigo;
    
    IF p_valor <= preco_inicial_artigo THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lance deve ser maior que o preço inicial do artigo';
	END IF;
    
    IF maior_lance_atual IS NOT NULL AND p_valor <= maior_lance_atual THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Lance deve ser maior que a maior licitação atual";
	END IF;

	INSERT INTO licitacoes (valor_l, cc, id_artigo)
    VALUES (p_valor, p_cc, p_id_artigo);
    
    SELECT le.id_leilao INTO v_id_leilao
    FROM artigos a
    JOIN lotes l ON a.id_lote = l.id_lote
    JOIN sessoes s ON l.id_sessao = s.id_sessao
    JOIN leiloes le ON s.id_leilao = le.id_leilao
    WHERE a.id_artigo = p_id_artigo;

    INSERT IGNORE INTO participantes_leilao (id_leilao, cc)
    VALUES (v_id_leilao, p_cc);
    
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE fechar_compra(
	IN p_id_artigo INT
    )
BEGIN
	DECLARE v_cc VARCHAR(12);
    DECLARE v_valor NUMERIC(10,2);
    
    SELECT cc, valor_l
    INTO v_cc, v_valor
    FROM licitacoes
    WHERE id_artigo = p_id_artigo
    ORDER BY valor_l DESC
    LIMIT 1;
    
	INSERT INTO compra (id_artigo, cc, preco_final)
    VALUES (p_id_artigo, v_cc, v_valor);
END $$

DELIMITER $$

DELIMITER $$

CREATE PROCEDURE listar_lances_artigos(
	IN p_id_artigo INT
)
BEGIN
	SELECT
		l.valor_l,
        l.cc,
        p.nome,
        l.data_lance
	FROM licitacoes l
    JOIN pessoas p ON l.cc = p.cc
    WHERE l.id_artigo = p_id_artigo
    ORDER BY l.valor_l ASC;
END $$

DELIMITER ;


-- VIEWS

CREATE VIEW artigos_disponiveis AS
SELECT
	a.id_artigo,
    a.descricao,
    a.preco_inicial,
    COALESCE(MAX(l.valor_l), a.preco_inicial) AS preco_atual,
    lot.id_lote,
    s.id_sessao
FROM artigos a
JOIN lotes lot ON a.id_lote = lot.id_lote
JOIN sessoes s ON lot.id_sessao = s.id_sessao
LEFT JOIN licitacoes l ON a.id_artigo = l.id_artigo
WHERE a.id_artigo NOT IN (
	SELECT id_artigo FROM compra
)
GROUP BY a.id_artigo, a.descricao, a.preco_inicial, lot.id_lote, s.id_sessao;


CREATE VIEW leiloes_finalizados_vencedores AS
SELECT 
    c.id_artigo,
    a.descricao,
    c.cc AS comprador,
    p.nome,
    c.preco_final
FROM compra c
JOIN artigos a ON c.id_artigo = a.id_artigo
JOIN pessoas p ON c.cc = p.cc;


CREATE VIEW historico_lances_utilizadores AS
SELECT 
    l.cc,
    p.nome,
    l.id_artigo,
    a.descricao,
    l.valor_l,
    l.data_lance
FROM licitacoes l
JOIN pessoas p ON l.cc = p.cc
JOIN artigos a ON l.id_artigo = a.id_artigo
ORDER BY l.cc, l.data_lance DESC;



CREATE VIEW produtos_sem_lance AS
SELECT 
    a.id_artigo,
    a.descricao,
    a.preco_inicial
FROM artigos a
WHERE a.id_artigo NOT IN (
    SELECT DISTINCT id_artigo FROM licitacoes
);

CREATE OR REPLACE VIEW sessoes_com_categorias AS
SELECT 
    s.id_sessao,
    l.data_inicio,
    s.hora_inicio,
    s.hora_fim,
    c.nome_c AS categoria
FROM sessao_categoria sc
JOIN sessoes s ON sc.id_sessao = s.id_sessao
JOIN categorias c ON sc.nome_c = c.nome_c
JOIN leiloes l ON s.id_leilao = l.id_leilao
ORDER BY l.data_inicio, s.hora_inicio;



-- STORED FUNCTOINS

DELIMITER $$

CREATE FUNCTION maior_lance_artigo(p_id_artigo INT)
RETURNS NUMERIC(10,2)
DETERMINISTIC
BEGIN
    DECLARE max_lance NUMERIC(10,2);
    
    SELECT MAX(valor_l) INTO max_lance
    FROM licitacoes
    WHERE id_artigo = p_id_artigo;

    RETURN IFNULL(max_lance, 0);
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION artigo_mais_lances()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE artigo_id INT;
    
    SELECT id_artigo
    FROM licitacoes
    GROUP BY id_artigo
    ORDER BY COUNT(*) DESC
    LIMIT 1
    INTO artigo_id;
    
    RETURN artigo_id;
END $$

DELIMITER ;


-- TRIGGERS

DELIMITER $$

CREATE TRIGGER valida_datas_leilao BEFORE INSERT ON leiloes
FOR EACH ROW
BEGIN
    IF NEW.data_fim IS NOT NULL AND NEW.data_inicio >= NEW.data_fim THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: data_inicio deve ser antes da data_fim.';
    END IF;
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER valida_valor_lance BEFORE INSERT ON licitacoes
FOR EACH ROW
BEGIN
    DECLARE maior_valor DECIMAL(10,2);

    SELECT MAX(valor_l) INTO maior_valor
    FROM licitacoes
    WHERE id_artigo = NEW.id_artigo;

    IF maior_valor IS NOT NULL AND NEW.valor_l <= maior_valor THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro: O novo lance deve ser maior que o maior lance anterior.';
    END IF;
END $$

DELIMITER ;
