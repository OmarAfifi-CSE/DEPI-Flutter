import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';
import 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final CollectionReference _notesCollection =
  FirebaseFirestore.instance.collection('notes');
  StreamSubscription? _notesSubscription;

  NoteCubit() : super(NoteInitial());

  void getNotes() {
    try {
      emit(NoteLoading());
      _notesSubscription?.cancel();
      _notesSubscription = _notesCollection
          .snapshots()
          .listen((snapshot) {
        final notes =
        snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
        emit(NoteLoaded(notes));
      });
    } catch (e) {
      emit(NoteError('Failed to fetch notes: $e'));
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await _notesCollection.add(note.toMap());
    } catch (e) {
      emit(NoteError('Failed to add note: $e'));
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await _notesCollection.doc(note.id).update(note.toMap());
    } catch (e) {
      emit(NoteError('Failed to update note: $e'));
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _notesCollection.doc(noteId).delete();
    } catch (e) {
      emit(NoteError('Failed to delete note: $e'));
    }
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
