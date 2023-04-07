import 'package:f_44_oua/feature/home/models/note_page.dart';
import 'package:flutter/material.dart';

class NoteData extends ChangeNotifier{
  List<Note> allNotes = [
    Note(id: 0, text: 'İlk Notum'),
  ];


  List<Note> getAllNotes(){
    return allNotes;
  }

  void addNewNote(Note note){
    allNotes.add(note);
    notifyListeners();
  }

  void updateNote(Note note,String text){
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deleteNote(Note note){
    allNotes.remove(note);
    notifyListeners();
  }
}