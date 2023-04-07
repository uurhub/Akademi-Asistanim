import 'package:f_44_oua/feature/home/models/note_page.dart';
import 'package:flutter/material.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({super.key, required this.isNewNote,required this.note});

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("data"),
    );
  }
}