create table emprestimos
(
    id              int auto_increment
    primary key,
    usuario_id      int                                  not null,
    livro_id        int                                  not null,
    data_emprestimo date   default CURRENT_DATE null,
    data_devolucao  datetime                             null,
    devolvido       tinyint(1) default 0                 null,
    constraint emprestimos_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint emprestimos_ibfk_2
        foreign key (livro_id) references livros (id)
            on delete cascade
);

create table livros
(
    id              int auto_increment
    primary key,
    imagem_url      text         not null,
    titulo          varchar(150) not null,
    autor           varchar(100) null,
    data_publicacao date         null,
    genero          varchar(255) null
);

create table usuarios
(
    id            int auto_increment
    primary key,
    nome          varchar(100)                         not null,
    email         varchar(100)                         not null,
    data_cadastro datetime   default CURRENT_TIMESTAMP null,
    senha         varchar(255)                         not null,
    adm           tinyint(1) default 0                 null,
    constraint email
        unique (email)
);


INSERT INTO bookflow.livros (id, imagem_url, titulo, autor, data_publicacao, genero) VALUES (13, 'https://m.media-amazon.com/images/I/81UXkWQTFPL._SL1500_.jpg', 'Darkdawns', 'Jay Kristoff', '2020-04-09', 'Aventura');
INSERT INTO bookflow.livros (id, imagem_url, titulo, autor, data_publicacao, genero) VALUES (18, 'https://m.media-amazon.com/images/I/71lG9Dw6HaL._SL1500_.jpg', 'The Institute', 'Stephen King', '2017-10-17', 'Aventura');
INSERT INTO bookflow.livros (id, imagem_url, titulo, autor, data_publicacao, genero) VALUES (19, 'https://m.media-amazon.com/images/I/91WN6a6F3RL._SL1500_.jpg', 'The Lightning Thief', 'Rick Riordan', '2025-05-02', 'Fantasia');
INSERT INTO bookflow.livros (id, imagem_url, titulo, autor, data_publicacao, genero) VALUES (20, 'https://m.media-amazon.com/images/I/71+4uDgt8JL._SL1500_.jpg', 'The return of the Kings', 'Tolkien', '2017-01-03', 'Aventura');
INSERT INTO bookflow.livros (id, imagem_url, titulo, autor, data_publicacao, genero) VALUES (22, 'https://m.media-amazon.com/images/I/A1q+wZFZbGL._SL1500_.jpg', 'A dança dos dragões', 'George R. R. Martin', '2025-05-02', 'Fantasia');
INSERT INTO bookflow.livros (id, imagem_url, titulo, autor, data_publicacao, genero) VALUES (23, 'https://m.media-amazon.com/images/I/81zN7udGRUL._SL1500_.jpg', 'Duna', 'Frank Herbert', '2012-05-07', 'Aventura');
INSERT INTO bookflow.livros (id, imagem_url, titulo, autor, data_publicacao, genero) VALUES (24, 'https://m.media-amazon.com/images/I/81CGmkRG9GL._SL1500_.jpg', 'Nome do Vento', 'Patrick Rothfuss ', '2015-05-27', 'Romance');
