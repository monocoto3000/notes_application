part of 'update.notes_cubit.dart';

abstract class UpdateNotesState extends Equatable {
  const UpdateNotesState();

  @override
  List<Object> get props => [];
}

class EditNotesInitial extends UpdateNotesState {}

class EditNotesLoading extends UpdateNotesState {}

class EditCategoriesLoaded extends UpdateNotesState {
  final List<Category> categories;
  final Note note;

  const EditCategoriesLoaded(this.categories, this.note);

  @override
  List<Object> get props => [categories, note];
}

class NoteUpdatedSuccess extends UpdateNotesState {
  final Note note;

  const NoteUpdatedSuccess(this.note);

  @override
  List<Object> get props => [note];
}

class EditNotesError extends UpdateNotesState {
  final String message;

  const EditNotesError(this.message);

  @override
  List<Object> get props => [message];
}