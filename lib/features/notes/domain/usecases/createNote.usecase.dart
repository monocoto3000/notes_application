import 'package:dartz/dartz.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/injection.container.dart';

class CreateNoteUseCase implements UseCase<Either, Note> {
  @override
  Future<Either> call(Note params) async {
    return sl<NoteRepository>().createNote(params);
  }
}