import 'package:notes_application/core/usecase/noparams.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/injection.container.dart';

class GetAllNotesUseCase implements UseCase<List<Note>, NoParams> {
  @override
  Future<List<Note>> call(NoParams params) async {
    return sl<NoteRepository>().getAllNotes();
  }
}