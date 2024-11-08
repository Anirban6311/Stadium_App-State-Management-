// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../data/db_helper.dart';
// import '../bloc/notes_bloc.dart';
// import '../bloc/notes_event.dart';
//
// class NotesPage extends StatefulWidget {
//   @override
//   _NotesPageState createState() => _NotesPageState();
// }
//
// class _NotesPageState extends State<NotesPage> {
//   NotesBloc notesBloc = NotesBloc(DBHelper.getInstance);
//
//   @override
//   void initState() {
//     notesBloc.add(FetchNotesEvent());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo,
//       appBar: AppBar(
//         title: Text(
//           "Task Manager",
//           style: TextStyle(fontSize: 22, color: Colors.white),
//         ),
//         backgroundColor: Colors.teal,
//       ),
//       body: BlocConsumer<NotesBloc, NotesState>(
//         bloc: notesBloc,
//         listener: (context, state) {
//           listenWhen:
//           (previous, current) => current is NotesActionedState;
//           buildWhen:
//           (previous, current) => current is! NotesActionedState;
//         },
//         builder: (context, state) {
//           switch (state.runtimeType) {
//             case NotesLoadingState:
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//
//             case NotesLoadedState:
//               final loadedState = state as NotesLoadedState;
//
//               return Container(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ListView.builder(
//                   itemCount: loadedState.notes.length,
//                   itemBuilder: (context, index) {
//                     final note = loadedState.notes[index];
//                     return Card(
//                       elevation: 6,
//                       margin: EdgeInsets.all(10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       color: Colors
//                           .white24, // Card background color similar to Container
//                       child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 _showNoteDialog(
//                                   context,
//                                   isUpdate: true,
//                                   sno: note['sno'],
//                                   title: note['title'],
//                                   desc: note['desc'],
//                                 );
//                               },
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(
//                                     15), // Rounded edges for image
//                                 child: Container(
//                                   height: 150,
//                                   width:
//                                       double.infinity, // Full width of the card
//                                   color: Colors.grey[
//                                       300], // Placeholder color for an image
//                                   child: Center(
//                                     child: Text(
//                                       'Note Preview Image', // Placeholder for image content
//                                       style: TextStyle(
//                                         color: Colors.black45,
//                                         fontSize: 18,
//                                         fontStyle: FontStyle.italic,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               note['title'],
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Text(
//                               'Created: ${note['date']}',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               note['desc'],
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Divider(
//                               thickness: 1.5,
//                               height: 20,
//                               color: Colors.grey,
//                             ),
//                             Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.edit, color: Colors.orange),
//                                   onPressed: () {
//                                     _showNoteDialog(
//                                       context,
//                                       isUpdate: true,
//                                       sno: note['sno'],
//                                       title: note['title'],
//                                       desc: note['desc'],
//                                     );
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () {
//                                     notesBloc
//                                         .add(RemoveNoteEvent(sno: note['sno']));
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//
//             default:
//               return const Center(child: Text("No notes available"));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.redAccent,
//         onPressed: () {
//           _showNoteDialog(context);
//         },
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
// // _____________________________________________________________________________________
// // -------------------------------------------------------------------------------------
// // -------------------------------------------------------------------------------------
//
//   /// widget
//   void _showNoteDialog(BuildContext context,
//       {bool isUpdate = false, int? sno, String? title, String? desc}) {
//     final titleController = TextEditingController(text: title);
//     final descController = TextEditingController(text: desc);
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           backgroundColor: Colors.indigo,
//           title: Text(
//             isUpdate ? 'Update Note' : 'Add Note',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           content: Container(
//             margin: EdgeInsets.all(10),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white24,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: titleController,
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                     labelStyle: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black54,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 TextField(
//                   controller: descController,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                     labelStyle: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black54,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blueAccent),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   maxLines: 3,
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.redAccent,
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (isUpdate) {
//                   notesBloc.add(UpdateNoteEvent(
//                     sno: sno!,
//                     title: titleController.text,
//                     description: descController.text,
//                   ));
//                 } else {
//                   notesBloc.add(AddNoteEvent(
//                     title: titleController.text,
//                     description: descController.text,
//                   ));
//                 }
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'Save',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                                            child: Text(
                                              'Note Preview Image',
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
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

    showDialog(
      context: context,
      builder: (context) {
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
          content: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty) {
                  final event = isUpdate
                      ? UpdateNoteEvent(
                          sno: sno!,
                          title: titleController.text,
                          description: descController.text,
                        )
                      : AddNoteEvent(
                          title: titleController.text,
                          description: descController.text,
                        );
                  notesBloc.add(event);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
