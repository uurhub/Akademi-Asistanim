import 'package:f_44_oua/feature/home/models/note_page.dart';
import 'package:f_44_oua/feature/home/models/note_page_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'editing_note_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}


class _NotePageState extends State<NotePage> {

  void createNewNote(){

  int id = Provider.of<NoteData>(context as BuildContext, listen: false).getAllNotes().length;
  
  Note newNote = Note(
    id: id, 
    text: '',
    );

    goToNotePage(newNote,true);
}

void goToNotePage(Note note, bool isNewNote){
  Navigator.push(
    context as BuildContext, 
    MaterialPageRoute(
      builder: (context) => EditingNotePage(
        note: note,
        isNewNote: false,
  ),
  ),
  );
}

void deleteNote(Note note){
  Provider.of<NoteData>(context as BuildContext, listen: false).deleteNote(note);
}


  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context,value,child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Color(0xff0F9D58),
          child: Icon(Icons.add,color: Color(0xff4285F4),),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[ 
          const Padding(
          padding: EdgeInsets.only(left: 25.0,top:75),
          child: Text("Notlarım",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        ),

        CupertinoListSection(
          children: List.generate(
            value.getAllNotes().length, 
            (index) => CupertinoListTile(
              title: Text(value.getAllNotes()[index].text)),)
          )
      ],),
    ),
  );
  }
}