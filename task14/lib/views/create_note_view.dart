import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task14/controllers/note_cubit.dart';
import 'package:task14/models/note_model.dart';

class CreateNoteView extends StatefulWidget {
  final Note? note;

  const CreateNoteView({super.key, this.note});

  @override
  _CreateNoteViewState createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _titleController.text,
        content: _contentController.text,
      );

      final noteCubit = context.read<NoteCubit>();

      if (widget.note == null) {
        noteCubit.addNote(note);
        Navigator.pop(context);
      } else {
        noteCubit.updateNote(note);
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Create Note' : 'Edit Note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Note Title',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter note title',
                  border: OutlineInputBorder(),
                  filled: true,
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                'Content',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Enter note content',
                  border: OutlineInputBorder(),
                  filled: true,
                ),
                maxLines: 10,
                validator: (value) =>
                    value!.isEmpty ? 'Content cannot be empty' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save Note', style: TextStyle(fontSize: 16)),
              ),
              if (widget.note == null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'View Notes',
                    style: TextStyle(color: Colors.cyan),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
