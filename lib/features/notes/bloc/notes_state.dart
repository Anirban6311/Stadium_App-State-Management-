// import 'package:equatable/equatable.dart';
part of 'notes_bloc.dart';

@immutable
abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesActionedState extends NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesLoadedState extends NotesState {
  final List<Map<String, dynamic>> notes;

  NotesLoadedState(this.notes);

  @override
  List<Object> get props => [notes];
}

class NotesErrorState extends NotesState {
  final String message;
  const NotesErrorState(this.message);
  @override
  List<Object> get props => [message];
}
