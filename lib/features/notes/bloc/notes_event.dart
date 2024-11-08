import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch all notes from the database
class FetchNotesEvent extends NotesEvent {}

// Event to add a new note
class AddNoteEvent extends NotesEvent {
  final String title;
  final String description;

  const AddNoteEvent({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

// Event to update an existing note

class UpdateNoteEvent extends NotesEvent {
  final int sno;
  final String title;
  final String description;

  UpdateNoteEvent(
      {required this.sno, required this.title, required this.description});
// here id is also compared as the id remains the same after updation or deletion
  @override
  List<Object> get props => [sno, title, description];
}

class RemoveNoteEvent extends NotesEvent {
  final int sno;
  RemoveNoteEvent({required this.sno});

  @override
  List<Object> get props => [sno];
}
