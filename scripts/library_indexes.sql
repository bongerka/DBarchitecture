--- В таблице `cd.books` требуется индексация для поля `genre`, чтобы ускорить операции выборки книг по жанру. 

CREATE INDEX books_genre_idx ON cd.books (genre);


--- В таблице `cd.readers` требуется индексация для поля `last_name`, так как это часто используется при поиске читателя по фамилии.

CREATE INDEX readers_last_name_idx ON cd.readers (last_name);


--- В таблице `cd.copies` поле `book_id` также является внешним ключом, который уже индексируется в таблице `cd.books`. Однако, если требуется быстрый доступ к информации о копиях книги, то можно создать дополнительный индекс для поля `status`.

CREATE INDEX copies_status_idx ON cd.copies (status);


--- В таблице `cd.rentals` можно создать индекс для полей `reader_id` и `book_id`, которые используются при соединении таблиц для получения информации о книгах, которые были арендованы данным читателем.

CREATE INDEX rentals_reader_book_idx ON cd.rentals (reader_id, book_id);
