CREATE TABLE Email(
idEmail INT IDENTITY(0, 1) PRIMARY KEY,

idHub INT not null, -- para relacionar com o Hub

endereco VARCHAR(200) not null, -- xxxx@dd.com
senha VARCHAR(100) not null
)

CREATE TABLE Hub(
-- login --

idHub INT IDENTITY(0, 1) PRIMARY KEY,
username VARCHAR(30) not null,
senha VARCHAR(50) not null,

-- dados --

emails INT

CONSTRAINT FKemails FOREIGN KEY (emails) REFERENCES Email(idEmail)
)

SELECT * FROM Hub
SELECT * FROM Email