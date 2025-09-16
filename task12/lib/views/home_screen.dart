import 'package:flutter/material.dart';
import 'package:task12/views/todo_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.1,
        elevation: 0.1,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withValues(alpha: 0.6),
        centerTitle: true,
        title: const Text('My Todos'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: 50,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0.3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                leading: Checkbox(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  activeColor: Colors.blueAccent,
                  checkColor: Colors.white,
                  value: checkBoxValue,
                  onChanged: (bool? newValue) {
                    setState(() {
                      checkBoxValue = newValue!;
                    });
                  },
                ),
                title: Text('Omar'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const TodoDetailsScreen()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        elevation: 3,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
