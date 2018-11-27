CREATE TABLE Usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(128) NOT NULL,
    senha VARCHAR(128) NOT NULL,
    email VARCHAR(256) UNIQUE NOT NULL,
    tipo VARCHAR(64) NOT NULL
);

CREATE TABLE Projeto (
    id SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome VARCHAR(256) NOT NULL,
    descricao VARCHAR(1024) NOT NULL,
    conteudo TEXT NOT NULL,
    situacao VARCHAR(256) NOT NULL,
    imagem VARCHAR(256) NOT NULL DEFAULT 'imagens/imagemDefault.jpg',
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id) ON DELETE CASCADE
);


INSERT INTO usuario (nome, senha, email, tipo) VALUES ('Alencar', 'cocalitro', 'alencar@facada.com', 'Administrador');