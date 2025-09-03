part of 'todo_cubit.dart';

@immutable
sealed class TodoState extends Equatable {
  final List<TodoModel> todos;

  const TodoState(this.todos);

  @override
  List<Object?> get props => [todos];
}

final class TodoInitial extends TodoState {
  TodoInitial() : super([]);
}

final class UpdateTodo extends TodoState {
  const UpdateTodo(super.todosList);
}

final class TodoError extends TodoState {
  final String message;

  const TodoError(this.message, super.todos);

  @override
  List<Object?> get props => [message, todos];
}
