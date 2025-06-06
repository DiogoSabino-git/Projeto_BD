CREATE DATABASE Projeto;
USE Projeto;

CREATE TABLE leiloes(
		id_leilao INT AUTO_INCREMENT,
        data_inicio DATE NOT NULL ,
        data_fim DATE DEFAULT NULL,
        local VARCHAR(50),
        PRIMARY KEY(id_leilao));

CREATE TABLE categorias(
		nome_c VARCHAR(20) NOT NULL PRIMARY KEY);
        
CREATE TABLE sessoes(
		id_sessao int NOT NULL,
        hora_inicio TIME NOT NULL,
        hora_fim TIME NOT NULL,
        id_leilao INT,
        nome_c VARCHAR(20),
        PRIMARY KEY(id_sessao),
        FOREIGN KEY(id_leilao) REFERENCES leiloes(id_leilao),
        FOREIGN KEY(nome_c) REFERENCES categorias(nome_c));

CREATE TABLE pessoas(
		cc VARCHAR(12) NOT NULL PRIMARY KEY,
        nome VARCHAR(60) NOT NULL,
        email VARCHAR(30),
        telefone CHAR(9));
        
CREATE TABLE vendedores(
		cc VARCHAR(12) PRIMARY KEY,
        FOREIGN KEY(cc) REFERENCES pessoas(cc));
        
CREATE TABLE compradores(
		cc VARCHAR(12) PRIMARY KEY,
        FOREIGN KEY(cc) REFERENCES pessoas(cc));
        
CREATE TABLE lotes(
		id_lote INT NOT NULL,
        id_sessao int,
        cc VARCHAR(12),
        PRIMARY KEY(id_lote),
        FOREIGN KEY(id_sessao) REFERENCES sessoes(id_sessao),
        FOREIGN KEY(cc) REFERENCES vendedores(cc));
        
CREATE TABLE artigos(
		id_artigo INT NOT NULL,
        preco_inicial NUMERIC(10,2) NOT NULL,
        descricao VARCHAR(250),
        id_lote int,
        PRIMARY KEY(id_artigo),
        FOREIGN KEY(id_lote) REFERENCES lotes(id_lote));

CREATE TABLE licitacoes(
		valor_l NUMERIC(10,2) NOT NULL PRIMARY KEY,
        cc VARCHAR(12),
        FOREIGN KEY(cc) REFERENCES compradores(cc));

CREATE TABLE metodosPagamento(
		n_cartao CHAR(16) NOT NULL PRIMARY KEY,
        data_val DATE NOT NULL,
        cc VARCHAR(12),
        FOREIGN KEY(cc) REFERENCES compradores(cc));
        
CREATE TABLE compra(
		id_artigo int NOT NULL PRIMARY KEY,
        cc VARCHAR(12),
        preco_final NUMERIC(10,2),
        FOREIGN KEY(id_artigo) REFERENCES artigos(id_artigo),
        FOREIGN KEY(cc) REFERENCES compradores(cc));
