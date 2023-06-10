import 'package:flutter/material.dart';
import '/db/db_helper.dart';
import "../screens/get_started_page.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DbHelper.instance;
  dbHelper.initDatabase();
  runApp(const NotePage());
}

class NotePage extends StatelessWidget {
  const NotePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetStartedPage(),
    );
  }
}
