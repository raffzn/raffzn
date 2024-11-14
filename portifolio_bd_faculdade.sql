create database bd_faculdade;

use bd_faculdade;

#1) Criar tabela para turma
create table tbl_turma (
	id int not null primary key auto_increment,
    nome_turma varchar(15) not null,
    numero_sala int not null,
    periodo varchar(15),
    unique index (id)
);

#2) Criar tabela para nota
create table tbl_nota (
	id int not null primary key auto_increment,
    status_nota varchar(45),
    valor_nota int not null,
    data_atribuicao date,
    unique index (id)
);

#3) Criar tabela para professor
create table tbl_professor (
	id int not null primary key auto_increment,
    nome_completo varchar(90) not null,
    cpf varchar(11) not null,
    data_contratacao date,
    email varchar(255) not null,
    telefone varchar (11) not null,
    unique index(id)
);

#4) Criar tabela para aluno
create table tbl_aluno (
	id int not null primary key auto_increment,
    nome_completo varchar(90) not null,
    email varchar(255) not null,
    data_nascimento date not null,
    data_matricula date not null,
    cpf varchar(11) not null,
    status_aluno varchar(25),
    telefone varchar(11) not null,
	unique index (id)
);

#5) Criar tabela para curso
create table tbl_curso (
	id int not null primary key auto_increment,
    nome_curso varchar(45) not null,
    tipo_curso varchar(35) not null,
    data_inicio date not null,
    data_conclusao date not null,
    duracao varchar(45),
    coordenador varchar(90) not null,
    unique index (id)
);

#6) Criar tabela para matéria (incluindo chaves estrangeiras)
create table tbl_materia (
    id int not null primary key auto_increment,
    nome_materia varchar(45) not null,
    descricao text,
    carga_horaria varchar(45),
    id_professor int not null,
    id_curso int not null,
    constraint fk_professor_materia foreign key (id_professor) references tbl_professor(id),
	constraint fk_curso_materia foreign key (id_curso) references tbl_curso(id),
	unique index (id)
);

#7) Criar tabela para relacionamento aluno - curso
create table tbl_aluno_curso (
	id int not null primary key auto_increment,
    id_aluno int not null,
    id_curso int not null,
    constraint fk_aluno_materia foreign key (id_aluno) references tbl_aluno(id),
    constraint fk_curso_aluno_materia foreign key (id_curso) references tbl_curso(id),
    unique index (id)
);

#8) Criar tabela para endereço do aluno
create table tbl_endereco_aluno (
	id int not null primary key auto_increment,
    logradouro varchar(45) not null,
    bairro varchar(45) not null,
    cep varchar(45) not null,
    cidade varchar(45) not null,
    estado varchar(45) not null,
    pais varchar(45) not null,
    id_aluno int not null,
	constraint fk_endereco_aluno foreign key (id_aluno) references tbl_aluno(id),
    unique index (id)
);

#9) Criar tabela para endereço do professor
create table tbl_endereco_professor (
	id int not null primary key auto_increment,
    logradouro varchar(45) not null,
    bairro varchar(45) not null,
    cep varchar(45) not null,
    cidade varchar(45) not null,
    estado varchar(45) not null,
    pais varchar(45) not null,
    id_professor int not null,
	constraint fk_endereco_professor foreign key (id_professor) references tbl_professor(id),
    unique index (id)
);

#10) Inserindo chave estrangeira da turma na entidade aluno
alter table tbl_aluno
add column id_turma int,
add constraint fk_aluno_turma foreign key (id_turma) references tbl_turma(id);

#11) Inserindo chave estrangeira de aluno e materia na entidade nota
alter table tbl_nota
add column id_aluno int,
add column id_materia int,
add constraint fk_aluno_nota foreign key (id_aluno) references tbl_aluno(id),
add constraint fk_materia_nota foreign key (id_materia) references tbl_materia(id);


##################################################################################################################################
#PARTE 2 - Inserindo dados

#2.1) Inserindo dados de turma
insert into tbl_turma (nome_turma, numero_sala, periodo)
values ('turma 01', 23, 'noturno'),
('turma 02', 38, 'manha'),
('turma 03', 21, 'noturno'),
('turma 04', 11, 'manha');

select * from tbl_turma;
#Teste feito com sucesso

#____________________________________________________________________________________________________________________#

#2.2) Inserindo dados do professor
insert into tbl_professor (nome_completo, cpf, email, telefone)
values ('Roberto Jose de Andrade', '33211176590', 'joserandrade@hotmail.com', '11987654321'),
('Ana Alves Cardozo', '43218907411', 'anacardti@gmail.com', '12990128890'),
('William Shakespeare de Oliveira', '56798011166', 'willshakes88@outlook.com', '11987763321'),
('Graciliano Gomes', '45678900011', 'gracilianopegazus@gmail.com', '11966775542'),
('Alberto Silva Nougatt', '78598012332', 'nougatt.as@gmail.com', '11987645231');

select * from tbl_professor;
#Teste feito com sucesso

#____________________________________________________________________________________________________________________#

