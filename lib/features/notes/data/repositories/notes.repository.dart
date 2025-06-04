import 'package:dartz/dartz.dart';
import 'package:notes_application/core/error/failures.dart';
import 'package:notes_application/features/notes/data/datasources/notes.api.service.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/injection.container.dart';


class NoteRepositoryImpl extends NoteRepository {
  @override
  Future<List<Note>> getAllNotes() {
    return sl<NoteApiService>().getAllNotes();
  }

  @override
  Future<Note> getNoteById(int id) {
    return sl<NoteApiService>().getNoteById(id);
  }

  @override
  Future<Either> createNote(Note note) {
    return sl<NoteApiService>().createNote(note);
  }

  @override
  Future<Either<Failure, Note>> updateNote(int id, Note note) async {
    final either = await sl<NoteApiService>().updateNote(id, note);
    return either.fold(
      (failure) => Left(failure),
      (data) => Right(data), 
    );
  }

  @override
  Future<Either> deleteNote(int id) {
    return sl<NoteApiService>().deleteNote(id);
  }

  @override
  Future<List<Note>> getNotesByCategory(int categoryId) {
    return sl<NoteApiService>().getNotesByCategory(categoryId);
  }
}