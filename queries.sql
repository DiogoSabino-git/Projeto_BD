select * from artigos;

-- Q1.1
-- Lista de participantes compradores
SELECT nome
FROM pessoas INNER JOIN compradores
ON pessoas.cc = compradores.cc;

-- Q1.2
-- Lista de participantes vendedores

SELECT nome
FROM pessoas INNER JOIN vendedores
on pessoas.cc = vendedores.cc;

-- Q2.1
-- Lista de leilões
SELECT local 
FROM leiloes;

-- Q2.2
-- Lista de sessões de um determinado leilão
SELECT hora_inicio, hora_fim
FROM sessoes INNER JOIN leiloes
ON sessoes.id_leilao = leiloes.id_leilao
WHERE sessoes.id_leilao = 2;

-- Q3.1
-- Lista de licitações de uma pessoa
select
artigos.descricao as "Artigo",
artigos.preco_inicial as "Preço base",
licitacoes.valor_l as "Preço licitado",
licitacoes.data_lance as "Data de lance"
from licitacoes 
join compradores using(cc)
join pessoas using(cc)
join artigos using(id_artigo)
where pessoas.nome = "Carla Pereira";

-- Q3.2
-- Lista de licitações de uma sessão de um leilão
select
pessoas.nome as "Nome",
artigos.descricao as "Artigo",
artigos.preco_inicial as "Preço base",
licitacoes.valor_l as "Preço licitado",
licitacoes.data_lance as "Data de lance"
from licitacoes
inner join compradores using(cc)
inner join pessoas using(cc)
inner join artigos using(id_artigo)
inner join lotes on lotes.id_lote = artigos.id_lote
where lotes.id_sessao = 1;

-- Q3.3
-- Lista de licitações de um leilão
select
pessoas.nome as "Nome",
artigos.descricao as "Artigo",
artigos.preco_inicial as "Preço base",
licitacoes.valor_l as "Preço licitado",
licitacoes.data_lance as "Data de lance"
from licitacoes
inner join compradores using(cc)
inner join pessoas using(cc)
inner join artigos using(id_artigo)
inner join lotes on lotes.id_lote = artigos.id_lote
where lotes.id_sessao = (select id_sessao
							from sessoes
                            where id_leilao = 2);

-- Q4.1
-- Lista de bens e detalhes de um lote
select 
artigos.descricao as "Artigo",
artigos.preco_inicial as "Preço base"
from lotes
right outer join artigos using(id_lote)
where id_lote = 1;

-- Q4.2
-- Lista de bens e detalhes de um leilao
select
artigos.descricao as "Artigo",
artigos.preco_inicial as "Preço base"
from lotes
right outer join artigos using(id_lote)
where lotes.id_sessao = (select id_sessao
							from sessoes
                            where id_leilao = 1);

-- Q4.b
-- Lista de bens que não foram vendios em nenhum leilao/sessao
select
artigos.descricao as "Artigo",
artigos.preco_inicial as "Preço base"
from compra
right outer join artigos using(id_artigo)
where compra.preco_final is null
;


-- Lista com número médio, mínimo e máximo e desvio de padrão dos bens vendidos por leilão

-- Q5.1 Por local do leilão
SELECT 
    l.local AS local_leilao,
    COUNT(DISTINCT l.id_leilao) AS total_leiloes,
    AVG(artigos_vendidos.total_artigos) AS media_artigos,
    MIN(artigos_vendidos.total_artigos) AS minimo_artigos,
    MAX(artigos_vendidos.total_artigos) AS maximo_artigos,
    STDDEV(artigos_vendidos.total_artigos) AS desvio_padrao
FROM 
    Leiloes l
JOIN (
    SELECT 
        s.id_leilao,
        COUNT(c.id_artigo) AS total_artigos
    FROM 
        Sessoes s
    JOIN Lotes lo ON s.id_sessao = lo.id_sessao
    JOIN Artigos a ON lo.id_lote = a.id_lote
    JOIN Compra c ON a.id_artigo = c.id_artigo
    GROUP BY s.id_leilao
) AS artigos_vendidos ON l.id_leilao = artigos_vendidos.id_leilao
GROUP BY l.local;

