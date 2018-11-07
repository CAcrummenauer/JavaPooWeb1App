CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(128) NOT NULL,
    senha VARCHAR(32) NOT NULL,
    email VARCHAR(128) UNIQUE NOT NULL,
    tipo VARCHAR(64) NOT NULL
);

CREATE TABLE Projeto (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(128) NOT NULL,
    descricao VARCHAR(512) NOT NULL,
    data_criacao DATE NOT NULL,
    conteudo TEXT NOT NULL,
    situacao VARCHAR(64) NOT NULL,
    imagem OID,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);