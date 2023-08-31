-- 1. Добавление нового автора:

INSERT INTO cd.authors (author_id, first_name, last_name, birth_date, death_date) 
VALUES (2, 'Федор', 'Достоевский', '1821-11-11', '1881-02-09');


-- 2. Добавление новой книги:

INSERT INTO cd.books (title, year, pages, genre, publisher, author_id)
VALUES ('Идиот', 1869, 656, 'роман', 'Санкт-Петербург', 2);


-- 3. Добавление нового читателя:

INSERT INTO cd.readers (first_name, last_name, address, zipcode, telephone, registration_date)
VALUES ('Иван', 'Иванов', 'ул. Ленина, д. 10', 123456, '+79123456789', NOW());


-- 4. Добавление новой записи о свободных экземплярах книги на складе:

INSERT INTO cd.book_catalog (book_id, available_copies)
VALUES (1, 5);


-- 5. Добавление нескольких книг одного автора:

INSERT INTO cd.books (title, year, pages, genre, publisher, author_id)
VALUES
    ('Преступление и наказание', 1866, 551, 'роман', 'Санкт-Петербург', 2),
    ('Братья Карамазовы', 1880, 824, 'роман', 'Москва', 2);


-- 6. Добавление нового экземпляра книги в базу данных:

INSERT INTO cd.copies (book_id, status)
VALUES (2, true);


-- 7. Добавление новой записи об аренде книги:

INSERT INTO cd.rentals (reader_id, book_id, rent_date)
VALUES (1, 2, NOW());


-- 8. Добавление новой записи об авторстве книги:

INSERT INTO cd.authorship (author_id, book_id)
VALUES (2, 2);


-- 9. Добавление нового экземпляра книги в базу данных:

INSERT INTO cd.copies (book_id, status)
VALUES (2, true);


-- 10. Добавление новой записи о свободных экземплярах книги на складе:

INSERT INTO cd.book_catalog (book_id, available_copies)
VALUES (2, 6);