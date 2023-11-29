import 'package:hive/hive.dart';

import '../models/note.dart';

class HiveDB {
  //reference hive box
  var box = Hive.box("note");


  //load note
  List<Note> loadNote() {
    //list that will be returned
    List<Note> savedNote = [];
    //if there is notes return it else return empty list
    if (box.get("ALL_NOTES") != null) {
      List allNotes = box.get("ALL_NOTES");

      for (int i = 0; i < allNotes.length; i++) {
        //create note object
        Note newNote = Note(
          Title: allNotes[i][0],
          text: allNotes[i][1],
        );
        //add note object to list that will be returned
        savedNote.add(newNote);
      }
    }
    return savedNote;

  }


  //save note
  void saveNote(List<Note> notes) {
    //[  ...., [first note, note], ....  ]
    List<List<dynamic>> allNotes = [];

    for (var note in notes) {
      String title = note.Title;
      String text = note.text;
      allNotes.add([title, text]);
    }
    //store list in the ALL_NOTES key
    box.put("ALL_NOTES", allNotes);
  }
}
