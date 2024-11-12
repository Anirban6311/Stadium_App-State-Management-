import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hero_animation/features/notes/bloc/notes_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/notes_event.dart';

void showNoteDialog(BuildContext context, NotesBloc notesBloc,
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
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  isUpdate
                      ? SizedBox()
                      : ElevatedButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? imageFile = await picker.pickImage(
                                source: ImageSource.camera);
                            if (imageFile != null) {
                              //encoding the image for uploading
                              final base64Image =
                                  base64Encode(await imageFile.readAsBytes());
                              setState(() {
                                pickedImage = base64Image;
                              });
                            }
                          },
                          child: const Text(
                            'Pick Image',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                  const SizedBox(height: 10),
                  if (pickedImage == null && isUpdate == false)
                    const Text(
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
                    setState(() {});
                  }
                },
                child: Text(
                  isUpdate ? 'Update' : 'Add',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
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
}
