import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_application/features/notes/data/models/notes.model.dart';
import 'package:notes_application/features/notes/domain/usecases/deleteNote.usecase.dart';
import 'package:notes_application/features/notes/domain/usecases/getNoteById.usecase.dart';

part 'details.notes_state.dart';

class NoteDetailsCubit extends Cubit<NoteDetailsState> {
  final GetNoteByIdUseCase _getNoteById;
  final DeleteNoteUseCase _deleteNote;

  NoteDetailsCubit({
    required GetNoteByIdUseCase getNoteById,
    required DeleteNoteUseCase deleteNote,
  })  : _getNoteById = getNoteById,
        _deleteNote = deleteNote,
        super(NoteDetailsInitial());

  Future<void> loadNote(int noteId) async {
    emit(NoteDetailsLoading());
    try {
      final note = await _getNoteById(noteId);
      emit(NoteDetailsLoaded(note));
    } catch (e) {
      emit(NoteDetailsError('Error al cargar la nota: ${e.toString()}'));
    }
  }

  Future<void> deleteNote(int noteId) async {
    emit(NoteDetailsLoading());
    try {
      final result = await _deleteNote(noteId);
      emit(NoteDeleted());
    } catch (e) {
      emit(NoteDetailsError('Error al eliminar la nota: ${e.toString()}'));
    }
  }
}