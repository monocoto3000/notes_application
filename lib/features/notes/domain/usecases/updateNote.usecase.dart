import 'package:dartz/dartz.dart';
import 'package:notes_application/core/error/failures.dart';
import 'package:notes_application/core/usecase/usecase.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/repositories/notes.dart';
import 'package:notes_application/injection.container.dart';

class UpdateNoteUseCase implements UseCase<Either<Failure, Note>, Tuple2<int, Note>> {
  @override
  Future<Either<Failure, Note>> call(Tuple2<int, Note> params) async {
    return sl<NoteRepository>().updateNote(params.value1, params.value2);
  }
}