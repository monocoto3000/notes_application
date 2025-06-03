import 'package:dartz/dartz.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/injection.container.dart';

class DeleteNoteUseCase implements UseCase<Either, int> {
  @override
  Future<Either> call(int params) async {
    return sl<NoteRepository>().deleteNote(params);
  }
}