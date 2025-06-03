import 'package:dartz/dartz.dart';
import 'package:notes_application/core/error/failures.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<Note> getNoteById(int id);
  Future<Either> createNote(Note note);
  Future<Either<Failure, Note>> updateNote(int id, Note note);
  Future<Either> deleteNote(int id);
  Future<List<Note>> getNotesByCategory(int categoryId);
}