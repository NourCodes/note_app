import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/models/note_data.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive
  await Hive.initFlutter();
  //open hive box
  await Hive.openBox("note");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) =>  MaterialApp(
        theme: ThemeData(
          fontFamily: "OpenSans",
        ),
        debugShowCheckedModeBanner: false,
          home: HomePage(),

      ),
    );
  }
}
