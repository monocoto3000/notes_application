part of 'details.notes_cubit.dart';

abstract class NoteDetailsState extends Equatable {
  const NoteDetailsState();

  @override
  List<Object?> get props => [];
}

class NoteDetailsInitial extends NoteDetailsState {}

class NoteDetailsLoading extends NoteDetailsState {}

class NoteDetailsLoaded extends NoteDetailsState {
  final Note note;
  const NoteDetailsLoaded(this.note);

  @override
  List<Object?> get props => [note];
}

class NoteDetailsError extends NoteDetailsState {
  final String message;
  const NoteDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NoteDeleted extends NoteDetailsState {}