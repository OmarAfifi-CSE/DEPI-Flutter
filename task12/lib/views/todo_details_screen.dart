import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
      initialDate: DateTime.now(),
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
        shadowColor: Colors.black.withValues(alpha: 0.6),
        centerTitle: true,
        title: const Text('Add Details'),
      ),
      body: SingleChildScrollView(
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {},
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
            color: Colors.black.withValues(alpha: 0.1),
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
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Enter todo title',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ),
            ),
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
