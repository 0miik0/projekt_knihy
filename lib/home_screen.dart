import 'package:flutter/material.dart';
import 'save_json.dart';
import 'book_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> books = [];
  final SaveJson saveJson = SaveJson();

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    List<Book> loadedBooks = await saveJson.loadBooks();
    setState(() {
      books = loadedBooks;
    });
  }

  Future<void> removeBook(String id) async {
    await saveJson.removeBook(id);
    loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        backgroundColor: Color.fromARGB(255, 218, 255, 248),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Author: ${book.author}'),
                Text('Rating: ${book.rating}', style: TextStyle(color: _getRatingColor(book.rating))), //stars better
                Text('Date Read: ${_formatDate(book.dateRead)}'),
                Text('Notes: ${book.notes}'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showDeleteDialog(book),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime? date) {
    return date != null ? '${date.day}/${date.month}/${date.year}' : 'N/A';
    }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }  

  void _showDeleteDialog(Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Book'),
        content: Text('Are you sure you want to delete "${book.title}"?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              removeBook(book.id);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}