-- Stored procedures --

-- Compradores Registados
SELECT nome, pessoas.cc
FROM pessoas join compradores
ON pessoas.cc = compradores.cc;

CALL sp_remover_pessoa (123456789012);

CALL sp_adicionar_pessoa ('123456789012', 'Ana Silva', 'ana.silva@example.com', '912345678');

INSERT INTO compradores (cc) VALUES
('123456789012');

-- Artigos
select descricao as "Artigo", id_artigo as "ID"
from artigos;

CALL sp_remover_artigo (1);

CALL sp_adicionar_artigo(1, 150.00, 'Smartphone Samsung Galaxy S21, novo');

-- Participantes --

select pessoas.nome as "Nome", pessoas.cc as "CC", id_participante as "ID_Participante"
from pessoas right outer join participantes_leilao using(cc);

CALL sp_adicionar_participante (11, '123456789012');

CALL sp_remover_participante_leilao (26);

-- Licitações -- 

-- Verificar os lances atuais para o Artigo ID 1
SELECT valor_l, cc, data_lance FROM licitacoes WHERE id_artigo = 2 ORDER BY valor_l DESC;

-- Fazer um novo lance
CALL sp_novo_lance(190.00, '123456789014', 2);

-- Verificar o novo lance
SELECT valor_l, cc, data_lance FROM licitacoes WHERE id_artigo = 2 ORDER BY valor_l DESC;

-- Compras --

-- Verificar se o artigo 21 já está em 'compra'
SELECT * FROM compra WHERE id_artigo = 21;

-- Fechar a compra para o Artigo ID 21
CALL sp_fechar_compra(21);

-- Verificar o registo da compra
SELECT * FROM compra WHERE id_artigo = 21;

-- Registar um resultado --

-- Verificar resultados existentes para o participante 25 no leilão 17
SELECT * FROM resultados WHERE id_leilao = 3 AND id_participante = 10;

-- Registar o resultado para o participante ID 26 no leilão ID 1
CALL sp_remover_resultado (3, 10);
CALL sp_registar_resultado(3, 10);

-- Verificar o resultado registado
SELECT * FROM resultados WHERE id_leilao = 3 AND id_participante = 10;

-- Remover lote (todos os artigos e licitações associadas também) --

-- Verificar o lote 20 e os artigos associados
SELECT * FROM lotes WHERE id_lote = 20;
SELECT * FROM artigos WHERE id_lote = 20;

-- Remover o lote
CALL sp_remover_lote(20);

-- Verificar se foi removido (e as dependências)
SELECT * FROM lotes WHERE id_lote = 20;
SELECT * FROM artigos WHERE id_lote = 20;

-- Remover a associação de uma categoria a uma sessão específica --

-- Verificar a associação
SELECT * FROM sessao_categoria WHERE id_sessao = 20 AND nome_c = 'Smartphones';

-- Remover a associação
CALL sp_remover_sessao_categoria(20, 'Smartphones');

-- Verificar se foi removida
SELECT * FROM sessao_categoria WHERE id_sessao = 20 AND nome_c = 'Smartphones';

-- Remover uma sessão e todas as suas dependências (lotes, artigos, licitações, compras, associações de categoria) --

-- Verificar a sessão 20 e suas dependências (p.ex., lotes)
SELECT * FROM sessoes WHERE id_sessao = 20;
SELECT * FROM lotes WHERE id_sessao = 20;

-- Remover a sessão
CALL sp_remover_sessao(20);

-- Verificar se foi removida (e as dependências)
SELECT * FROM sessoes WHERE id_sessao = 20;

-- Remover um vendedor e todos os lotes, artigos, licitações e compras associados a ele --

-- Verificar o vendedor e seus lotes
SELECT * FROM vendedores WHERE cc = '123456789051';
SELECT * FROM lotes WHERE cc = '123456789051';

-- Remover o vendedor
CALL sp_remover_vendedor('123456789051');

-- Verificar se foi removido
SELECT * FROM vendedores WHERE cc = '123456789051';
SELECT * FROM lotes WHERE cc = '123456789051';

-- Remover uma categoria --

-- Verificar a categoria e suas associações
SELECT * FROM categorias WHERE nome_c = 'Smartwatches / Wearables';
SELECT * FROM sessao_categoria WHERE nome_c = 'Smartwatches / Wearables';

-- Remover a categoria
CALL sp_remover_categoria('Smartwatches / Wearables');

-- Verificar se foi removida
SELECT * FROM categorias WHERE nome_c = 'Smartwatches / Wearables';
SELECT * FROM sessao_categoria WHERE nome_c = 'Smartwatches / Wearables';

-- Remover leilao sem resultados --

-- Verificar o leilão 21 e suas dependências
SELECT * FROM leiloes WHERE id_leilao = 21;
SELECT * FROM sessoes WHERE id_leilao = 21;

-- Remover o leilão 21 (não deveria ter resultados, então FALSE é seguro)
CALL sp_remover_leilao(21, FALSE);

-- Depois da remoção
SELECT * FROM leiloes WHERE id_leilao = 21;

-- Remover leilão com resultados --

-- Verificar o leilão 1 e seus resultados

SELECT * FROM leiloes WHERE id_leilao = 1;
SELECT * FROM resultados WHERE id_leilao = 1;

-- Remover o leilão 1, forçando a remoção de resultados
CALL sp_remover_leilao(1, TRUE);

-- Depois da remoção
SELECT * FROM leiloes WHERE id_leilao = 1;
SELECT * FROM resultados WHERE id_leilao = 1;

-- Views --

-- Lista artigos que ainda não foram comprados
SELECT * FROM artigos_disponiveis;

-- Mostra os artigos que foram comprados, com a descrição do artigo, o CC e nome do comprador, e o preço final
SELECT * FROM leiloes_finalizados_vencedores;

-- Exibe o histórico completo de lances feitos por todos os utilizadores, ordenados por utilizador e data
SELECT * FROM historico_lances_utilizadores;

-- Lista os artigos que foram adicionados, mas que ainda não receberam nenhuma licitação
SELECT * FROM produtos_sem_lance;

-- Detalha as sessões dos leilões e as categorias de artigos associadas a cada uma
SELECT * FROM sessoes_com_categorias;





