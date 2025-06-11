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






