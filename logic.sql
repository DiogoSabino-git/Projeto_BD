DELIMITER $$

CREATE PROCEDURE criar_leilao(
    IN p_data_inicio DATE,
    IN p_local VARCHAR(50)
)
BEGIN
    INSERT INTO leiloes (data_inicio, local)
    VALUES (p_data_inicio, p_local);
END $$
DELIMITER ;

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
END $$


DELIMITER ;