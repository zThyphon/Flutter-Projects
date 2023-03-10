import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import "../screens/get_started_page.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
