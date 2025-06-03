import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/injection.container.dart';

class GetNotesByCatUseCase implements UseCase<List<Note>, int> {
  @override
  Future<List<Note>> call(int params) async {
    return sl<NoteRepository>().getNotesByCategory(params);
  }
}