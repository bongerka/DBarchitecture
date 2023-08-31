CREATE VIEW cd.books_view AS
SELECT
    book_id,
    title,
    year,
    pages,
    genre,
    publisher,
    CONCAT('XXXX-XXXX-XXXX-', RIGHT(CAST(book_id AS VARCHAR), 4)) AS masked_book_id,
    author_id
FROM cd.books;


CREATE VIEW cd.rental_history_extended AS
SELECT rh.rental_id, rh.rent_date, rh.return_date, b.title, a.first_name || ' ' || a.last_name AS author_name
FROM cd.rental_history rh
         JOIN cd.copies c ON rh.copy_id = c.copy_id
         JOIN cd.books b ON c.book_id = b.book_id
         JOIN cd.authorship ash ON b.book_id = ash.book_id
         JOIN cd.authors a ON ash.author_id = a.author_id
         JOIN cd.rentals r ON rh.rental_id = r.rental_id;


CREATE VIEW cd.authors_view AS
SELECT
    author_id,
    first_name,
    last_name,
    birth_date,
    death_date
FROM cd.authors;


CREATE VIEW cd.book_catalog_extended AS
SELECT b.title, b.year, a.first_name || ' ' || a.last_name AS author_name, bc.available_copies
FROM cd.books b
         JOIN cd.authorship ash ON b.book_id = ash.book_id
         JOIN cd.authors a ON ash.author_id = a.author_id
         JOIN cd.book_catalog bc ON b.book_id = bc.book_id;
SELECT * FROM cd.book_catalog_extended;


CREATE VIEW cd.rental_frequencies AS
SELECT r.reader_id, COUNT(*) AS rental_count
FROM cd.rentals r
GROUP BY r.reader_id;


CREATE VIEW cd.rentals_view AS
SELECT
    rental_id,
    cd.readers.reader_id,
    CONCAT(LEFT(telephone, LENGTH(telephone)-7), '*******') AS masked_telephone,
    registration_date,
    book_id,
    rent_date,
    return_date
FROM cd.rentals
         JOIN cd.readers ON cd.rentals.reader_id = cd.readers.reader_id;