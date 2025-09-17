import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime? date;
  final bool isFinished;

  const TodoModel({
    required this.id,
    required this.title,
    this.description,
    this.date,
    this.isFinished = false,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isFinished,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date?.toIso8601String(),
      'isFinished': isFinished,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : null,
      isFinished: json['isFinished'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [id, title, description, date, isFinished];
}
