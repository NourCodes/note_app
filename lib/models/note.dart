import 'package:uuid/uuid.dart';
var uuid = Uuid();
class Note {
  String Title;
  String id;
  String text;
  Note(
      {required this.text,required this.Title } ): id = uuid.v4();
}