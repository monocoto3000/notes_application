import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/injection.container.dart';

class GetNoteByIdUseCase implements UseCase<Note, int> {
  @override
  Future<Note> call(int params) async {
    return sl<NoteRepository>().getNoteById(params);
  }
}