-- Q5.2 Por categoria de sessao
SELECT
    S.id_sessao,
    COUNT(DISTINCT A.id_artigo) AS total_bens_vendidos_sessao,
    AVG(COUNT(DISTINCT A.id_artigo)) OVER() AS media_total_bens_vendidos_geral,
    MIN(COUNT(DISTINCT A.id_artigo)) OVER() AS minimo_total_bens_vendidos_geral,
    MAX(COUNT(DISTINCT A.id_artigo)) OVER() AS maximo_total_bens_vendidos_geral,
    STDDEV(COUNT(DISTINCT A.id_artigo)) OVER() AS desvio_padrao_total_bens_vendidos_geral
FROM
    Artigos AS A
JOIN
    Lotes AS L ON A.id_lote = L.id_lote
JOIN
    Sessoes AS S ON L.id_sessao = S.id_sessao
JOIN
    Compra AS C ON A.id_artigo = C.id_artigo
GROUP BY
    S.id_sessao;


-- Q6 Lista de resultados de cada leilão/evento com ranking dos 3 mais valorizados
SELECT
    L.id_leilao,
    L.data_inicio AS data_leilao, -- Usando o nome correto da coluna
    L.local AS local_leilao,
    A.descricao AS descricao_artigo,
    C.preco_final AS preco_final_venda,
    Ranking.rank_por_leilao
FROM
    Leiloes AS L
JOIN
    Sessoes AS S ON L.id_leilao = S.id_leilao
JOIN
    Lotes AS LT ON S.id_sessao = LT.id_sessao
JOIN
    Artigos AS A ON LT.id_lote = A.id_lote
JOIN
    Compra AS C ON A.id_artigo = C.id_artigo -- Garante que o artigo foi vendido e tem um preco_final
JOIN (
    SELECT
        A_sub.id_artigo,
        S_sub.id_leilao,
        C_sub.preco_final,
        RANK() OVER (PARTITION BY S_sub.id_leilao ORDER BY C_sub.preco_final DESC) AS rank_por_leilao
    FROM
        Artigos AS A_sub
    JOIN
        Lotes AS LT_sub ON A_sub.id_lote = LT_sub.id_lote
    JOIN
        Sessoes AS S_sub ON LT_sub.id_sessao = S_sub.id_leilao
    JOIN
        Compra AS C_sub ON A_sub.id_artigo = C_sub.id_artigo
) AS Ranking ON A.id_artigo = Ranking.id_artigo AND L.id_leilao = Ranking.id_leilao
WHERE
    Ranking.rank_por_leilao <= 3
ORDER BY
    L.id_leilao,
    Ranking.rank_por_leilao;

-- Q7 Lista de participantes individuais que não participaram em qualquer leilão
SELECT
    P.cc,
    P.nome,
    P.email,
    P.telefone
FROM
    Pessoas AS P
WHERE NOT EXISTS (
    -- Subconsulta para verificar se a pessoa participou como VENDEDOR
    SELECT 1
    FROM Vendedores AS V
    JOIN Lotes AS L ON V.cc = L.cc
    JOIN Artigos AS A ON L.id_lote = A.id_lote
    WHERE V.cc = P.cc
)
AND NOT EXISTS (
    -- Subconsulta para verificar se a pessoa participou como COMPRADOR
    SELECT 1
    FROM Compradores AS C
    JOIN Compra AS CP ON C.cc = CP.cc
    WHERE C.cc = P.cc
);

-- Q8 Lista dos participantes de cada leilão com identificação das licitações no leilão/evento e respetivas características de cada licitação
SELECT
    L.id_leilao,
    L.data_inicio AS data_leilao,
    L.local AS local_leilao,
    P.cc AS cc_participante,
    P.nome AS nome_participante,
    Lic.valor_l AS id_licitacao_ou_valor_principal, 
    Lic.valor_l AS valor_licitacao, 
    A.descricao AS descricao_artigo
