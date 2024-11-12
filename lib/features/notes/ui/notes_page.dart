import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_animation/features/notes/ui/widgets/notes_dialog.dart';
import 'package:lottie/lottie.dart';

import '../../../data/db_helper.dart';
import '../../home/ui/widgets/home_drawer.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  NotesBloc notesBloc = NotesBloc(DBHelper.getInstance);
  List<int> deletingItems = [];
  @override
  void initState() {
    notesBloc.add(FetchNotesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: const Text(
          "Task Manager",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<NotesBloc, NotesState>(
        bloc: notesBloc,
        listener: (context, state) {
          listenWhen:
          (previous, current) => current is NotesActionedState;
          buildWhen:
          (previous, current) => current is! NotesActionedState;
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case NotesLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case NotesLoadedState:
              final loadedState = state as NotesLoadedState;

              if (loadedState.notes.isEmpty) {
                return Center(
                  child: Lottie.asset(
                    'assets/animations/no_data.json',
                    repeat: true,
                    animate: true,
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: loadedState.notes.length,
                  itemBuilder: (context, index) {
                    final note = loadedState.notes[index];
                    final isDeleting = deletingItems.contains(note['sno']);

                    return AnimatedSwitcher(
                      duration: const Duration(seconds: 5),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: isDeleting
                          ? Lottie.asset(
                              'assets/animations/task_remove_animation.json',
                              key: ValueKey('delete_animation_${note['sno']}'),
                              repeat: false,
                            )
                          : Card(
                              key: ValueKey('note_card_${note['sno']}'),
                              elevation: 6,
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white24,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showNoteDialog(
                                          context,
                                          notesBloc,
                                          isUpdate: true,
                                          sno: note['sno'],
                                          title: note['title'],
                                          desc: note['desc'],
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          color: Colors.grey[300],
                                          child: Center(
                                              // Decoding the image for displaying
                                              child: Image.memory(
                                            base64Decode(note['img']),
                                          )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      note['title'],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Created: ${note['date']}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      note['desc'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1.5,
                                      height: 20,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.orange),
                                          onPressed: () {
                                            showNoteDialog(
                                              context,
                                              notesBloc,
                                              isUpdate: true,
                                              sno: note['sno'],
                                              title: note['title'],
                                              desc: note['desc'],
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              deletingItems.add(note['sno']);
                                            });
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500), () {
                                              notesBloc.add(RemoveNoteEvent(
                                                  sno: note['sno']));
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              );
            default:
              return Center(
                child: Lottie.asset(
                  'assets/animations/no_data.json',
                  repeat: true,
                  animate: true,
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          showNoteDialog(context, notesBloc);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
