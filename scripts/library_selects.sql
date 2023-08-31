-- 1. Группировка и сортировка книг по жанру и автору:

SELECT author_id, genre, COUNT(*) as num_books
FROM cd.books
GROUP BY author_id, genre
HAVING COUNT(*) > 1
ORDER BY author_id, genre;


-- 2. Поиск читателей с наибольшим количеством арендованных книг:

SELECT reader_id, COUNT(*) as num_rentals
FROM cd.rentals
GROUP BY reader_id
ORDER BY num_rentals DESC
LIMIT 10;


-- 3. Выборка количества свободных экземпляров каждой книги на складе:

SELECT bc.book_id, b.title, SUM(bc.available_copies) as num_copies_available
FROM cd.book_catalog bc
JOIN cd.books b ON bc.book_id = b.book_id
GROUP BY bc.book_id, b.title
ORDER BY num_copies_available DESC;


-- 4. Расчет среднего количества страниц в книгах каждого жанра:

SELECT genre, AVG(pages) as avg_pages
FROM cd.books
GROUP BY genre;


-- 5. Выборка количества книг каждого автора, отсортированных в обратном порядке:

SELECT author_id, COUNT(*) as num_books
FROM cd.books
GROUP BY author_id
ORDER BY num_books DESC;


-- 6. Этот запрос выводит информацию о количестве доступных копий книг каждого жанра,
-- выпущенных до 2000 года.
-- Запрос соединяет таблицы books и book_catalog по ключу book_id,
-- а затем использует оконную функцию SUM OVER PARTITION BY,
-- чтобы определить общее число доступных копий каждой книги в пределах своего жанра,
-- суммируя копии в порядке возрастания года выпуска. Результаты сортируются сначала по жанру, а затем по году.

SELECT title, year, SUM(available_copies) OVER(PARTITION BY genre ORDER BY year ASC) AS total_copies_by_genre
FROM cd.books JOIN cd.book_catalog ON cd.books.book_id = cd.book_catalog.book_id
WHERE year <= 2000
ORDER BY genre, year;


-- 7. Ранжирование книг по году издания внутри каждого жанра:

SELECT title, genre, year,
       RANK() OVER (PARTITION BY genre ORDER BY year ASC) as book_rank
FROM cd.books;


-- 8. Вывод списка книг и среднего числа страниц для каждого автора, отсортированного по фамилии:

SELECT a.last_name, b.title, AVG(b.pages) as avg_pages
FROM cd.authors a
JOIN cd.books b ON a.author_id = b.author_id
GROUP BY a.last_name, b.title
ORDER BY a.last_name;


-- 9. Определение доли каждого жанра в общем числе страниц книг:

SELECT genre, SUM(pages) as total_pages,
       100 * SUM(pages) / SUM(SUM(pages)) OVER () as page_share_percent
FROM cd.books
GROUP BY genre;


-- 10. Расчет среднего количества страниц в книгах каждого жанра:

SELECT genre, AVG(pages) as avg_pages
FROM cd.books
GROUP BY genre;
