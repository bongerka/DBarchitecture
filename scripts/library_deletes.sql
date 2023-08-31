-- 1. Удаление всех записей об аренде книги, соответствующих заданному читателю:

DELETE FROM cd.rentals
WHERE reader_id = 1;


-- 2. Удаление всех записей об авторстве конкретной книги:

DELETE FROM cd.authorship
WHERE book_id = 3;


-- 3. Удаление всех записей о читателях, не арендовавших книг более полугода:

DELETE FROM cd.readers
WHERE reader_id NOT IN (
   SELECT reader_id FROM cd.rentals
   WHERE rent_date >= NOW() - INTERVAL '6 months'
);


-- 4. Удаление всех записей о книгах, изданных до 1900 года:

DELETE FROM cd.books
WHERE year < 1900;


-- 5. Удаление всех записей о свободных экземплярах книг на складе, которые отсутствуют в таблице books:

DELETE FROM cd.book_catalog
WHERE book_id NOT IN (SELECT book_id FROM cd.books);


-- 6. Удаление всех записей об аренде книг, которые были возвращены более месяца назад:

DELETE FROM cd.rentals
WHERE return_date IS NOT NULL AND return_date < NOW() - INTERVAL '1 month';


-- 7. Удаление всех записей о читателях, не арендовавших книг более полугода:

DELETE FROM cd.readers
WHERE reader_id NOT IN (
   SELECT reader_id FROM cd.rentals
   WHERE rent_date >= NOW() - INTERVAL '6 months'
);


-- 8. Удаление всех записей о книгах, у которых нет свободных экземпляров на складе:

DELETE FROM cd.books
WHERE book_id IN (
   SELECT book_id FROM cd.book_catalog
   WHERE available_copies < 1
);


-- 9. Удаление всех записей о копиях книг, которые не были в аренде более года:

DELETE FROM cd.copies
WHERE copy_id NOT IN (
   SELECT DISTINCT copy_id FROM cd.rental_history
   WHERE return_date >= NOW() - INTERVAL '1 year'
);


-- 10. Удаление всех записей об авторах, которые не имеют ни одной книги в базе данных:

DELETE FROM cd.authors
WHERE author_id NOT IN (SELECT author_id FROM cd.books);
