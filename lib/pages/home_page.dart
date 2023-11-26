import 'package:flutter/material.dart';
import 'package:note_app/components/searchfield.dart';
import 'package:provider/provider.dart';
import '../components/customizedtitlebar.dart';
import '../components/note_card.dart';
import '../models/note.dart';
import '../models/note_data.dart';
import 'editing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void createNewNote() {
    //create a new note
    Note newNote = Note(text: '', Title: '');
    //go to edit and create the note
    goToPage(newNote, true);
  }

//go to edit note Page
  void goToPage(Note note, bool isNew) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditingPage(
          note: note,
          isNew: isNew,
        ),
      ),
    );
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            children: [
              const CustomizedTitleBar(),
              const SizedBox(
                height: 20,
              ),
              const Search(),
              Expanded(
                child: ListView.builder(
                  itemCount: value.getAllNotes().length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => goToPage(value.getAllNotes()[index], false),
                      child: NoteCard(
                        text: value.getAllNotes()[index].text,
                        onDelete: () => deleteNote(value.getAllNotes()[index]),
                        title: value.getAllNotes()[index].Title,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade50,
          onPressed: createNewNote,
          child: Icon(
            Icons.add,
            size: 35,
            color: Colors.grey.shade900,
          ),
        ),
      ),
    );
  }
}