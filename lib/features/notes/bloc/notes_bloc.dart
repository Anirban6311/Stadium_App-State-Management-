import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/db_helper.dart';
import 'notes_event.dart';

part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final DBHelper dbHelper;
  NotesBloc(this.dbHelper) : super(NotesInitialState()) {
    on<FetchNotesEvent>(fetchNotesEvent);
    on<AddNoteEvent>(addNoteEvent);
    on<UpdateNoteEvent>(updateNoteEvent);
    on<RemoveNoteEvent>(removeNoteEvent);
  }

  FutureOr<void> fetchNotesEvent(
      FetchNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    try {
      final notes = await dbHelper.getAllNotes();
      emit(NotesLoadedState(notes));
    } catch (e) {
      print('Error loading notes $e');
    }
  }

  FutureOr<void> addNoteEvent(
      AddNoteEvent event, Emitter<NotesState> emit) async {
    try {
      final success = await dbHelper.addNote(
          mTitle: event.title, mDesc: event.description, mImage: event.image);
      //if the note is added successfully
      if (success) {
        //reload the state of getallnotes
        final notes = await dbHelper.getAllNotes();
        emit(NotesLoadedState(notes));
      } else {
        print("Failed to add note");
      }
    } catch (e) {
      print("The note cannot be added $e");
    }
  }

  FutureOr<void> updateNoteEvent(
      UpdateNoteEvent event, Emitter<NotesState> emit) async {
    try {
      //getting response of the updation of notes first
      final success = await dbHelper.updateNotes(
          mTitle: event.title, mDesc: event.description, sno: event.sno);
      if (success) {
        final notes = await dbHelper.getAllNotes();
        emit(NotesLoadedState(notes));
      } else {
        print("failed updating the notes");
      }
    } catch (e) {
      print("The note cannot be updated $e");
    }
  }

  FutureOr<void> removeNoteEvent(
      RemoveNoteEvent event, Emitter<NotesState> emit) async {
    try {
      //getting response for the deletion of notes
      final rows_deleted = await dbHelper.removeNotes(event.sno);
      if (rows_deleted > 0) {
        final notes = await dbHelper.getAllNotes();
        emit(NotesLoadedState(notes));
      } else {
        print("failed fetching the notes after removal");
      }
    } catch (e) {
      print("The note cannot be removed $e");
    }
  }
}
