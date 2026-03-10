import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'book_model.dart';

class SaveJson {
  Future<void> saveBooks(List<Book> books) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonBooks = books.map((book) => jsonEncode(book.toJson())).toList();
    await prefs.setStringList('books', jsonBooks);
  }

   Future<List<Book>> loadBooks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonBooks = prefs.getStringList('books');
    if (jsonBooks != null) {
      return jsonBooks.map((jsonBook) => Book.fromJson(jsonDecode(jsonBook))).toList();
    }
    return [];
  }

  Future<void> addBook(Book book) async {
    List<Book> books = await loadBooks();
    books.add(book);
    await saveBooks(books);
  }

  Future<void> removeBook(String id) async {
    List<Book> books = await loadBooks();
    books.removeWhere((book) => book.id == id);
    await saveBooks(books);
  }

  Future<void> updateBook(Book updatedBook) async {
    List<Book> books = await loadBooks();
    int index = books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      books[index] = updatedBook;
      await saveBooks(books);
    }
  }
}
