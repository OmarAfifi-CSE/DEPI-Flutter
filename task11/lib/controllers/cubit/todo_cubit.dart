import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';
import 'package:task11/models/todo_model.dart';

part 'todo_state.dart';

var uuid = const Uuid();

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  void addTodo(String title) {
    if (title.isEmpty) {
      emit(TodoError('Todo cannot be empty!', state.todos));
      return;
    }

    final todo = TodoModel(id: uuid.v4(), name: title, isCompleted: false);
    emit(UpdateTodo([...state.todos, todo]));
  }

  void removeTodo(String id) {
    final updatedTodos = state.todos.where((todo) => todo.id != id).toList();
    emit(UpdateTodo(updatedTodos));
  }

  void toggleTodo(String id) {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(UpdateTodo(updatedTodos));
  }

  void clearError() {
    if (state is TodoError) {
      emit(UpdateTodo(state.todos));
    }
  }

  int get totalTodos => state.todos.length;

  int get completedTodos =>
      state.todos.where((todo) => todo.isCompleted).length;

  int get remainingTodos => totalTodos - completedTodos;
}
