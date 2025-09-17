import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task12/controllers/cubit/todo_cubit.dart';
import 'package:task12/views/todo_details_screen.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchActive = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(widget.email)..loadTodos(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xffF9FAFF),
            appBar: AppBar(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0.1,
              elevation: 0.1,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.black.withValues(alpha: 0.6),
              title: _isSearchActive
                  ? TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Search todos...',
                        border: InputBorder.none,
                      ),
                      onChanged: (query) {
                        context.read<TodoCubit>().searchTodos(query);
                      },
                    )
                  : const Text('My Todos'),
              centerTitle: true,
              actions: [
                BlocBuilder<TodoCubit, TodoState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: Icon(_isSearchActive ? Icons.close : Icons.search),
                      onPressed: () {
                        setState(() {
                          _isSearchActive = !_isSearchActive;
                          if (!_isSearchActive) {
                            _searchController.clear();
                            context.read<TodoCubit>().searchTodos('');
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.blueAccent),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Logged in as',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          widget.email,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            body: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state.status == TodoStatus.loading ||
                    state.status == TodoStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.filteredTodos.isEmpty) {
                  return Center(
                    child: Text(
                      _isSearchActive
                          ? 'No results found.'
                          : 'No todos yet. Add one!',
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: state.filteredTodos.length,
                  itemBuilder: (context, index) {
                    final todo = state.filteredTodos[index];
                    return Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 0.3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<TodoCubit>(context),
                                child: TodoDetailsScreen(todo: todo),
                              ),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        leading: Checkbox(
                          value: todo.isFinished,
                          activeColor: Colors.blueAccent,
                          onChanged: (bool? newValue) {
                            context.read<TodoCubit>().toggleTodoStatus(todo.id);
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isFinished
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<TodoCubit>().deleteTodo(todo.id);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: Builder(
              builder: (context) {
                return FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<TodoCubit>(context),
                          child: const TodoDetailsScreen(),
                        ),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.add, color: Colors.white),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
