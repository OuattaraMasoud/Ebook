class BookModel {
  final int id;
  final String title;
  final String author;
  final dynamic publicationYear;
  final dynamic genre;
  final String description;
  final String coverImage;
  const BookModel({
    required this.id,
    required this.author,
    required this.coverImage,
    required this.description,
    required this.genre,
    required this.publicationYear,
    required this.title,
  });
}
