import 'package:flutter/material.dart';
import '../style/app_style.dart';
import '../models/note_model.dart';
import '../db/db_helper.dart';

Widget noteCard(Function(Note)? onTap, Note note, Function()? refreshNotes) {
  final dbHelper = DbHelper.instance;
  dbHelper.initDatabase();
  return InkWell(
    onTap: () => onTap?.call(note),
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[note.getColorId()],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5.0),
          Center(
            child: Text(
              note.getTitle(),
              style: const TextStyle(
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(note.getDate(), style: AppStyle.dateStyle),
          const SizedBox(height: 8.0),
          Expanded(
            child: Text(note.getContent(),
                style: const TextStyle(
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ),
          Expanded(
            child: Center(
              child: IconButton(
                onPressed: () async {
                  final id = note.getId();
                  dbHelper.delete(id);
                  if (refreshNotes != null) {
                    refreshNotes();
                  }
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
