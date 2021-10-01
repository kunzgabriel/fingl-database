create table clientes (
    id int generated always as identity primary key,
    nome varchar(200) not null,
    cpfcnpj varchar(18) not null,
    data_nascimento date,
    telefone varchar(16),
    celular varchar(16),
    email varchar(250),
    endereco varchar(250),
    bairro varchar(150),
    numero int,
    complemento varchar(100),
    cep varchar(9),
    municipio varchar(200),
    uf varchar(2)
);

create table fornecedores (
    id int generated always as identity primary key,
    nome varchar(200) not null,
    cpfcnpj varchar(18) not null,
    data_nascimento date,
    telefone varchar(16),
    celular varchar(16),
    email varchar(250),
    endereco varchar(250),
    bairro varchar(150),
    numero int,
    complemento varchar(100),
    cep varchar(9),
    municipio varchar(200),
    uf varchar(2)
);

create table contas (
    id int generated always as identity primary key,
    descricao varchar(200) not null,
    saldo numeric(15,2) not null default 0
);

create table tabela_contabil (
    id int generated always as identity primary key,
    descricao varchar(200) not null,
    conta_credito int not null,
    conta_debito int not null,
    constraint fk_conta_credito_to_tabelas_contabil foreign key (conta_credito) references contas (id),
    constraint fk_conta_debito_to_tabelas_contabil foreign key (conta_debito) references contas (id)
);

create table titulos (
    id int generated always as identity primary key,
    tipo varchar(1), -- P - pagar, R - receber
    tabela_contabil int not null,
    titulo varchar(25),
    cliente int,
    fornecedor int,
    emissao timestamp not null,
    valor numeric(15,2) not null,
    vencimento timestamp not null,
    pagamento timestamp,
    valor_pago numeric(15,2),
    observacao varchar(200),
    desconto numeric(15,3),
    multa numeric(15,3),
    constraint fk_tabela_contabil_to_titulos foreign key (tabela_contabil) references tabela_contabil (id),
    constraint fk_cliente_to_titulos foreign key (cliente) references clientes (id),
    constraint fk_fornecedor_to_titulos foreign key (fornecedor) references fornecedores (id)
);

create table titulos_lancamentos (
    id int generated always as identity primary key,
    titulo int not null,
    valor numeric(15,2) not null,
    tabela_contabil int not null,
    observacao varchar(200) not null,
    constraint fk_titulos_to_titulos_lancamentos foreign key (titulo) references titulos (id),
    constraint fk_tabela_contabil_to_titulos_lancamentos foreign key (tabela_contabil) references tabela_contabil (id)
);
