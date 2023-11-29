import 'package:flutter/material.dart';
import 'package:note_app/components/searchfield.dart';
import 'package:note_app/data/hive_Db.dart';
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
  final _searchController = TextEditingController();
  List<Note> filteredNote = [];

  @override
  void initState() {
    Provider.of<NoteData>(context, listen: false).initializeNotes();
    filteredNote = Provider.of<NoteData>(context, listen: false).getAllNotes();
    super.initState();
  }

  //hive db
  final db = HiveDB();

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

  void filter(String text) {
    List<Note> result = [];
    if (text.isEmpty) {
      //if empty the list is set to all the notes

      result = Provider.of<NoteData>(context, listen: false).getAllNotes();
    } else {
      result = (Provider.of<NoteData>(context, listen: false)
          .getAllNotes()
          .where((element) =>
              element.text.toLowerCase().contains(text) ||
              element.Title.toLowerCase().contains(text))).toList();
    }
    setState(() {
      filteredNote = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomizedTitleBar(),
              Text("${value.getAllNotes().length} notes",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                  )),
              const SizedBox(
                height: 20,
              ),
              Search(
                  onSearch: (text) => filter(_searchController.text),
                  searchController: _searchController),
              filteredNote.length == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Center(
                          child: Text(
                        "Not Found",
                        style: TextStyle(color: Colors.grey.shade400),
                      )),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: filteredNote.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => goToPage(filteredNote[index], false),
                            child: NoteCard(
                              text: filteredNote[index].text,
                              onDelete: () => deleteNote(filteredNote[index]),
                              title: filteredNote[index].Title,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade600,
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
