drop table if exists Publication;
create table Publication(
    id INT PRIMARY KEY,
    description VARCHAR(256),
    date DATE NOT NULL,
    price DECIMAL(7,2) NOT NULL,
    idUser INT REFERENCES User NOT NULL,
    ISBN INT REFERENCES Book NOT NULL
);

drop table if exists Publisher;
create table Publisher(
    id INT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);


drop table if exists Selling;
create table Selling(
    idPublication INT PRIMARY KEY,
    date DATE NOT NULL,
    idUser INT REFERENCES User NOT NULL,
    idPayment INT REFERENCES PaymentMethod NOT NULL,
    evaluation INT REFERENCES SellerEvaluation,
);

drop table if exists Genre;
create table Genre(
    id INT PRIMARY KEY,
    name VARCHAR(64) UNIQUE NOT NULL
);

drop table if exists Language;
create table Language(
    code CHAR(2) PRIMARY KEY,
    name VARCHAR(64) UNIQUE NOT NULL
);

drop table if exists Person;
create table Person(
    id INT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    birth DATE NOT NULL
);

drop table if exists Locality;
create table Locality(
    localityCode INT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    nameCountry CHAR(2) REFERENCES Country NOT NULL
);

drop table if exists Country;
create table Country(
    code INT PRIMARY KEY,
    name VARCHAR(64) UNIQUE NOT NULL
);

drop table if exists User;
create table User(
    idPerson INT REFERENCES Person PRIMARY KEY,
    contact INT UNIQUE NOT NULL,
    email VARCHAR(64) UNIQUE NOT NULL,
    register DATE NOT NULL,
    account VARCHAR(128) UNIQUE NOT NULL,
    address VARCHAR(128) NOT NULL,
    streetCode INT NOT NULL,
    localityCode INT REFERENCES Locality NOT NULL
);

drop table if exists Writer;
create table Writer(
    idPerson INT REFERENCES Person PRIMARY KEY
);

drop table if exists Book;
create table Book(
    ISBN INT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    publication DATE NOT NULL,
    edition INT NOT NULL,
    idPublisher INT REFERENCES Publisher NOT NULL
);

drop table if exists Promotion;
create table Promotion(
    id INT PRIMARY KEY,
    start DATE NOT NULL,
    end DATE,
    percentage DECIMAL(6,4) NOT NULL
);
 
drop table if exists PaymentMethod;
create table PaymentMethod(
    id INT PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);

drop table if exists SellerEvaluation;
create table SellerEvaluation(
    id INT PRIMARY KEY,
    comment VARCHAR(256),
    rate INT NOT NULL
);

drop table if exists BookEvaluation;
create table BookEvalutaion(
    idPerson INT PRIMARY KEY,
    ISBN INT REFERENCES Book, 
    comment VARCHAR(256) NOT NULL,
    rate INT
);



