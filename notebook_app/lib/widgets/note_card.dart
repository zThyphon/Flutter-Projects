import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "../style/app_style.dart";

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc["color_id"]],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5.0),
          Center(
            child: Text(
              doc["note_title"],
              style: const TextStyle(
                  fontFamily: "Open Sans",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(doc["creation_date"], style: AppStyle.dateStyle),
          const SizedBox(height: 8.0),
          Expanded(
            child: Text(doc["note_content"],
                style: const TextStyle(
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0),
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: IconButton(
                onPressed: () {
                  var id = doc.id;
                  FirebaseFirestore.instance
                      .collection("Notes")
                      .doc(id)
                      .delete();
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
