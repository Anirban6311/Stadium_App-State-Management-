import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../data/db_helper.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';

class NotesPage extends StatefulWidget {
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
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(
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

              return Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: loadedState.notes.length,
                  itemBuilder: (context, index) {
                    final note = loadedState.notes[index];
                    final isDeleting = deletingItems.contains(note['sno']);

                    return AnimatedSwitcher(
                      duration: Duration(seconds: 2),
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
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white24,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _showNoteDialog(
                                          context,
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
                                              child: Image.memory(
                                            base64Decode(note['img']),
                                          )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      note['title'],
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      'Created: ${note['date']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      note['desc'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.5,
                                      height: 20,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.orange),
                                          onPressed: () {
                                            _showNoteDialog(
                                              context,
                                              isUpdate: true,
                                              sno: note['sno'],
                                              title: note['title'],
                                              desc: note['desc'],
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              deletingItems.add(note['sno']);
                                            });
                                            Future.delayed(
                                                Duration(milliseconds: 500),
                                                () {
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
              return const Center(child: Text("No notes available"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          _showNoteDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showNoteDialog(BuildContext context,
      {bool isUpdate = false, int? sno, String? title, String? desc}) {
    final titleController = TextEditingController(text: title);
    final descController = TextEditingController(text: desc);
    String? pickedImage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.indigo,
              title: Text(
                isUpdate ? 'Update Note' : 'Add Note',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? imageFile =
                            await picker.pickImage(source: ImageSource.camera);
                        if (imageFile != null) {
                          final base64Image =
                              base64Encode(await imageFile.readAsBytes());
                          setState(() {
                            pickedImage = base64Image;
                          });
                        }
                      },
                      child: Text(
                        'Pick Image',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 10),
                    if (pickedImage == null)
                      Text(
                        'Image is required!',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descController.text.isNotEmpty &&
                        pickedImage != null) {
                      notesBloc.add(
                        isUpdate
                            ? UpdateNoteEvent(
                                sno: sno!,
                                title: titleController.text,
                                description: descController.text,
                              )
                            : AddNoteEvent(
                                title: titleController.text,
                                description: descController.text,
                                image: pickedImage!,
                              ),
                      );
                      Navigator.pop(context);
                    } else {
                      setState(
                          () {}); // Re-render to show validation message if needed
                    }
                  },
                  child: Text(
                    isUpdate ? 'Update' : 'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }source
}