#2.3) Inserindo os dados de alunos
insert into tbl_aluno (nome_completo, email, data_nascimento, data_matricula, cpf, telefone, id_turma)
values ('João Silva', 'joao.silva@email.com', '2000-05-15', '2024-01-10', '12345678900', '11912345678', 1),
('Maria Oliveira', 'maria.oliveira@email.com', '1998-08-22', '2024-02-20', '98765432100', '21998765432', 2),
('Carlos Santos', 'carlos.santos@email.com', '1996-11-10', '2024-03-15', '45678912300', '31976543210', 1),
('Ana Souza', 'ana.souza@email.com', '2000-04-30', '2024-01-25', '32165498700', '41934567890', 4),
('Lucas Pereira', 'lucas.pereira@email.com', '1999-12-05', '2024-04-01', '65432198700', '61987654321', 3);

select * from tbl_aluno;
#Teste feito com sucesso]

#____________________________________________________________________________________________________________________#

#2.4) Inserindo dados de cursos
insert into tbl_curso (nome_curso, tipo_curso, data_inicio, data_conclusao, coordenador)
values ('Engenharia de Software', 'Graduação', '2023-02-01', '2027-12-15', 'Dr. Roberto Almeida'),
('Medicina', 'Graduação', '2022-03-10', '2028-12-15', 'Prof.ª Maria Helena Costa'),
('Mestrado em Ciências de Dados', 'Pós-Graduação', '2023-08-01', '2025-12-20', 'Dr. Carlos Eduardo Silva'),
('Design Gráfico', 'Tecnológico', '2024-01-20', '2025-12-10', 'Prof. Carla Ferreira'),
('MBA em Gestão de Projetos', 'Pós-Graduação', '2024-04-10', '2026-04-10', 'Dr. João Marcos Pereira');

select * from tbl_curso;
#Teste feito com sucesso]

#____________________________________________________________________________________________________________________#

#2.5) Inserindo dados de materias
insert into tbl_materia (nome_materia, carga_horaria, id_professor, id_curso)
values ('algoritmos e estruturas de dados', '120 horas', 1, 1),
('anatomia humana', '180 horas', 2, 2),
('introdução à ciência de dados', '90 horas', 3, 3),
('design de interface de usuário', '100 horas', 4, 4),
('gestão de projetos ágeis', '60 horas', 5, 5);

select * from tbl_materia;
#Teste feito com sucesso]

#____________________________________________________________________________________________________________________#

#2.6) Inserindo dados de relacionamento aluno_curso
insert into tbl_aluno_curso (id_aluno, id_curso)
values (1, 1),
(1, 4),
(2, 2),
(3, 5),
(4, 3),
(5, 1);

select * from tbl_aluno_curso;
#Teste feito com sucesso]

#____________________________________________________________________________________________________________________#

#2.7) Inserindo dados de endereço dos alunos
insert into tbl_endereco_aluno (logradouro, bairro, cep, cidade, estado, pais, id_aluno)
values ('Rua dos Três Irmãos, 11', 'Centro', '01001-000', 'São Paulo', 'São Paulo', 'Brasil', 1),
('Avenida Paulista, 65', 'Bela Vista', '01310-000', 'São Paulo', 'São Paulo', 'Brasil', 2),
('Rua da Consolação, 123', 'Consolação', '01301-000', 'São Paulo', 'São Paulo', 'Brasil', 3),
('Rua dos Três Irmãos, 987', 'Mooca', '03150-000', 'São Paulo', 'São Paulo', 'Brasil', 4),
('Avenida Brigadeiro Faria Lima, 9080', 'Itaim Bibi', '01451-000', 'São Paulo', 'São Paulo', 'Brasil', 5);

select * from tbl_endereco_aluno;
#Teste feito com sucesso]

#____________________________________________________________________________________________________________________#

#2.8) Inserindo dados de endereço do professor
insert into tbl_endereco_professor (logradouro, bairro, cep, cidade, estado, pais, id_professor)
values ('Rua 25 de Março, 88', 'Centro', '01021-000', 'São Paulo', 'São Paulo', 'Brasil', 1),
('Avenida Doutor Arnaldo, 905', 'Sumaré', '01252-000', 'São Paulo', 'São Paulo', 'Brasil', 2),
('Rua dos Três Irmãos, 1122', 'Vila Progredior', '01001-000', 'São Paulo', 'São Paulo', 'Brasil', 3),
('Rua Maranhão, 9999', 'Brás', '03070-000', 'São Paulo', 'São Paulo', 'Brasil', 4),
('Avenida Cruzeiro do Sul, 3456', 'Santana', '02032-000', 'São Paulo', 'São Paulo', 'Brasil', 5);

select * from tbl_endereco_professor;
#Teste feito com sucesso]

#____________________________________________________________________________________________________________________#

#2.9) Adicionando notas de média
insert into tbl_nota (valor_nota, data_atribuicao, id_aluno, id_materia)
values (8.5, '2024-06-15', 1, 1),
(7.5, '2024-06-16', 1, 4),
(7.0, '2024-06-17', 2, 2),
(9.0, '2024-06-18', 3, 5),
(6.5, '2024-06-19', 4, 3),
(8.0, '2024-06-20', 5, 1);

select * from tbl_nota;
