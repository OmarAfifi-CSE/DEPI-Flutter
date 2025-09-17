import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:task12/controllers/cubit/todo_cubit.dart';
import 'package:task12/models/todo_model.dart';

class TodoDetailsScreen extends StatefulWidget {
  final TodoModel? todo;

  const TodoDetailsScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description ?? '';
      if (widget.todo!.date != null) {
        _dateController.text = DateFormat(
          'MM/dd/yyyy',
        ).format(widget.todo!.date!);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.todo?.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blueAccent),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.1,
        elevation: 0.1,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        centerTitle: true,
        title: Text(widget.todo == null ? 'Add Details' : 'Edit Details'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTodoTitle(),
                const SizedBox(height: 16),
                _buildTodoDescription(),
                const SizedBox(height: 16),
                _buildTodoDeadlineDate(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (widget.todo == null) {
                  final newTodo = TodoModel(
                    id: const Uuid().v4(),
                    title: _titleController.text,
                    description: _descriptionController.text.isNotEmpty
                        ? _descriptionController.text
                        : null,
                    date: _dateController.text.isNotEmpty
                        ? DateFormat('MM/dd/yyyy').parse(_dateController.text)
                        : null,
                  );
                  context.read<TodoCubit>().addTodo(newTodo);
                } else {
                  final updatedTodo = widget.todo!.copyWith(
                    title: _titleController.text,
                    description: _descriptionController.text.isNotEmpty
                        ? _descriptionController.text
                        : null,
                    date: _dateController.text.isNotEmpty
                        ? DateFormat('MM/dd/yyyy').parse(_dateController.text)
                        : null,
                  );
                  context.read<TodoCubit>().updateTodo(updatedTodo);
                }
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              fixedSize: Size(MediaQuery.sizeOf(context).width, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTodoTitle() {
    return _buildCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Todo Title'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Enter todo title',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Title cannot be empty';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTodoDescription() {
    return _buildCustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Description'),
          const SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Enter description',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoDeadlineDate(BuildContext context) {
    return _buildCustomContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.calendar_today, color: Colors.grey),
          const SizedBox(width: 8),
          const Text('Deadline'),
          const Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                hintText: 'mm/dd/yyyy',
                suffixIcon: Icon(Icons.calendar_today_outlined),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
