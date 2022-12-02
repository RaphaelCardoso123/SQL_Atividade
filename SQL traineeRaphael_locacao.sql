create database traineeRaphael;
use traineeRaphael;
create schema locacao;


create table locacao.cliente(
	cd_cliente int primary key identity(1, 1),
	nm_cliente varchar(50) not null
);


create table locacao.classificacao(
	cd_classificacao int primary key identity(1, 1),
	vl_locacao_diaria money not null
);


create table locacao.categoria(
	sg_categoria char(1) primary key,
	nm_categoria varchar(30) not null
);


create table locacao.solicitacao(
	cd_solicitacao int primary key identity(1, 1),
	cd_cliente int not null,
	dt_solicitacao date not null,
	foreign key(cd_cliente) references locacao.cliente(cd_cliente)
	on delete cascade
	on update cascade
);


create table locacao.filme(
	cd_filme int primary key identity(1, 1),
	nm_filme varchar(50) not null,
	sg_categoria char(1),
	cd_classificacao int,
	foreign key(sg_categoria) references locacao.categoria(sg_categoria)
	on delete set null
	on update cascade,
	foreign key(cd_classificacao) references locacao.classificacao(cd_classificacao)
	on delete cascade
	on update cascade
);


create table locacao.solicitacao_filme(
	cd_filme int not null,
	cd_solicitacao int not null,
	dt_devolucao_prevista date not null,
	dt_devolucao_real date,
	primary key(cd_filme, cd_solicitacao),

	foreign key(cd_filme) references locacao.filme(cd_filme)
	on delete cascade
	on update cascade,
	foreign key(cd_solicitacao) references locacao.solicitacao(cd_solicitacao)
	on delete cascade
	on update cascade
);


alter table locacao.classificacao
add nm_classificacao varchar(30) not null;


begin transaction;
insert into locacao.categoria(sg_categoria, nm_categoria)
values('D', 'Drama'), ('T', 'Terror'), ('S', 'Suspense'), ('C', 'Comedia'), ('R', 'Romance')
commit;
select * from locacao.categoria;


begin transaction;
insert into locacao.cliente(nm_cliente)
values('Raphael'), ('Flávia'), ('Pedro'), ('Jéssica'), ('Jaqueline')
commit;
select * from locacao.cliente;


begin transaction;
insert into locacao.classificacao(vl_locacao_diaria, nm_classificacao)
values(12.00, 'Livre'), (17.00, 'Lançamento'), (25.00, 'Cinema')
commit;
select * from locacao.classificacao;


begin transaction;
insert into locacao.filme(nm_filme, sg_categoria)
values('Cães de Aluguel', 'D'), ('Dia de cão', 'S'), ('Segurem o piloto', 'C'), ('Amor em alto mar', 'R'), ('Sol do Egito', 'D')
commit;
select * from locacao.filme;


begin transaction;
insert into locacao.solicitacao(cd_cliente, dt_solicitacao) 
values(2, '20221130'), (5, '20221112'), (3, '20220810'), (1, '20221008'), (4, '20220104'),
	  (1, '20220411'), (5, '20220802'), (3, '20220310'), (2, '20220708'), (4, '20221104')
commit;
select * from locacao.solicitacao;


begin transaction;
insert into locacao.solicitacao_filme(cd_filme, cd_solicitacao, dt_devolucao_prevista, dt_devolucao_real) 
values(1, 6, '20220512', '20220510'), (5, 3, '20220512', '20220510'), (1, 3, '20220512', '20220510'), (2, 1, '20220512', '20220510'),
      (2, 9, '20220512', '20220510'), (4, 10, '20220512', '20220510'), (2, 8, '20220512', '20220510'), (4, 1, '20220512', '20220510'),
	  (3, 8, '20220512', '20220510'), (3, 1, '20220512', '20220510'), (3, 2, '20220512', '20220510'), (3, 3, '20220512', '20220510'),
	  (4, 7, '20220512', '20220510'), (2, 10, '20220512', '20220510'), (4, 3, '20220512', '20220510'), (2, 7, '20220512', '20220510'),
	  (5, 7, '20220512', '20220510'), (1, 2, '20220512', '20220510'), (5, 2, '20220512', '20220510'), (1, 7, '20220512', '20220510')
commit;
select * from locacao.solicitacao_filme;

