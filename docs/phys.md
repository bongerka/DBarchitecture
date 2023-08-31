### Таблица "Книги"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| book_id | SERIAL | Идентификатор книги | NOT NULL | YES | NO |
| title | CHARACTER VARYING(200) | Название книги | NOT NULL | NO | NO |
| author_id | INTEGER | Идентификатор автора | NOT NULL | NO | YES |
| genre | CHARACTER VARYING(100) | Жанр книги | NOT NULL | NO | NO |
| pages | INTEGER | Количество страниц в книге | NOT NULL | NO | NO |
| publisher | CHARACTER VARYING(200) | Название издательства | NOT NULL | NO | NO |
| pub_year | INTEGER | Год издания книги | NOT NULL | NO | NO |

### Таблица "Авторы"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| author_id | SERIAL | Идентификатор автора | NOT NULL | YES | NO |
| first_name | CHARACTER VARYING(50) | Имя автора | NOT NULL | NO | NO |
| last_name | CHARACTER VARYING(50) | Фамилия автора | NOT NULL | NO | NO |
| birth_date | DATE | Дата рождения автора | | NO | NO |
| death_date | DATE | Дата смерти автора | | NO | NO |

### Таблица "Авторство"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| authorship_id | SERIAL | Идентификатор авторства | NOT NULL | YES | NO |
| author_id | INTEGER | Идентификатор автора | NOT NULL | NO | YES |
| book_id | INTEGER | Идентификатор книги | NOT NULL | NO | YES |

### Таблица "Читатели"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| reader_id | SERIAL | Идентификатор читателя | NOT NULL | YES | NO |
| first_name | CHARACTER VARYING(50) | Имя читателя | NOT NULL | NO | NO |
| last_name | CHARACTER VARYING(50) | Фамилия читателя | NOT NULL | NO | NO |
| address | CHARACTER VARYING(300) | Адрес читателя | NOT NULL | NO | NO |
| zipcode | INTEGER | Почтовый индекс | NOT NULL | NO | NO |
| telephone | CHARACTER VARYING(20) | Телефон читателя | NOT NULL | NO | NO |
| registration_date | TIMESTAMP | Дата регистрации в библиотеке | NOT NULL | NO | NO |

### Таблица "Аренды"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| rental_id | SERIAL | Идентификатор аренды | NOT NULL | YES | NO |
| reader_id | INTEGER | Идентификатор читателя | NOT NULL | NO | YES |
| book_id | INTEGER | Идентификатор книги | NOT NULL | NO | YES |
| rent_date | TIMESTAMP | Дата аренды книги | NOT NULL | NO | NO |
| return_date | TIMESTAMP | Дата возврата книги | | NO | NO |

### Таблица "Каталог книг"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| book_id | INTEGER | Идентификатор книги | NOT NULL | YES | YES |
| available_copies | INTEGER | Количество доступных экземпляров книги | NOT NULL | | |

### Таблица "Экземпляры"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| copy_id | SERIAL | Идентификатор экземпляра книги | NOT NULL | YES | NO |
| book_id | INTEGER | Идентификатор книги | NOT NULL | NO | YES |
| status | BOOLEAN | Статус экземпляра (доступен/арендован) | NOT NULL | | |

### Таблица "История аренды"
| Название | Тип данных | Описание | Ограничение | PK | FK |
| --- | --- | --- | --- | --- | --- |
| rental_id | INTEGER | Идентификатор аренды | NOT NULL | YES | YES |
| copy_id | INTEGER | Идентификатор экземпляра книги | NOT NULL | NO | YES |
| rent_date | TIMESTAMP | Дата аренды книги | NOT NULL | NO | NO |
| return_date | TIMESTAMP | Дата возврата книги | | | |
