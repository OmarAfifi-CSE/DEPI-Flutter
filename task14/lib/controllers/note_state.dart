import 'package:flutter/foundation.dart';
import 'package:task14/models/note_model.dart';


@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);
}

class NoteError extends NoteState {
  final String message;

  NoteError(this.message);
}
