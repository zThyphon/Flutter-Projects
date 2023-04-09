import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:date_format/date_format.dart';
import "../style/app_style.dart";
import '../db/db_helper.dart';
import '../models/note_model.dart';
import 'home_screen.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note note;
  const NoteEditorScreen(this.note, {Key? key}) : super(key: key);
  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late int colorId;
  late String noteTitle;
  late String noteContent;
  late TextEditingController titleController;
  late TextEditingController contentController;

  final dbHelper = DbHelper.instance;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.getTitle());
    contentController = TextEditingController(text: widget.note.getContent());
  }

  @override
  Widget build(BuildContext context) {
    colorId = widget.note.getColorId();
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  var noteTitle = titleController.text;
                  var noteContent = contentController.text;

                  var sharedContent = "$noteTitle\n$noteContent";
                  await Share.share(sharedContent);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 15),
                      Text("Share Note", style: AppStyle.threedotitemsStyle),
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  int? id = widget.note.id;
                  await dbHelper.delete(id!);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 15),
                      Text("Delete", style: AppStyle.threedotitemsStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: AppStyle.titleStyle,
            ),
            const SizedBox(height: 8.0),
            Text(widget.note.getDate(), style: AppStyle.dateStyle),
            const SizedBox(height: 20.0),
            Expanded(
              child: TextField(
                maxLines: null,
                controller: contentController,
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
          var id = widget.note.getId();
          var updatedNoteTitle = titleController.text;
          var updatedNoteContent = contentController.text;
          String updateDate = formatDate(DateTime.now(), [
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

          dbHelper
              .updateNote(
                  id, updatedNoteTitle, updatedNoteContent, updateDate, colorId)
              .then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
