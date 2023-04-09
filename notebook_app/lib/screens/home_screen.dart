import 'package:flutter/material.dart';
import "../screens/add_note_screen.dart";
import "../screens/note_editor.dart";
import "../style/app_style.dart";
import '../db/db_helper.dart';
import '../widgets/note_card.dart';
import "../models/note_model.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> _notesFuture;
  var dbHelper = DbHelper.instance;
  @override
  void initState() {
    super.initState();
    _notesFuture = dbHelper.getNotes();
  }

  void refreshNotes() {
    setState(() {
      _notesFuture = dbHelper.getNotes();
    });
  }

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
              child: FutureBuilder<List<dynamic>>(
                future: _notesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: snapshot.data!
                          .map((note) => noteCard((Note note) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NoteEditorScreen(note),
                                    ));
                              }, Note.fromMap(note), refreshNotes))
                          .toList(),
                    );
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
