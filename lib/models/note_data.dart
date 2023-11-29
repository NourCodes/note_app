import 'package:flutter/cupertino.dart';
import 'package:note_app/data/hive_Db.dart';

import 'note.dart';

class NoteData extends ChangeNotifier {
  //hive database
  final db = HiveDB();

  //list of notes
  List<Note> notes = [
  ];
  void initializeNotes(){
    notes =db.loadNote();
  }


  //add a new note
  void addNote(Note note) {
    notes.add(note);
    db.saveNote(notes);
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
      db.saveNote(notes);
    }
    notifyListeners();
  }

//delete note
  void deleteNote(Note note) {
    notes.remove(note);
    db.saveNote(notes);

    notifyListeners();
  }
}