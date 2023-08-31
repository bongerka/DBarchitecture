-- 1. Обновление названия книги с id=5 на "Война и мир" в таблице books:

UPDATE cd.books
SET title = 'Война и мир'
WHERE book_id = 5;


-- 2. Изменение количества доступных копий книги с id=8 на 10 в таблице book_catalog:

UPDATE cd.book_catalog
SET available_copies = 10
WHERE book_id = 8;


-- 3. Обновление даты возврата книги с id=25 на 2021-05-18 в таблице rentals:

UPDATE cd.rentals
SET return_date = '2021-05-18'
WHERE rental_id = 25;


-- 4. Изменение имени автора с id=7 на "Федор" в таблице authors:

UPDATE cd.authors
SET first_name = 'Федор'
WHERE author_id = 7;


-- 5. Обновление статуса копии книги с id=16 на false в таблице copies:

UPDATE cd.copies
SET status = false
WHERE copy_id = 16;


-- 6. Изменение жанра книги с id=13 на "Роман" в таблице books:

UPDATE cd.books
SET genre = 'Роман'
WHERE book_id = 13;

-- 7. Изменение адреса читателя с указанным идентификатором:

UPDATE cd.readers
SET address = 'ул. Пушкина, д. 7, кв. 12'
WHERE reader_id = 2;


-- 8. Изменение статуса экземпляра книги на "свободный":

UPDATE cd.copies
SET status = true
WHERE copy_id = 5;


-- 9. Изменение количества свободных экземпляров книги на складе:

UPDATE cd.book_catalog
SET available_copies = 3
WHERE book_id = 1;


-- 10. Изменение даты возврата арендованной книги:

UPDATE cd.rentals
SET return_date = NOW()
WHERE rental_id = 4;
