import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "../screens/add_note_screen.dart";
import "../screens/note_editor.dart";
import "../style/app_style.dart";

import '../widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.lightBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppStyle.mainColor,
        elevation: 0.0,
        title: const Text("My Notes", style: AppStyle.headerStyle),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    int notesCount = snapshot.data!.docs.length;
                    if (notesCount > 0) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((note) => noteCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NoteEditorScreen(note),
                                      ));
                                }, note))
                            .toList(),
                      );
                    }
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 210),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Image.asset(
                                "images/empty_page_image.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              "No Notes :(",
                              style: AppStyle.headerStyle,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "You have no notes.",
                              style: TextStyle(
                                fontFamily: "Open Sans",
                                fontSize: 20,
                                color: AppStyle.mainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppStyle.mainColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (content) => const AddNoteScreen()));
        },
        label: const Text("Add Note", style: AppStyle.headerStyle),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
