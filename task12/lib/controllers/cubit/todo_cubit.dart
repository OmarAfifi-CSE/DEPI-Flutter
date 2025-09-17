import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final String userEmail;

  TodoCubit(this.userEmail) : super(const TodoState());

  Future<void> _saveTodos(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> todosAsMaps = todos
        .map((todo) => todo.toJson())
        .toList();
    final String todosAsString = json.encode(todosAsMaps);
    await prefs.setString(userEmail, todosAsString);
  }

  Future<void> loadTodos() async {
    emit(state.copyWith(status: TodoStatus.loading));
    final prefs = await SharedPreferences.getInstance();
    final String? todosAsString = prefs.getString(userEmail);

    if (todosAsString != null) {
      final List<dynamic> todosAsMaps = json.decode(todosAsString);
      final List<TodoModel> loadedTodos = todosAsMaps
          .map((map) => TodoModel.fromJson(map as Map<String, dynamic>))
          .toList();
      emit(state.copyWith(status: TodoStatus.success, todos: loadedTodos));
    } else {
      emit(state.copyWith(status: TodoStatus.success, todos: []));
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    final updatedTodos = List<TodoModel>.from(state.todos)..add(todo);
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    final updatedTodos = state.todos.map((todo) {
      return todo.id == updatedTodo.id ? updatedTodo : todo;
    }).toList();
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> toggleTodoStatus(String id) async {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isFinished: !todo.isFinished);
      }
      return todo;
    }).toList();
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  Future<void> deleteTodo(String id) async {
    final updatedTodos = state.todos.where((todo) => todo.id != id).toList();
    await _saveTodos(updatedTodos);
    emit(state.copyWith(todos: updatedTodos));
  }

  void searchTodos(String query) {
    emit(state.copyWith(searchQuery: query));
  }
}
