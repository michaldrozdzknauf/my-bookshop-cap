PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE my_bookshop_Books (
  ID INTEGER NOT NULL,
  title NVARCHAR(255),
  author_ID INTEGER,
  stock INTEGER,
  PRIMARY KEY(ID)
);
INSERT INTO my_bookshop_Books VALUES(201,'Aaa Aaa',150,120);
INSERT INTO my_bookshop_Books VALUES(211,'Bbb Bbb',120,230);
INSERT INTO my_bookshop_Books VALUES(221,'Ccc Ccc',150,15);
INSERT INTO my_bookshop_Books VALUES(231,'Ddd Ddd',170,140);
CREATE TABLE my_bookshop_Authors (
  ID INTEGER NOT NULL,
  name NVARCHAR(255),
  PRIMARY KEY(ID)
);
INSERT INTO my_bookshop_Authors VALUES(120,'Krzysiek Adamski');
INSERT INTO my_bookshop_Authors VALUES(150,'Adam Adamski');
INSERT INTO my_bookshop_Authors VALUES(170,'Monika Adamska');
CREATE TABLE my_bookshop_Books_texts (
  locale NVARCHAR(14) NOT NULL,
  ID INTEGER NOT NULL,
  title NVARCHAR(255),
  PRIMARY KEY(locale, ID)
);
CREATE TABLE my_bookshop_Orders (
  createdAt TIMESTAMP_TEXT,
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP_TEXT,
  modifiedBy NVARCHAR(255),
  ID NVARCHAR(36) NOT NULL,
  book_ID INTEGER,
  country_code NVARCHAR(3),
  amount INTEGER,
  PRIMARY KEY(ID)
);
CREATE TABLE sap_common_Countries (
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(3) NOT NULL,
  PRIMARY KEY(code)
);
CREATE TABLE sap_common_Countries_texts (
  locale NVARCHAR(14) NOT NULL,
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(3) NOT NULL,
  PRIMARY KEY(locale, code)
);
CREATE TABLE cds_outbox_Messages (
  ID NVARCHAR(36) NOT NULL,
  timestamp TIMESTAMP_TEXT,
  target NVARCHAR(255),
  msg NCLOB,
  attempts INTEGER DEFAULT 0,
  "partition" INTEGER DEFAULT 0,
  lastError NCLOB,
  lastAttemptTimestamp TIMESTAMP_TEXT,
  status NVARCHAR(23),
  task NVARCHAR(255),
  appid NVARCHAR(255),
  PRIMARY KEY(ID)
);
CREATE VIEW CatalogService_Books AS SELECT
  Books_0.ID,
  Books_0.title,
  Books_0.author_ID,
  Books_0.stock
FROM my_bookshop_Books AS Books_0;
CREATE VIEW CatalogService_Authors AS SELECT
  Authors_0.ID,
  Authors_0.name
FROM my_bookshop_Authors AS Authors_0;
CREATE VIEW CatalogService_Books_texts AS SELECT
  texts_0.locale,
  texts_0.ID,
  texts_0.title
FROM my_bookshop_Books_texts AS texts_0;
CREATE VIEW CatalogService_Orders AS SELECT
  Orders_0.createdAt,
  Orders_0.createdBy,
  Orders_0.modifiedAt,
  Orders_0.modifiedBy,
  Orders_0.ID,
  Orders_0.book_ID,
  Orders_0.country_code,
  Orders_0.amount
FROM my_bookshop_Orders AS Orders_0;
CREATE VIEW CatalogService_Countries AS SELECT
  Countries_0.name,
  Countries_0.descr,
  Countries_0.code
FROM sap_common_Countries AS Countries_0;
CREATE VIEW CatalogService_Countries_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_common_Countries_texts AS texts_0;
CREATE VIEW localized_my_bookshop_Books AS SELECT
  L_0.ID,
  coalesce(localized_1.title, L_0.title) AS title,
  L_0.author_ID,
  L_0.stock
FROM (my_bookshop_Books AS L_0 LEFT JOIN my_bookshop_Books_texts AS localized_1 ON localized_1.ID = L_0.ID AND localized_1.locale = session_context( '$user.locale' ));
CREATE VIEW localized_sap_common_Countries AS SELECT
  coalesce(localized_1.name, L_0.name) AS name,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.code
FROM (sap_common_Countries AS L_0 LEFT JOIN sap_common_Countries_texts AS localized_1 ON localized_1.code = L_0.code AND localized_1.locale = session_context( '$user.locale' ));
CREATE VIEW localized_CatalogService_Books AS SELECT
  Books_0.ID,
  Books_0.title,
  Books_0.author_ID,
  Books_0.stock
FROM localized_my_bookshop_Books AS Books_0;
CREATE VIEW localized_CatalogService_Countries AS SELECT
  Countries_0.name,
  Countries_0.descr,
  Countries_0.code
FROM localized_sap_common_Countries AS Countries_0;
COMMIT;
SQLite version 3.51.0 2025-06-12 13:14:41
Enter ".help" for usage hints.
