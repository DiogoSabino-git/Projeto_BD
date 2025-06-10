-- SP1 
-- criar registo de novo leilão
DELIMITER $$

CREATE PROCEDURE sp_criar_leilao(
    IN p_data_inicio DATE,
    IN p_local VARCHAR(50)
)
BEGIN
    INSERT INTO leiloes (data_inicio, local)
    VALUES (p_data_inicio, p_local);
END $$
DELIMITER ;

DELIMITER $$

-- SP2 
-- adiciona um participante

DELIMITER $$

CREATE PROCEDURE sp_adicionar_participante(
    IN p_id_leilao INT,
    IN p_cc VARCHAR(12)
)
BEGIN
    DECLARE v_leilao_aberto BOOLEAN;
    
    -- Verifica se a pessoa existe e é comprador
    IF NOT EXISTS (SELECT 1 FROM pessoas WHERE cc = p_cc) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Pessoa não encontrada.';
    ELSEIF NOT EXISTS (SELECT 1 FROM compradores WHERE cc = p_cc) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: A pessoa deve ser um comprador registado.';
    END IF;

    -- Verifica se o leilão existe e está aberto
    SELECT data_fim IS NULL OR data_fim >= CURDATE() INTO v_leilao_aberto
    FROM leiloes 
    WHERE id_leilao = p_id_leilao;
    
    IF v_leilao_aberto IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Leilão não encontrado.';
    ELSEIF NOT v_leilao_aberto THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Leilão já está fechado.';
    END IF;

    -- Verifica se a pessoa já está associada ao leilão
    IF EXISTS (
        SELECT 1 FROM participantes_leilao 
        WHERE id_leilao = p_id_leilao AND cc = p_cc
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Participante já está registado neste leilão.';
    END IF;

    -- Faz a inserção com transação
    START TRANSACTION;
    INSERT INTO participantes_leilao (id_leilao, cc)
    VALUES (p_id_leilao, p_cc);
    COMMIT;
    
    SELECT 'Participante adicionado com sucesso.' AS mensagem;
END $$

DELIMITER ;


-- SP3
-- Regista o resultado do participante
DELIMITER $$

CREATE PROCEDURE sp_registar_resultado (
    IN p_id_leilao INT,
    IN p_id_participante INT
)
BEGIN
DECLARE v_cc VARCHAR(12);
    DECLARE v_artigo_vencido INT;
    DECLARE v_valor_final DECIMAL(10,2);

    -- Verifica se o participante existe
    SELECT cc INTO v_cc
    FROM participantes_leilao
    WHERE id_participante = p_id_participante AND id_leilao = p_id_leilao
    LIMIT 1;

    IF v_cc IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'ID do participante não encontrado para o leilão.';
    END IF;

    -- Obter o artigo vencido (se houver)
    SELECT l2.id_artigo, l2.valor_l INTO v_artigo_vencido, v_valor_final
    FROM licitacoes l2
    JOIN (
        SELECT id_artigo, MAX(valor_l) AS max_valor
        FROM licitacoes
        GROUP BY id_artigo
    ) AS maximos ON l2.id_artigo = maximos.id_artigo AND l2.valor_l = maximos.max_valor
    JOIN artigos a ON l2.id_artigo = a.id_artigo
    JOIN lotes lt ON a.id_lote = lt.id_lote
    JOIN sessoes s ON lt.id_sessao = s.id_sessao
    WHERE l2.cc = v_cc AND s.id_leilao = p_id_leilao
    LIMIT 1;

    -- Inserir o resultado na tabela resultados
    INSERT INTO resultados (
        id_leilao, id_participante, artigo_vencido, valor_final, resultado
    ) VALUES (
        p_id_leilao,
        p_id_participante,
        v_artigo_vencido,
        v_valor_final,
        IF(v_artigo_vencido IS NOT NULL, 'VENCEDOR', 'NÃO_VENCEDOR')
    );
END $$

DELIMITER ;