FROM
    Leiloes AS L
JOIN
    Sessoes AS S ON L.id_leilao = S.id_leilao
JOIN
    Lotes AS LT ON S.id_sessao = LT.id_sessao
JOIN
    Artigos AS A ON LT.id_lote = A.id_lote
LEFT JOIN
   
    Licitacoes AS Lic ON A.id_artigo = Lic.id_artigo 
LEFT JOIN
    Compradores AS Comp ON Lic.cc = Comp.cc
LEFT JOIN
    Pessoas AS P ON Comp.cc = P.cc
ORDER BY
    L.id_leilao,
    Lic.valor_l;
    
-- Q9
WITH LeilaoParticipants AS (
    SELECT DISTINCT
        L.id_leilao,
        P.cc AS cc_participante,
        YEAR(L.data_inicio) AS ano_leilao
    FROM
        Leiloes AS L
    JOIN Sessoes AS S ON L.id_leilao = S.id_leilao
    JOIN Lotes AS LT ON S.id_sessao = LT.id_sessao
    JOIN Artigos AS A ON LT.id_lote = A.id_lote
    JOIN Compra AS CO ON A.id_artigo = CO.id_artigo
    JOIN Compradores AS C ON CO.cc = C.cc
    JOIN Pessoas AS P ON C.cc = P.cc
    WHERE YEAR(L.data_inicio) BETWEEN YEAR(CURRENT_DATE()) - 2 AND YEAR(CURRENT_DATE())

    UNION

    SELECT DISTINCT
        L.id_leilao,
        P.cc AS cc_participante,
        YEAR(L.data_inicio) AS ano_leilao
    FROM
        Leiloes AS L
    JOIN Sessoes AS S ON L.id_leilao = S.id_leilao
    JOIN Licitacoes AS LI ON S.id_sessao = LI.id_sessao 
    JOIN Compradores AS C ON LI.cc = C.cc
    JOIN Pessoas AS P ON C.cc = P.cc
    WHERE YEAR(L.data_inicio) BETWEEN YEAR(CURRENT_DATE()) - 2 AND YEAR(CURRENT_DATE()) 

    UNION

    SELECT DISTINCT
        L.id_leilao,
        P.cc AS cc_participante,
        YEAR(L.data_inicio) AS ano_leilao
    FROM
        Leiloes AS L
    JOIN Sessoes AS S ON L.id_leilao = S.id_leilao
    JOIN Lotes AS LT ON S.id_sessao = LT.id_sessao
    JOIN Vendedores AS V ON LT.cc = V.cc
    JOIN Pessoas AS P ON V.cc = P.cc
    WHERE YEAR(L.data_inicio) BETWEEN YEAR(CURRENT_DATE()) - 2 AND YEAR(CURRENT_DATE()) 
),
LeilaoParticipantCounts AS (
    SELECT
        LP.ano_leilao,
        LP.id_leilao,
        COUNT(DISTINCT LP.cc_participante) AS numero_de_participantes
    FROM
        LeilaoParticipants AS LP
    GROUP BY
        LP.ano_leilao,
        LP.id_leilao
),
RankedLeiloes AS (
    SELECT
        LPC.ano_leilao,
        LPC.id_leilao,
        Lei.data_inicio,
        Lei.local,
        LPC.numero_de_participantes,
        ROW_NUMBER() OVER(PARTITION BY LPC.ano_leilao ORDER BY LPC.numero_de_participantes DESC) AS rank_por_ano
    FROM
        LeilaoParticipantCounts AS LPC
    JOIN
        Leiloes AS Lei ON LPC.id_leilao = Lei.id_leilao
)
SELECT
    ano_leilao,
    id_leilao,
    data_inicio,
    local,
    numero_de_participantes,
    rank_por_ano
FROM
    RankedLeiloes
WHERE
    rank_por_ano <= 5
ORDER BY
    ano_leilao DESC,
    numero_de_participantes DESC;
    
select * from leiloes;



