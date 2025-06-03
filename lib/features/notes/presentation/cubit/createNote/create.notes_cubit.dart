import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_application/core/usecase/noparams.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/category/domain/usecases/getAllCat.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/createNote.usecase.dart';

part 'create.notes_state.dart';

class CreateNotesCubit extends Cubit<CreateNotesState> {
  final CreateNoteUseCase _createNoteUseCase;
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  CreateNotesCubit({
    required CreateNoteUseCase createNoteUseCase,
    required GetAllCategoriesUseCase getAllCategoriesUseCase,
  })  : _createNoteUseCase = createNoteUseCase,
        _getAllCategoriesUseCase = getAllCategoriesUseCase,
        super(NotesInitial());

  Future<void> loadCategories() async {
    emit(NotesLoading());
    try {
      final categories = await _getAllCategoriesUseCase(NoParams());
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(NotesError('Error al cargar categorías: ${e.toString()}'));
    }
  }

  Future<void> createNote({
    required String title,
    required String content,
    required int categoryId,
  }) async {
    emit(NotesLoading());
    try {
      final note = Note.create(
        title: title,
        content: content,
        categoryId: categoryId,
      );
      
      final result = await _createNoteUseCase(note);
      
      result.fold(
        (failure) => emit(NotesError(failure.message)),
        (note) => emit(NoteCreatedSuccess(note)),
      );
    } catch (e) {
      emit(NotesError('Error al crear nota: ${e.toString()}'));
    }
  }
}