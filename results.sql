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

