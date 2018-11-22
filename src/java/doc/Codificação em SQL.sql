CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(64) NOT NULL,
    senha VARCHAR(32) NOT NULL,
    email VARCHAR(128) UNIQUE NOT NULL,
    tipo VARCHAR(32) NOT NULL
);

CREATE TABLE Projeto (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(32) NOT NULL,
    descricao VARCHAR(128) NOT NULL,
    conteudo TEXT NOT NULL,
    situacao VARCHAR(64) NOT NULL,
    imagem OID,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id)
);