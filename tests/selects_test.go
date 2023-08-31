package tests

import (
	"github.com/DATA-DOG/go-sqlmock" // в данном проекте нецелесообразно использовать testscontainers
	_ "github.com/lib/pq"
	"testing"
)

func TestSelect1(t *testing.T) {
	testCases := []structSelect1{
		{2, "роман", 3},
	}
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()

	rows := mock.NewRows([]string{"author_id", "genre", "num_books"})
	for i := range testCases {
		rows.AddRow(testCases[i].authorId, testCases[i].genre, testCases[i].numBooks)
	}
	mock.ExpectQuery("SELECT").WillReturnRows(rows)
	res, err := getSelect1(db)
	if err != nil {
		t.Errorf("error was not expected while updating stats: %s", err)
	}
	for i, expect := range testCases {
		if expect.numBooks != res[i].numBooks || expect.authorId != res[i].authorId || expect.genre != res[i].genre {
			t.Error()
		}
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("there were unfulfilled expectations: %s", err)
	}
}

func TestSelect2(t *testing.T) {
	testCases := []structSelect2{
		{1, 1},
	}
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()

	rows := mock.NewRows([]string{"reader_id", "num_books"})
	for i := range testCases {
		rows.AddRow(testCases[i].readerId, testCases[i].numRentals)
	}
	mock.ExpectQuery("SELECT").WillReturnRows(rows)

	res, err := getSelect2(db)
	if err != nil {
		t.Errorf("error was not expected while updating stats: %s", err)
	}
	for i, expect := range testCases {
		if expect.numRentals != res[i].numRentals || expect.readerId != res[i].readerId {
			t.Error()
		}
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("there were unfulfilled expectations: %s", err)
	}
}

func TestSelect3(t *testing.T) {
	testCases := []structSelect3{
		{2, "Преступление и наказание", 6},
		{1, "Идиот", 3},
	}
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()

	rows := mock.NewRows([]string{"book_id", "title", "num_copies_available"})
	for i := range testCases {
		rows.AddRow(testCases[i].bookId, testCases[i].title, testCases[i].numCopiesAvailable)
	}
	mock.ExpectQuery("SELECT").WillReturnRows(rows)

	res, err := getSelect3(db)
	if err != nil {
		t.Errorf("error was not expected while updating stats: %s", err)
	}
	for i, expect := range testCases {
		if expect.bookId != res[i].bookId || expect.title != res[i].title ||
			expect.numCopiesAvailable != res[i].numCopiesAvailable {
			t.Error()
		}
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("there were unfulfilled expectations: %s", err)
	}
}

func TestSelect4(t *testing.T) {
	testCases := []structSelect4{
		{"Преступление и наказание", "роман", 1866, 3},
		{"Идиот", "роман", 1869, 2},
		{"Братья Карамазовы", "роман", 1880, 3},
	}
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()

	rows := mock.NewRows([]string{"title", "genre", "year", "book_rank"})
	for _, value := range testCases {
		rows.AddRow(value.title, value.genre, value.year, value.bookRank)
	}
	mock.ExpectQuery("SELECT").WillReturnRows(rows)

	res, err := getSelect4(db)
	if err != nil {
		t.Errorf("error was not expected while updating stats: %s", err)
	}
	for i, expect := range testCases {
		if expect.title != res[i].title || expect.genre != res[i].genre || expect.year != res[i].year ||
			expect.bookRank != res[i].bookRank {
			t.Error()
		}
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("there were unfulfilled expectations: %s", err)
	}
}

func TestSelect5(t *testing.T) {
	testCases := []structSelect5{
		{"Преступление и наказание", 1866, 6},
		{"Идиот", 1869, 9},
	}
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()

	rows := mock.NewRows([]string{"title", "year", "total_copies_by_genre"})
	for _, value := range testCases {
		rows.AddRow(value.title, value.year, value.total)
	}
	mock.ExpectQuery("SELECT").WillReturnRows(rows)

	res, err := getSelect5(db)
	if err != nil {
		t.Errorf("error was not expected while updating stats: %s", err)
	}
	for i, expect := range testCases {
		if expect.title != res[i].title || expect.year != res[i].year ||
			expect.total != res[i].total {
			t.Error()
		}
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("there were unfulfilled expectations: %s", err)
	}
}

func TestSelect6(t *testing.T) {
	testCases := []structSelect6{
		{"Достоевский", "Преступление и наказание", 824},
		{"Достоевский", "Идиот", 656},
		{"Достоевский", "Братья Карамазовы", 551},
	}
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()

	rows := mock.NewRows([]string{"last_name", "title", "avg_pages"})
	for i := range testCases {
		rows.AddRow(testCases[i].lastName, testCases[i].title, testCases[i].avg)
	}
	mock.ExpectQuery("SELECT").WillReturnRows(rows)

	res, err := getSelect6(db)
	if err != nil {
		t.Errorf("error was not expected while updating stats: %s", err)
	}
	for i, expect := range testCases {
		if expect.lastName != res[i].lastName || expect.title != res[i].title ||
			expect.avg != res[i].avg {
			t.Error()
		}
	}

	if err := mock.ExpectationsWereMet(); err != nil {
		t.Errorf("there were unfulfilled expectations: %s", err)
	}
}
