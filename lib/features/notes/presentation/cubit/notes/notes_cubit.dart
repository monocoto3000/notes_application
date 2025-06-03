import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_application/core/usecase/noparams.dart';
import 'package:notes_application/features/category/data/models/category.model.dart';
import 'package:notes_application/features/category/domain/usecases/getAllCat.usecase.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/usecases/getAllNotes.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getNotesByCat.usecase.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetAllNotesUseCase _getAllNotes;
  final GetNotesByCatUseCase _getNotesByCategory;
  final GetAllCategoriesUseCase _getAllCategories;

  NotesCubit({
    required GetAllNotesUseCase getAllNotes,
    required GetNotesByCatUseCase getNotesByCategory,
    required GetAllCategoriesUseCase getAllCategories,
  })  : _getAllNotes = getAllNotes,
        _getNotesByCategory = getNotesByCategory,
        _getAllCategories = getAllCategories,
        super(NotesInitial());

  Future<void> loadData() async {
    emit(NotesLoading());
    try {
      final categories = await _getAllCategories.call(NoParams());
      final notes = await _getAllNotes.call(NoParams());
      emit(NotesLoaded(notes, null, categories));
    } catch (e) {
      emit(NotesError('Error al cargar notas: ${e.toString()}'));
    }
  }

  Future<void> selectCategory(Category? category) async {
    if (state is! NotesLoaded) return;

    final currentState = state as NotesLoaded;
    emit(NotesLoading());

    try {
      if (category == null) {
        final notes = await _getAllNotes.call(NoParams());
        emit(NotesLoaded(notes, null, currentState.categories));
      } else {
        final notes = await _getNotesByCategory.call(category.id);
        emit(NotesLoaded(notes, category, currentState.categories));
      }
    } catch (e) {
      emit(NotesError('Error al filtrar por categoría: ${e.toString()}'));
      emit(NotesLoaded(currentState.notes, currentState.selectedCategory, currentState.categories));
    }
  }
}