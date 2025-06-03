part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;
  final Category? selectedCategory;
  final List<Category> categories;

  const NotesLoaded(this.notes, this.selectedCategory, this.categories);

  @override
  List<Object?> get props => [notes, selectedCategory, categories];
}

class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}