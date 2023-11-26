import 'package:flutter/cupertino.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  //list of notes
  List<Note> notes = [
    Note(text: " note", Title: "first note"),
  ];

  //add a new note
  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }

  //get all notes
  List<Note> getAllNotes() {
    return notes;
  }
//update note

  void updateNote(Note note, String text, String title) {
    for (int i = 0; i < notes.length; i++) {
      //find note through id
      if (notes[i].id == note.id) {
        //replace text
        notes[i].Title = title;
        notes[i].text = text;
      }
    }
    notifyListeners();
  }

//delete note
  void deleteNote(Note note) {
    notes.remove(note);
    notifyListeners();
  }
}