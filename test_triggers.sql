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

CREATE TRIGGER result_change
AFTER INSERT ON resultados
FOR EACH ROW
BEGIN
    INSERT INTO tbl_logs (event_type, id_participante, id_leilao, new_value)
    VALUES ('INSERT', NEW.id_participante, NEW.id_leilao, NEW.valor_final);
END$$

CREATE TRIGGER result_update_change
AFTER UPDATE ON resultados
FOR EACH ROW
BEGIN
    INSERT INTO tbl_logs (event_type, id_participante, id_leilao, old_value, new_value)
    VALUES ('UPDATE', NEW.id_participante, NEW.id_leilao, OLD.valor_final, NEW.valor_final);
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER result_delete_log
AFTER DELETE ON resultados
FOR EACH ROW
BEGIN
    INSERT INTO tbl_logs (event_type, id_participante, id_leilao, old_value)
    VALUES ('DELETE', OLD.id_participante, OLD.id_leilao, OLD.valor_final);
END$$

DELIMITER ;






