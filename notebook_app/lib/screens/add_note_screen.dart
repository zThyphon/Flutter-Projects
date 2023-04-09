import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import "../style/app_style.dart";
import '../models/note_model.dart';
import '../db/db_helper.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    int colorId = Random().nextInt(AppStyle.cardsColor.length);
    String date = formatDate(DateTime.now(), [
      "dd",
      '/',
      "mm",
      '/',
      "yyyy",
      ' ',
      "HH",
      ':',
      "mm",
    ]).toString();

    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add a New Note",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Open Sans",
            fontSize: 23.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: AppStyle.titleStyle,
            ),
            const SizedBox(height: 8.0),
            Text(date, style: AppStyle.dateStyle),
            const SizedBox(height: 28.0),
            Expanded(
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Content",
                ),
                style: AppStyle.contentStyle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.mainColor,
        onPressed: () async {
          final note = Note(
            null,
            titleController.text,
            contentController.text,
            date,
            colorId,
          );

          await DbHelper.instance.addNote(note);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
