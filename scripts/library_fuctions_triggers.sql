-- Хранимая процедура для добавления новой книги:

CREATE OR REPLACE FUNCTION cd.add_book(
    p_title varchar(128),
    p_year int,
    p_pages int,
    p_genre varchar(50),
    p_publisher varchar(100),
    p_author_id int
)
    RETURNS void AS $$
BEGIN
    INSERT INTO cd.books(title, year, pages, genre, publisher, author_id)
    VALUES(p_title, p_year, p_pages, p_genre, p_publisher, p_author_id);
    UPDATE cd.book_catalog SET available_copies = available_copies+1 WHERE book_id = (SELECT MAX(book_id) FROM cd.books);
END;
$$ LANGUAGE plpgsql;

-- Хранимая функция для получения списка книг, написанных автором, который имеет наибольшее количество произведений в библиотеке:

CREATE OR REPLACE FUNCTION cd.get_most_prolific_author()
    RETURNS TABLE(author_name varchar(64), book_count int) AS $$
BEGIN
    RETURN QUERY SELECT CONCAT(a.first_name, ' ', a.last_name) AS author_name, COUNT(*) AS book_count
                 FROM cd.books b
                          JOIN cd.authors a ON b.author_id = a.author_id
                 GROUP BY b.author_id, author_name
                 ORDER BY book_count DESC LIMIT 1;
END;
$$ LANGUAGE plpgsql;

-- Триггер для автоматического обновления количества доступных экземпляров при возврате книги:

CREATE OR REPLACE FUNCTION cd.update_available_copies()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE cd.book_catalog SET available_copies = available_copies+1 WHERE book_id = OLD.book_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rental_return_trigger
    AFTER UPDATE ON cd.rentals
    FOR EACH ROW
    WHEN (OLD.return_date IS NULL AND NEW.return_date IS NOT NULL)
EXECUTE FUNCTION cd.update_available_copies();

-- Триггер для автоматического обновления количества доступных экземпляров при аренде книги:

CREATE OR REPLACE FUNCTION cd.update_available_copies_on_rent()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE cd.book_catalog SET available_copies = available_copies-1 WHERE book_id = NEW.book_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rental_rent_trigger
    AFTER INSERT ON cd.rentals
    FOR EACH ROW
EXECUTE FUNCTION cd.update_available_copies_on_rent();