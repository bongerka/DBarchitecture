package tests

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"log"
)

type structSelect1 struct {
	authorId int
	genre    string
	numBooks int
}

func getSelect1(db *sql.DB) (result []structSelect1, err error) {
	sqlQuery := fmt.Sprint(`
		SELECT author_id, genre, COUNT(*) as num_books
		FROM cd.books GROUP BY author_id, genre
		HAVING COUNT(*) > 1
		ORDER BY author_id, genre`)
	rows, err := db.Query(sqlQuery)
	if err != nil {
		return
	}
	defer rows.Close()

	var authorId, numBooks int
	var genre string
	for rows.Next() {
		err = rows.Scan(&authorId, &genre, &numBooks)
		if err != nil {
			log.Fatal(err)
		}
		result = append(result, structSelect1{authorId, genre, numBooks})
	}
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}
	return
}

type structSelect2 struct {
	readerId   int
	numRentals int
}

func getSelect2(db *sql.DB) (result []structSelect2, err error) {
	sqlQuery := fmt.Sprint(`
		SELECT reader_id, COUNT(*) as num_rentals
		FROM cd.rentals
		GROUP BY reader_id
		ORDER BY num_rentals DESC
		LIMIT 10`)
	rows, err := db.Query(sqlQuery)
	if err != nil {
		return
	}
	defer rows.Close()

	var readerId, numRentals int
	for rows.Next() {
		err = rows.Scan(&readerId, &numRentals)
		if err != nil {
			log.Fatal(err)
		}
		result = append(result, structSelect2{readerId, numRentals})
	}
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}
	return
}

type structSelect3 struct {
	bookId             int
	title              string
	numCopiesAvailable int
}

func getSelect3(db *sql.DB) (result []structSelect3, err error) {
	sqlQuery := fmt.Sprint(`
		SELECT bc.book_id, b.title, SUM(bc.available_copies) as num_copies_available
		FROM cd.book_catalog bc
		JOIN cd.books b ON bc.book_id = b.book_id
		GROUP BY bc.book_id, b.title
		ORDER BY num_copies_available DESC`)
	rows, err := db.Query(sqlQuery)
	if err != nil {
		return
	}
	defer rows.Close()

	var bookId, numCopiesAvailable int
	var title string
	for rows.Next() {
		err = rows.Scan(&bookId, &title, &numCopiesAvailable)
		if err != nil {
			log.Fatal(err)
		}
		result = append(result, structSelect3{bookId, title, numCopiesAvailable})
	}
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}
	return
}

type structSelect4 struct {
	title    string
	genre    string
	year     int
	bookRank int
}

func getSelect4(db *sql.DB) (result []structSelect4, err error) {
	sqlQuery := fmt.Sprint(`
		SELECT title, genre, year,
			   RANK() OVER (PARTITION BY genre ORDER BY year ASC) as book_rank
		FROM cd.books`)
	rows, err := db.Query(sqlQuery)
	if err != nil {
		return
	}
	defer rows.Close()

	var year, bookRank int
	var title, genre string
	for rows.Next() {
		err = rows.Scan(&title, &genre, &year, &bookRank)
		if err != nil {
			log.Fatal(err)
		}
		result = append(result, structSelect4{title, genre, year, bookRank})
	}
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}
	return
}

type structSelect5 struct {
	title string
	year  int
	total int
}

func getSelect5(db *sql.DB) (result []structSelect5, err error) {
	sqlQuery := fmt.Sprint(`
		SELECT title, year, SUM(available_copies) OVER(PARTITION BY genre ORDER BY year ASC) AS total_copies_by_genre
		FROM cd.books JOIN cd.book_catalog ON cd.books.book_id = cd.book_catalog.book_id
		WHERE year <= 2000
		ORDER BY genre, year`)
	rows, err := db.Query(sqlQuery)
	if err != nil {
		return
	}
	defer rows.Close()

	var year, total int
	var title string
	for rows.Next() {
		err = rows.Scan(&title, &year, &total)
		if err != nil {
			log.Fatal(err)
		}
		result = append(result, structSelect5{title, year, total})
	}
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}
	return
}

type structSelect6 struct {
	lastName string
	title    string
	avg      int
}

func getSelect6(db *sql.DB) (result []structSelect6, err error) {
	sqlQuery := fmt.Sprint(`
		SELECT a.last_name, b.title, AVG(b.pages) as avg_pages
		FROM cd.authors a
		JOIN cd.books b ON a.author_id = b.author_id
		GROUP BY a.last_name, b.title
		ORDER BY a.last_name`)
	rows, err := db.Query(sqlQuery)
	if err != nil {
		return
	}
	defer rows.Close()

	var avg int
	var lastName, title string
	for rows.Next() {
		err = rows.Scan(&lastName, &title, &avg)
		if err != nil {
			log.Fatal(err)
		}
		result = append(result, structSelect6{lastName, title, avg})
	}
	if err = rows.Err(); err != nil {
		log.Fatal(err)
	}
	return
}

const (
	host   = "localhost"
	port   = 5432
	user   = "bongerka"
	dbname = "postgres"
)

func main() {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s dbname=%s sslmode=disable",
		host, port, user, dbname)

	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		log.Fatalf("could not connect to database: %v", err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}

	if _, err := getSelect1(db); err != nil {
		panic(err)
	}
}
