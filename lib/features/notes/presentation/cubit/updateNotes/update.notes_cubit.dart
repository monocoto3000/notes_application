import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_application/core/usecase/noparams.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/category/domain/usecases/getAllCat.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getNoteById.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/updateNote.usecase.dart';
import 'package:dartz/dartz.dart';

part 'update.notes_state.dart';

class UpdateNotesCubit extends Cubit<UpdateNotesState> {
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;
  final GetNoteByIdUseCase _getNoteByIdUseCase;
  final UpdateNoteUseCase _updateNoteUseCase;

  UpdateNotesCubit({
    required GetAllCategoriesUseCase getAllCategoriesUseCase,
    required GetNoteByIdUseCase getNoteByIdUseCase,
    required UpdateNoteUseCase updateNoteUseCase,
  })  : _getAllCategoriesUseCase = getAllCategoriesUseCase,
        _getNoteByIdUseCase = getNoteByIdUseCase,
        _updateNoteUseCase = updateNoteUseCase,
        super(EditNotesInitial());

  Future<void> loadNoteAndCategories(int noteId) async {
    emit(EditNotesLoading());
    try {
      final categories = await _getAllCategoriesUseCase(NoParams());
      final note = await _getNoteByIdUseCase(noteId);
      emit(EditCategoriesLoaded(categories, note));
    } catch (e) {
      emit(EditNotesError('Error al cargar datos: ${e.toString()}'));
    }
  }

  Future<void> updateNote({
    required int noteId,
    required String title,
    required String content,
    required int categoryId,
  }) async {
    emit(EditNotesLoading());
    try {
      final note = Note.create(
        title: title,
        content: content,
        categoryId: categoryId,
      );
      final result = await _updateNoteUseCase(Tuple2(noteId, note));
      result.fold(
        (failure) => emit(EditNotesError(failure.message)),
        (note) => emit(NoteUpdatedSuccess(note)),
      );
    } catch (e) {
      emit(EditNotesError('Error al actualizar nota: ${e.toString()}'));
    }
  }
}