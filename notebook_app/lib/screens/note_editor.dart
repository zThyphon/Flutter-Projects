import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import "../style/app_style.dart";

// ignore: must_be_immutable
class NoteEditorScreen extends StatefulWidget {
  NoteEditorScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    String noteTitle = widget.doc["note_title"];
    String noteContent = widget.doc["note_content"];
    TextEditingController titleController =
        TextEditingController(text: noteTitle);
    TextEditingController contentController =
        TextEditingController(text: noteContent);

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
                  var id = widget.doc.id;
                  await FirebaseFirestore.instance
                      .collection("Notes")
                      .doc(id)
                      .delete();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
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
            Text(widget.doc["creation_date"], style: AppStyle.dateStyle),
            const SizedBox(height: 20.0),
            TextField(
              maxLines: null,
              controller: contentController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Content",
              ),
              style: AppStyle.contentStyle,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.mainColor,
        onPressed: () async {
          var id = widget.doc.id;
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

          FirebaseFirestore.instance.collection("Notes").doc(id).update({
            "note_title": updatedNoteTitle,
            "creation_date": updateDate,
            "note_content": updatedNoteContent,
            "color_id": colorId
          }).then((value) {
            Navigator.pop(context);
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
