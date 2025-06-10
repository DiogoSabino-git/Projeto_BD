-- SP1 
-- criar registo de novo leilão
DELIMITER $$

CREATE PROCEDURE sp_criar_leilao(
    IN p_data_inicio DATE,
    IN p_local VARCHAR(50),
    IN p_descricao VARCHAR(200)
)
BEGIN
    INSERT INTO leiloes (data_inicio, local, descricao)
    VALUES (p_data_inicio, p_local, p_descricao);
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


-- SP4
-- Remove o leilão
DELIMITER $$

CREATE PROCEDURE sp_remover_leilao(
    IN p_id_leilao INT,
    IN p_force BOOLEAN
)
BEGIN
    DECLARE v_resultados INT;

    -- Verifica se existem resultados associados ao leilão
    SELECT COUNT(*) INTO v_resultados
    FROM resultados
    WHERE id_leilao = p_id_leilao;

    -- Se existirem resultados e não for force, lançar erro
    IF v_resultados > 0 AND p_force = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível remover: existem resultados associados ao leilão.';
    END IF;

    -- Se existirem resultados e force for true, apagar resultados
    IF v_resultados > 0 AND p_force = TRUE THEN
        DELETE FROM resultados WHERE id_leilao = p_id_leilao;
    END IF;

    -- Apagar registos associados nas tabelas dependentes (em ordem de dependência)
    DELETE FROM participantes_leilao WHERE id_leilao = p_id_leilao;

    DELETE FROM sessao_categoria 
    WHERE id_sessao IN (
        SELECT id_sessao FROM sessoes WHERE id_leilao = p_id_leilao
    );

    DELETE FROM licitacoes 
    WHERE id_artigo IN (
        SELECT id_artigo FROM artigos 
        WHERE id_lote IN (
            SELECT id_lote FROM lotes 
            WHERE id_sessao IN (
                SELECT id_sessao FROM sessoes WHERE id_leilao = p_id_leilao
            )
        )
    );

    DELETE FROM compra 
    WHERE id_artigo IN (
        SELECT id_artigo FROM artigos 
        WHERE id_lote IN (
            SELECT id_lote FROM lotes 
            WHERE id_sessao IN (
                SELECT id_sessao FROM sessoes WHERE id_leilao = p_id_leilao
            )
        )
    );

    DELETE FROM artigos 
    WHERE id_lote IN (
        SELECT id_lote FROM lotes 
        WHERE id_sessao IN (
            SELECT id_sessao FROM sessoes WHERE id_leilao = p_id_leilao
        )
    );

    DELETE FROM lotes 
    WHERE id_sessao IN (
        SELECT id_sessao FROM sessoes WHERE id_leilao = p_id_leilao
    );

    DELETE FROM sessoes 
    WHERE id_leilao = p_id_leilao;

    -- Finalmente, apagar o leilão
    DELETE FROM leiloes WHERE id_leilao = p_id_leilao;
END $$

DELIMITER ;

-- SP5
-- Clona o leilão
DELIMITER $$

CREATE PROCEDURE sp_clonar_leilao (
    IN p_id_leilao INT
)
BEGIN
    DECLARE v_data_inicio DATE;
    DECLARE v_data_fim DATE;
    DECLARE v_local VARCHAR(50);

    -- Obter os dados do leilão original (exceto a descrição)
    SELECT data_inicio, data_fim, local
    INTO v_data_inicio, v_data_fim, v_local
    FROM leiloes
    WHERE id_leilao = p_id_leilao;

    -- Inserir novo leilão com descrição fixa
    INSERT INTO leiloes (data_inicio, data_fim, descricao, local)
    VALUES (
        v_data_inicio,
        v_data_fim,
        'Leilao de Eletrónicos --- COPIA (a preencher)',
        v_local
    );
END $$

DELIMITER ;