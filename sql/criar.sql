PRAGMA foreign_keys = ON;

drop table if exists Country;
create table Country(
    code CHAR(2) PRIMARY KEY,
    name VARCHAR(64) UNIQUE NOT NULL
);

drop table if exists Publisher;
create table Publisher(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL
);

drop table if exists PaymentMethod;
create table PaymentMethod(
    id INTEGER PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);

drop table if exists Genre;
create table Genre(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) UNIQUE NOT NULL
);


drop table if exists Language;
create table Language(
    code CHAR(2) PRIMARY KEY,
    name VARCHAR(64) UNIQUE NOT NULL
);


drop table if exists Locality;
create table Locality(
    localityCode INTEGER PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    nameCountry CHAR(2) REFERENCES Country ON DELETE RESTRICT ON UPDATE CASCADE
);

drop table if exists Person;
create table Person(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64) NOT NULL,
    birth DATE NOT NULL
);

drop table if exists User;
create table User(
    idPerson INTEGER REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE PRIMARY KEY,
    contact INTEGER UNIQUE NOT NULL,
    email VARCHAR(64) UNIQUE NOT NULL,
    register DATE NOT NULL DEFAULT (DATETIME('now')),
    account VARCHAR(128) UNIQUE NOT NULL,
    address VARCHAR(128) NOT NULL,
    streetCode INTEGER NOT NULL,
    localityCode INTEGER REFERENCES Locality ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT validContact CHECK (contact >= 10000000)
);

drop table if exists Book;
create table Book(
    ISBN INTEGER PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    publication DATE NOT NULL,
    edition INTEGER NOT NULL,
    idPublisher INTEGER REFERENCES Publisher ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT positiveEdition CHECK(edition > 0),
    CONSTRAINT positiveISBN CHECK (ISBN > 0)
);

drop table if exists Publication;
create table Publication(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    description VARCHAR(256),
    registerDate DATE NOT NULL DEFAULT (DATETIME('now')),
    price DECIMAL(7,2) NOT NULL,
    idUser INTEGER REFERENCES User ON DELETE SET NULL ON UPDATE CASCADE,
    ISBN INTEGER REFERENCES Book ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT positivePrice CHECK(price > 0)
);

drop table if exists SellerEvaluation;
create table SellerEvaluation(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    comment VARCHAR(256),
    rate INTEGER NOT NULL,
    CONSTRAINT rateRange CHECK(rate <= 5 and rate >= 0)
);

drop table if exists Selling;
create table Selling(
    idPublication INTEGER REFERENCES Publication ON DELETE CASCADE ON UPDATE CASCADE PRIMARY KEY,
    sellingDate DATE NOT NULL DEFAULT (DATETIME('now')),
    idUser INTEGER REFERENCES User ON DELETE SET NULL ON UPDATE CASCADE,
    idPayment INTEGER REFERENCES PaymentMethod ON DELETE RESTRICT ON UPDATE CASCADE,
    evaluation INTEGER REFERENCES SellerEvaluation ON DELETE SET NULL ON UPDATE CASCADE
);

drop table if exists Writer;
create table Writer(
    idPerson INTEGER REFERENCES Person ON DELETE CASCADE ON UPDATE CASCADE PRIMARY KEY 
);

drop table if exists Promotion;
create table Promotion(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    start DATE NOT NULL,
    end DATE,
    percentage DECIMAL(6,4) NOT NULL,
    CONSTRAINT percentageRate CHECK( percentage > 0 and percentage <= 100),
    CONSTRAINT dateConst CHECK (end > start)
);

drop table if exists BookEvaluation;
create table BookEvaluation(
    idPerson INTEGER REFERENCES User ON DELETE SET NULL ON UPDATE CASCADE,
    ISBN INTEGER REFERENCES Book ON DELETE CASCADE ON UPDATE CASCADE, 
    comment VARCHAR(256),
    rate INTEGER NOT NULL,
    PRIMARY KEY(idPerson, ISBN),
    CONSTRAINT rateRange CHECK(rate <= 5 and rate >= 0)
);

drop table if exists BookWriter;
create table BookWriter(
    idWriter INTEGER REFERENCES Writer ON DELETE RESTRICT ON UPDATE CASCADE,
    ISBN INTEGER REFERENCES Book ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY(idWriter, ISBN)
);

drop table if exists BookGenre; 
create table BookGenre(
    ISBN INTEGER REFERENCES Book ON DELETE RESTRICT ON UPDATE CASCADE,
    idGenre INTEGER REFERENCES Genre ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (ISBN, idGenre)
    
);

drop table if exists BookLanguage;
create table BookLanguage(
    ISBN INTEGER REFERENCES Book ON DELETE RESTRICT ON UPDATE CASCADE,
    codeLanguage CHAR(2) REFERENCES Language ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY(ISBN, codeLanguage)
);

drop table if exists PromotionPublication; 
create table PromotionPublication(
    idPublication INTEGER REFERENCES Publication ON DELETE CASCADE ON UPDATE CASCADE, 
    idPromotion INTEGER REFERENCES Promotion ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(idPublication, idPromotion)
);


