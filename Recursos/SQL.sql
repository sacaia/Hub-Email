drop table Email
drop table Hub

CREATE TABLE Hub(
-- login --

idHub INT IDENTITY(0, 1) PRIMARY KEY,
username VARCHAR(30) not null,
senha VARCHAR(50) not null,
)

CREATE TABLE Email(
idEmail INT IDENTITY(0, 1) PRIMARY KEY,

idHub INT not null, -- para relacionar com o Hub

endereco VARCHAR(200) not null, -- xxxx@dd.com
senha VARCHAR(100) not null,

porta varchar(6) not null,
protocolo varchar(4) not null,

CONSTRAINT FKhub FOREIGN KEY (idHub) REFERENCES Hub(idHub)
)

SELECT * FROM Hub
SELECT * FROM Email

SELECT * FROM Email WHERE idHub = 1