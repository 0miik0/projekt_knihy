class Book {
  final String id;
  final String title;
  final String author;
  final int rating;
  final DateTime dateRead;
  final String notes;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.dateRead,
    required this.notes,
  });

Book.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      author = json['author'],
      rating = json['rating'],
      dateRead = DateTime.parse(json['dateRead']),
      notes = json['notes'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'rating': rating,
        'dateRead': dateRead.toIso8601String(),
        'notes': notes,
      };
}