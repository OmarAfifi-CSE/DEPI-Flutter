import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String name;
  final bool isCompleted;

  TodoModel({required this.id, required this.name, required this.isCompleted});

  @override
  List<Object?> get props => [id, name, isCompleted];

  TodoModel copyWith({String? id, String? name, bool? isCompleted}) {
    return TodoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
