part of 'todo_cubit.dart';

enum TodoStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  final TodoStatus status;
  final List<TodoModel> todos;
  final String searchQuery;
  final String? errorMessage;

  const TodoState({
    this.status = TodoStatus.initial,
    this.todos = const <TodoModel>[],
    this.searchQuery = '',
    this.errorMessage,
  });

  List<TodoModel> get filteredTodos {
    if (searchQuery.isEmpty) {
      return todos;
    } else {
      return todos
          .where(
            (todo) =>
                todo.title.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  TodoState copyWith({
    TodoStatus? status,
    List<TodoModel>? todos,
    String? searchQuery,
    String? errorMessage,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, todos, searchQuery, errorMessage];
}
