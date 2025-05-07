CREATE DATABASE IF NOT EXISTS bookflow;
USE bookflow;

-- auto-generated definition
create table emprestimos
(
  id              int auto_increment
    primary key,
  usuario_id      int                                  not null,
  livro_id        int                                  not null,
  data_emprestimo datetime   default CURRENT_TIMESTAMP null,
  data_devolucao  datetime                             null,
  devolvido       tinyint(1) default 0                 null,
  constraint emprestimos_ibfk_1
    foreign key (usuario_id) references usuarios (id),
  constraint emprestimos_ibfk_2
    foreign key (livro_id) references livros (id)
      on delete cascade
);

create index livro_id
  on emprestimos (livro_id);

create index usuario_id
  on emprestimos (usuario_id);

-- auto-generated definition
create table livros
(
  id                    int auto_increment
    primary key,
  imagem_url            text          not null,
  titulo                varchar(150)  not null,
  autor                 varchar(100)  null,
  data_publicacao       date          null,
  editora               varchar(100)  null,
  quantidade_total      int default 1 not null,
  quantidade_disponivel int default 1 not null
);

-- auto-generated definition
create table usuarios
(
  id            int auto_increment
    primary key,
  nome          varchar(100)                       not null,
  email         varchar(100)                       not null,
  telefone      varchar(20)                        null,
  data_cadastro datetime default CURRENT_TIMESTAMP null,
  senha         varchar(255)                       not null,
  constraint email
    unique (email)
);

