class TodoModel {
  final String id;
  final String title;
  final String? description;
  final DateTime? date;
  bool? isFinished = false;

  TodoModel({
    required this.id,
    required this.title,
    this.description,
    this.date,
    this.isFinished,
  });

}
