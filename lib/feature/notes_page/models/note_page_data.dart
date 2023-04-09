import 'package:f_44_oua/feature/notes_page/data/hive_database.dart';
import 'package:f_44_oua/feature/notes_page/models/note_page.dart';
import 'package:flutter/material.dart';

class NoteData extends ChangeNotifier{

  final db = HiveDatabase();

  List<Note> allNotes = [];

  void initializeNotes(){
    allNotes = db.loadNotes();
  }

  List<Note> getAllNotes(){
    return allNotes;
  }

  void addNewNote(Note note){
    allNotes.add(note);
    notifyListeners();
    db.savedNotes(allNotes);
  }

  void updateNote(Note note,String text){
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
    db.savedNotes(allNotes);
  }

  void deleteNote(Note note){
    allNotes.remove(note);
    notifyListeners();
    db.savedNotes(allNotes);
  }
}