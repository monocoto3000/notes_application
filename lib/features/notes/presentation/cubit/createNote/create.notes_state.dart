part of 'create.notes_cubit.dart';

abstract class CreateNotesState extends Equatable {
  const CreateNotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends CreateNotesState {}

class NotesLoading extends CreateNotesState {}

class CategoriesLoaded extends CreateNotesState {
  final List<Category> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class NoteCreatedSuccess extends CreateNotesState {
  final Note note;

  const NoteCreatedSuccess(this.note);

  @override
  List<Object> get props => [note];
}

class NotesError extends CreateNotesState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object> get props => [message];
}