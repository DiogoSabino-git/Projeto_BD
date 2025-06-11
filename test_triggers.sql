DELIMITER //

CREATE TRIGGER trg_CheckArticlePrice
BEFORE INSERT ON Artigos
FOR EACH ROW
BEGIN
    IF NEW.preco_inicial <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O preço inicial do artigo deve ser positivo.';
    END IF;
    -- Se houver regras de preço por categoria, adicionar aqui
END;
//

CREATE TRIGGER trg_UpdateCheckArticlePrice
BEFORE UPDATE ON Artigos
FOR EACH ROW
BEGIN
    IF NEW.preco_inicial <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'O preço inicial do artigo deve ser positivo.';
    END IF;
END;
//

DELIMITER ;

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




