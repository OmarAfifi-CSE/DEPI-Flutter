import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task11/controllers/cubit/todo_cubit.dart';
import 'package:task11/views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: HomeScreen(),
      ),
    );
  }
}
