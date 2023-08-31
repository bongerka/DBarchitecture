CREATE SCHEMA IF NOT EXISTS cd;

CREATE TABLE IF NOT EXISTS cd.authors (
   author_id int,
   first_name varchar(32) NOT NULL,
   last_name varchar(32) NOT NULL,
   birth_date date,
   death_date date,

   CONSTRAINT authors_pk PRIMARY KEY (author_id)
);

CREATE TABLE IF NOT EXISTS cd.books (
   book_id serial,
   title varchar(128) NOT NULL,
   year int NOT NULL,
   pages int NOT NULL,
   genre varchar(50)  NOT NULL,
   publisher varchar(100) NOT NULL,
   author_id int,

   CONSTRAINT books_pk PRIMARY KEY (book_id),
   CONSTRAINT books_fk FOREIGN KEY (author_id) REFERENCES cd.authors(author_id)
);

CREATE TABLE IF NOT EXISTS cd.authorship (
   authorship_id serial,
   author_id int,
   book_id int,

   CONSTRAINT authorship_pk PRIMARY KEY (authorship_id),
   CONSTRAINT authorship_fk1 FOREIGN KEY (author_id) REFERENCES cd.authors(author_id),
   CONSTRAINT authorship_fk2 FOREIGN KEY (book_id) REFERENCES cd.books(book_id)
);

CREATE TABLE IF NOT EXISTS cd.readers (
   reader_id serial,
   first_name varchar(50) NOT NULL,
   last_name varchar(50) NOT NULL,
   address varchar(300) NOT NULL,
   zipcode int NOT NULL,
   telephone varchar(20)  NOT NULL,
   registration_date timestamp NOT NULL,

   CONSTRAINT readers_pk PRIMARY KEY (reader_id)
);

CREATE TABLE IF NOT EXISTS cd.rentals (
   rental_id serial,
   reader_id int,
   book_id int,
   rent_date timestamp NOT NULL DEFAULT now(),
   return_date timestamp,

   CONSTRAINT rentals_pk PRIMARY KEY (rental_id),
   CONSTRAINT rental_fk1 FOREIGN KEY (reader_id) REFERENCES cd.readers(reader_id),
   CONSTRAINT rental_fk2 FOREIGN KEY (book_id) REFERENCES cd.books(book_id)
);

CREATE TABLE IF NOT EXISTS cd.book_catalog (
   book_id int,
   available_copies int NOT NULL,

   CONSTRAINT book_catalog_pk PRIMARY KEY (book_id),
   CONSTRAINT book_catalog_fk FOREIGN KEY (book_id) REFERENCES cd.books(book_id)
);

CREATE TABLE IF NOT EXISTS cd.copies (
   copy_id serial,
   book_id int,
   status bool NOT NULL DEFAULT true,

   CONSTRAINT copies_pk PRIMARY KEY (copy_id),
   CONSTRAINT copies_fk FOREIGN KEY (book_id) REFERENCES cd.books(book_id)
);

CREATE TABLE IF NOT EXISTS cd.rental_history (
   rental_id int,
   copy_id int,
   rent_date timestamp NOT NULL,
   return_date timestamp,

   CONSTRAINT rental_history_pk PRIMARY KEY (rental_id, copy_id),
   CONSTRAINT rental_history_fk1 FOREIGN KEY (rental_id) REFERENCES cd.rentals(rental_id),
   CONSTRAINT rental_history_fk2 FOREIGN KEY (copy_id) REFERENCES cd.copies(copy_id)
);

SELECT coalesce(NULL, 2, NULL) IS DISTINCT FROM NULL