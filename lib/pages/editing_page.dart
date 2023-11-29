import 'package:flutter/material.dart';
import 'package:note_app/data/hive_Db.dart';
import 'package:note_app/models/note_data.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class EditingPage extends StatefulWidget {
  Note note;
  bool isNew;
  EditingPage({super.key, required this.note, required this.isNew});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    loadExistingNote();
    super.initState();
  }

  void loadExistingNote() {
    // Load existing note text into the text controller
    _titleController.text = widget.note.Title;
    _controller.text = widget.note.text;
  }

  // Add a new note
  void addNewNote() {
    String title = _titleController.text;
    // Get text from the editor
    String text = _controller.text;
    Provider.of<NoteData>(context, listen: false).addNote(
      Note(text: text, Title: title),
    );
  }

  // Update an existing note
  void updateNote() {
    String title = _titleController.text;
    String text = _controller.text;
    Provider.of<NoteData>(context, listen: false)
        .updateNote(widget.note, text, title);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save or update the note when the save button is pressed
                    if (widget.isNew && _controller.text.isNotEmpty) {
                      addNewNote();
                    } else {
                      updateNote();
                    }
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                // You can customize this TextField as needed
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),

                  controller: _titleController,
                  maxLines: null, // Allow multiple lines
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your note";
                      }
                    },
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        hintText: "....",
                        hintStyle: TextStyle(color: Colors.grey.shade400)),

                    controller: _controller,
                    maxLines: 10, // Allow multiple lines
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
