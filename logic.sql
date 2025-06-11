-- STORED PROCEDURES





DELIMITER $$

CREATE PROCEDURE sp_adicionar_artigo(
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

CREATE PROCEDURE sp_novo_lance(
    IN p_valor NUMERIC(10,2),
    IN p_cc VARCHAR(12),
    IN p_id_artigo INT
)
BEGIN
    DECLARE preco_inicial_artigo NUMERIC(10,2);
    DECLARE maior_lance_atual NUMERIC(10,2);
    DECLARE v_id_leilao INT;
    DECLARE v_id_sessao INT;  -- Add this variable
    
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

    -- Get id_sessao
    SELECT s.id_sessao INTO v_id_sessao
    FROM artigos a
    JOIN lotes l ON a.id_lote = l.id_lote
    JOIN sessoes s ON l.id_sessao = s.id_sessao
    WHERE a.id_artigo = p_id_artigo;
    
    -- Insert including id_sessao now
    INSERT INTO licitacoes (valor_l, cc, id_artigo, id_sessao)
    VALUES (p_valor, p_cc, p_id_artigo, v_id_sessao);
    
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

CREATE PROCEDURE sp_fechar_compra(
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

CREATE PROCEDURE sp_listar_lances_artigos(
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



-- REMOÇÃO DE DADOS

DELIMITER $$

CREATE PROCEDURE sp_remover_licitacao(
    IN p_valor_l NUMERIC(10,2),
    IN p_cc VARCHAR(12),
    IN p_id_artigo INT
)
BEGIN
    DELETE FROM licitacoes
    WHERE valor_l = p_valor_l
      AND cc = p_cc
      AND id_artigo = p_id_artigo;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_compra(
    IN p_id_artigo INT
)
BEGIN
    DELETE FROM compra
    WHERE id_artigo = p_id_artigo;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_metodo_pagamento(
    IN p_n_cartao CHAR(16)
)
BEGIN
    DELETE FROM metodosPagamento
    WHERE n_cartao = p_n_cartao;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_resultado(
    IN p_id_leilao INT,
    IN p_id_participante INT
)
BEGIN
    DELETE FROM resultados
    WHERE id_leilao = p_id_leilao
      AND id_participante = p_id_participante;
END $$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_remover_artigo(
    IN p_id_artigo INT
)
BEGIN
    START TRANSACTION;

    DELETE FROM licitacoes WHERE id_artigo = p_id_artigo;

    DELETE FROM compra WHERE id_artigo = p_id_artigo;

    UPDATE resultados
    SET artigo_vencido = NULL
    WHERE artigo_vencido = p_id_artigo;

    DELETE FROM artigos
    WHERE id_artigo = p_id_artigo;

    -- Commit the transaction
    COMMIT;

END $$

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_remover_lote(
    IN p_id_lote INT
)
BEGIN
    -- Utilizar o SP de remoção de artigo para garantir a limpeza em 'licitacoes' e 'compra'
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur_id_artigo INT;
    DECLARE cur_artigos CURSOR FOR SELECT id_artigo FROM artigos WHERE id_lote = p_id_lote;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_artigos;
    read_loop: LOOP
        FETCH cur_artigos INTO cur_id_artigo;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL sp_remover_artigo(cur_id_artigo);
    END LOOP;
    CLOSE cur_artigos;

    -- Finalmente, remover o lote
    DELETE FROM lotes
    WHERE id_lote = p_id_lote;
END //

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_sessao_categoria(
    IN p_id_sessao INT,
    IN p_nome_c VARCHAR(100)
)
BEGIN
    DELETE FROM sessao_categoria
    WHERE id_sessao = p_id_sessao
      AND nome_c = p_nome_c;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_sessao(
    IN p_id_sessao INT
)
BEGIN
    -- Remover lotes associados a esta sessão
    -- Usar o SP de remoção de lote para garantir a limpeza em 'artigos', 'licitacoes', 'compra'
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur_id_lote INT;
    DECLARE cur_lotes CURSOR FOR SELECT id_lote FROM lotes WHERE id_sessao = p_id_sessao;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_lotes;
    read_loop: LOOP
        FETCH cur_lotes INTO cur_id_lote;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL sp_remover_lote(cur_id_lote);
    END LOOP;
    CLOSE cur_lotes;

    -- Remover associações de sessão-categoria
    DELETE FROM sessao_categoria WHERE id_sessao = p_id_sessao;

    -- Finalmente, remover a sessão
    DELETE FROM sessoes
    WHERE id_sessao = p_id_sessao;
END $$

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_remover_participante_leilao(
    IN p_id_participante INT
)
BEGIN
    -- Remover resultados associados a este participante
    DELETE FROM resultados WHERE id_participante = p_id_participante;

    -- Finalmente, remover o participante do leilão
    DELETE FROM participantes_leilao
    WHERE id_participante = p_id_participante;
END //

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_comprador(
    IN p_cc VARCHAR(12)
)
BEGIN
    -- Remover métodos de pagamento associados
    DELETE FROM metodosPagamento WHERE cc = p_cc;

    -- Remover licitações feitas por este comprador
    DELETE FROM licitacoes WHERE cc = p_cc;

    -- Remover as compras associadas a este comprador
    DELETE FROM compra WHERE cc = p_cc;

    -- Remover o registo de comprador
    DELETE FROM compradores
    WHERE cc = p_cc;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_vendedor(
    IN p_cc VARCHAR(12)
)
BEGIN
    -- Remover lotes associados a este vendedor
    -- Utilizar o SP de remoção de lote para garantir a limpeza em 'artigos', 'licitacoes', 'compra'
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur_id_lote INT;
    DECLARE cur_lotes CURSOR FOR SELECT id_lote FROM lotes WHERE cc = p_cc;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_lotes;
    read_loop: LOOP
        FETCH cur_lotes INTO cur_id_lote;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL sp_remover_lote(cur_id_lote);
    END LOOP;
    CLOSE cur_lotes;

    -- Remover o registo de vendedor
    DELETE FROM vendedores
    WHERE cc = p_cc;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_remover_categoria(
    IN p_nome_c VARCHAR(100)
)
BEGIN
    -- Remover associações de sessão-categoria
    DELETE FROM sessao_categoria WHERE nome_c = p_nome_c;

    -- Finalmente, remover a categoria
    DELETE FROM categorias
    WHERE nome_c = p_nome_c;
END $$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_remover_pessoa(
    IN p_cc VARCHAR(12)
)
BEGIN
    -- Declaração de variáveis para o cursor (devem estar no topo do bloco BEGIN...END)
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur_id_participante INT;
    -- Declaração do cursor (deve estar no topo)
    DECLARE cur_participantes CURSOR FOR SELECT id_participante FROM participantes_leilao WHERE cc = p_cc;
    -- Declaração do handler para o cursor (deve estar no topo)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Inicia uma transação para garantir que a operação é atómica
    START TRANSACTION;

    -- Remove de participantes_leilao primeiro, pois liga diretamente a 'pessoas'.
    -- Abre o cursor e itera apenas se existirem participantes.
    IF EXISTS (SELECT 1 FROM participantes_leilao WHERE cc = p_cc) THEN
        OPEN cur_participantes;
        read_loop: LOOP
            FETCH cur_participantes INTO cur_id_participante;
            IF done THEN
                LEAVE read_loop;
            END IF;
            -- Chama o SP específico para lidar com dados relacionados ao participante (resultados)
            CALL sp_remover_participante_leilao(cur_id_participante);
        END LOOP;
        CLOSE cur_participantes;
    END IF;

    -- Remove se a pessoa for um comprador (chama o SP específico)
    IF EXISTS (SELECT 1 FROM compradores WHERE cc = p_cc) THEN
        CALL sp_remover_comprador(p_cc);
    END IF;

    -- Remove se a pessoa for um vendedor (chama o SP específico)
    IF EXISTS (SELECT 1 FROM vendedores WHERE cc = p_cc) THEN
        CALL sp_remover_vendedor(p_cc);
    END IF;

    -- Finalmente, remove a pessoa da tabela base 'pessoas'
    DELETE FROM pessoas
    WHERE cc = p_cc;

    -- Confirma a transação
    COMMIT;

END $$ 

DELIMITER ;