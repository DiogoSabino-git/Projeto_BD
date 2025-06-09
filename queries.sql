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












select * from leiloes;



