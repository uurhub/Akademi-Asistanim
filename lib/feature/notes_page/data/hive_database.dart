import 'package:hive/hive.dart';

import '../models/note_page.dart';

class HiveDatabase {
  final _mybox = Hive.box("note_database");

  List<Note> loadNotes(){
    List<Note> savedNotesFormatted = [];

    if(_mybox.get("ALL_NOTES") != null){
      List<dynamic> savedNotes = _mybox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        Note individualNote = Note(
          id: savedNotes[i][0], text: savedNotes[i][1]);
          savedNotesFormatted.add(individualNote);
      }
    }else{
      savedNotesFormatted.add(Note(id: 0, text: "ilk not"));
    }

    return savedNotesFormatted;
  }

  void savedNotes(List<Note> allNotes){
    List<List<dynamic>> allNotesFormatted = [];
    for(var note in allNotes){
        int  id = note.id;
        String text = note.text;
        allNotesFormatted.add([id,text]);
      }

      _mybox.put("ALL_NOTES", allNotesFormatted);
  }
}