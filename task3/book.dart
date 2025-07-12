class Book{
  String ISBN;
  String title;
  double rating;
  Book({ required this.ISBN,required this.title,required this.rating});

  @override
  String toString() {
    return 'Book{ISBN: $ISBN, title: $title, rating: $rating}';
  }
}