import 'dart:math';

import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String text;
  final String title;
  VoidCallback onDelete;
  NoteCard(
      {Key? key,
        required this.text,
        required this.onDelete,
        required this.title})
      : super(key: key);

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return (title.isEmpty)
        ? Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: getRandomColor(),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete),
        ),
      ),
    )
        : Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: getRandomColor(),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        subtitle: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}