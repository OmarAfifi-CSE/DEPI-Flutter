class Review{
  String ISBN;
  String reviewer;
  String text;
  Review({ required this.ISBN,required this.reviewer,required this.text});

  @override
  String toString() {
    return 'Review{ISBN: $ISBN, reviewer: $reviewer, text: $text}';
  }
}